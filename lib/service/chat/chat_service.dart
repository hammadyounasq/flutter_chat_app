import 'package:chatmessengerapp/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier{

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<void> sendMessage(String receiverId, String message )async{
  final String currenUserId = _firebaseAuth.currentUser!.uid;
  final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
  final Timestamp timestamp = Timestamp.now();

Message newMessage=Message(
  senderId: currenUserId,
   senderEmail: currentUserEmail,
    receiverId: receiverId,
     message: message, 
     timestamp: timestamp);

List<String> ids = [ currenUserId,receiverId];
ids.sort();
String chatRoomId=ids.join("_");

await _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').add(newMessage.toMap());


}
Stream<QuerySnapshot>getMessage(String userId,String otherserId){
  List<String> ids=[userId,otherserId];
  ids.sort();
  String chatRoomId=ids.join("_");

return _firestore.collection('chat_rooms').doc(chatRoomId).collection('messages').orderBy('timestamp',descending: false).snapshots();
}

 


}