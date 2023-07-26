

import 'package:chatmessengerapp/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final FirebaseAuth _auth=FirebaseAuth.instance;

  void signOut()async{
    final authservice=Provider.of<AuthService>(context,listen: false);

      await authservice.signout();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey[800],title: Text('Home Page'),actions: [IconButton(onPressed: signOut, icon: Icon(Icons.login))],),
      body: _buildUserList(),
    );
  }

Widget _buildUserList(){
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context,snapshot){
      if(snapshot.hasError){
        return Text('erroe');

      }
      if(snapshot.connectionState==ConnectionState.waiting){
        return Text('loading');
      }
      return ListView(
        children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
      );
    });


}
         Widget _buildUserListItem(DocumentSnapshot document){
       Map<String,dynamic>  data=document.data()! as Map<String,dynamic>;

       if(_auth.currentUser!.email !=data['email']){
         return ListTile(
           title:Text(data['email']),
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(receiverUserEmail: data['email'], receiverUserId:data['uid'],),),);
           },
         );
       }else{
         return  Container();
       }



     }

}