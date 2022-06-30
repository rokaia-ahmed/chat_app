
import 'package:chat_application/components/custom_Button.dart';
import 'package:chat_application/components/custom_text_field.dart';
import 'package:chat_application/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/helper.dart';


class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email ;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall:isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key:formKey ,
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
                    Text('Register',
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
                    email = data;
                  },
                ),
                const  SizedBox(height: 10,),
                CustomTextFromField(
                  hintText: 'Password',
                  onChange:(data){
                    password = data;
                  } ,
                ),
                const  SizedBox(height: 20,),
                CustomButton(
                  text: 'Register',
                  onTap:()async{
                    if(formKey.currentState!.validate()){
                      isLoading = true;
                      setState(() {
                      });
                      try{
                        UserCredential user  = await  FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                            email: email!,
                            password: password!
                        );
                        Navigator.pushNamed(context,'ChatPage');
                      }on FirebaseAuthException catch(e){
                        if (e.code == 'weak-password') {
                          snackBar(context,'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          snackBar(context,'email-already-in-use');
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

                  } ,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?' ,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text('Login' ,
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
