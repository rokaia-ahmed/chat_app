
import 'package:chat_application/models/message.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';

class ChatBubble extends StatelessWidget {
 const ChatBubble({
    Key? key,
    required this.message,
}):super(key: key);

 final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white,),
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    Key? key,
    required this.message,
  }):super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white,),
        ),
        decoration: BoxDecoration(
          color:Color(0XFF00648D),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}

