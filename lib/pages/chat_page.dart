import 'package:chat_application/components/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constants.dart';
import '../models/message.dart';
class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
  String email  = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream:messages.orderBy('createdAt',descending: true).snapshots() ,
      builder: (context,snapshot){
        if(snapshot.hasData)
         {
           List<Message> messagesList =[];
           for(int i=0; i< snapshot.data!.docs.length; i++){
             messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
           }
           return Scaffold(
             appBar: AppBar(
               title: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset('assets/scholar.png',
                     height: 50.0,
                   ),
                   Text('Chat'),
                 ],
               ),
               automaticallyImplyLeading: false,
               backgroundColor: kPrimaryColor,
               centerTitle:true ,
             ),
             body: Column(
               children: [
                 Expanded(
                   child: ListView.builder(
                     reverse: true,
                     controller:_controller ,
                     itemCount: messagesList.length,
                     itemBuilder: (context, index) {
                       return messagesList[index].id ==email ?
                       ChatBubble(message: messagesList[index]) : ChatBubbleForFriend(message: messagesList[index]);
                     },
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: TextField(
                     controller: controller,
                     onSubmitted: (data){
                       messages.add({
                         'message': data,
                          'createdAt' : DateTime.now(),
                          'id' : email,
                       });
                       controller.clear();
                       _controller.animateTo(
                         _controller.position.maxScrollExtent,
                         curve: Curves.fastOutSlowIn,
                         duration: const Duration(milliseconds: 500),
                       );
                     },
                     decoration: InputDecoration(
                       hintText: 'send message',
                       suffixIcon:Icon(
                         Icons.send,
                         color: kPrimaryColor,
                       ) ,
                       border:OutlineInputBorder(
                         borderRadius: BorderRadius.circular(16),
                       ),
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(16),
                         borderSide: BorderSide(
                           color: kPrimaryColor,
                         ),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           );
         }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
