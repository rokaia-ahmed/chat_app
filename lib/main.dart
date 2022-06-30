import 'package:chat_application/pages/chat_page.dart';
import 'package:chat_application/pages/login_page.dart';
import 'package:chat_application/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        'LoginPage' : (context)=> LoginPage(),
        'RegisterPage' : (context) => RegisterPage(),
        'ChatPage' : (context)=> ChatPage(),
      } ,
      title: 'Scholar Chat',
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
    );
  }
}
