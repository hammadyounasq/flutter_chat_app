import 'package:chatmessengerapp/components/my_text_field.dart';
import 'package:chatmessengerapp/service/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../components/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key,required this.receiverUserEmail,required this.receiverUserId});
  final String receiverUserEmail;
  final String receiverUserId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  
  final TextEditingController _messageController=TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  void sendMessage()async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.receiverUserId, _messageController.text);
      _messageController.clear();
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey[800],title: Text(widget.receiverUserEmail,),),
      body: Column(children: [
        Expanded(child:_buildMessageList() ,),

        _buildMessageInput(),
        SizedBox(height: 25,),
      ],),
    );
  }

  // build message list
Widget _buildMessageList(){
  return StreamBuilder(
    stream: _chatService.getMessage(widget.receiverUserId, _firebaseAuth.currentUser!.uid),
    builder: (context,snapshot){
       print(snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList());
      if(snapshot.hasError){
        return Text('Error'+snapshot.error.toString());
      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return Text('Loading..');

      }
      return ListView(
        children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
        
      );
     
    },
    );
}

  // build message item

  Widget _buildMessageItem(DocumentSnapshot document){
    Map<String,dynamic> data=document.data() as Map<String,dynamic>;
    // align the message to the right if the sender is the current user ,otherwise to the left 
     var alignment=(data['senderId']==_firebaseAuth.currentUser!.uid)? Alignment.centerRight:Alignment.centerLeft;
     return Container(
       alignment: alignment,
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           crossAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)?CrossAxisAlignment.end:CrossAxisAlignment.start,
          mainAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)?MainAxisAlignment.end :MainAxisAlignment.start
         ,children: [
           Text(data['senderEmail']),
           SizedBox(height: 5,),
           ChatBubble(message: data['message'],color: (data['senderId']==_firebaseAuth.currentUser!.uid)? Color.fromARGB(255, 38, 181, 2):Colors.black87),
          
         ],),
       ),
     );
  }


  // build message input 
  Widget _buildMessageInput(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      children: [
        Expanded(child: MyTextField(
          controller: _messageController,
          hindText: 'Enter message',
          obscureText: false,
  
        ),),
  
        // send button
        IconButton(onPressed: sendMessage, icon: Icon(Icons.send,size: 40,),),
    ],
    ),
  );
    
  }
}