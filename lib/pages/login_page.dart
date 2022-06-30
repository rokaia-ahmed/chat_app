
import 'package:chat_application/components/custom_Button.dart';
import 'package:chat_application/components/custom_text_field.dart';
import 'package:chat_application/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/helper.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email ;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall:isLoading ,
      child: Scaffold(
        backgroundColor:kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
              const  Spacer(
                  flex: 1,
                ),
                Image.asset('assets/scholar.png'),
                Text('Scholar Chat',
                style:TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
                ),
              const  Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    Text('LOGIN',
                      style:TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const  SizedBox(height: 20,),
                CustomTextFromField(
                  hintText: 'Email',
                onChange: (data){
                  email = data ;
                },
                ),
              const  SizedBox(height: 10,),
                CustomTextFromField(
                  hintText: 'Password',
                  obscureText: true,
                  onChange: (data){
                  password =data ;
                },
                ),
              const  SizedBox(height: 20,),
                CustomButton(
                  text: 'login',
                  onTap: ()async{
                    if(formKey.currentState!.validate()){
                      isLoading = true;
                      setState(() {
                      });
                      try{
                        UserCredential user  = await  FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: email!,
                            password: password!);
                        Navigator.pushNamed(context, 'ChatPage',arguments: email);
                      }on FirebaseAuthException catch(e){
                        if (e.code == 'user-not-found') {
                          snackBar(context,'user-not-found');
                        } else if (e.code == 'wrong-password') {
                          snackBar(context,'wrong-password');
                        }
                      }catch(e){
                        snackBar(context,'there was an  error');
                      }
                      isLoading = false ;
                      setState(() {
                      });
                    }else{
                      snackBar(context,'there was an  error');
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                 const  Text('don\'t have an account?' ,
                    style: TextStyle(color: Colors.white),
                   ),
                  const SizedBox(width: 20,),
                   GestureDetector(
                     onTap:(){
                      Navigator.pushNamed(context,'RegisterPage');
                     } ,
                     child: const Text('Register' ,
                       style: TextStyle(color:Color(0XFFC5E8E8),),
                     ),
                   ),
                 ],
                ),
              const  Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
