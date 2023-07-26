import 'package:chatmessengerapp/components/my_button.dart';
import 'package:chatmessengerapp/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth/auth_service.dart';

class LoginPage  extends StatefulWidget {
  LoginPage ({super.key,required this.onTap});
    final void Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController=TextEditingController();

  final passwordController=TextEditingController();

 void signUp()async{
    final authservice=Provider.of<AuthService>(context,listen: false);
    try{

      await authservice.signInWithEmailandPassword( emailController.text, passwordController.text);

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        
        child: Center(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(height: 50,),
              //login
               Icon(Icons.message,size: 100,color: Colors.grey[800],),
                   SizedBox(height: 50,),
              //welcom back massage
              const Text('Welcom back you\'ve been missed',style: TextStyle(fontSize: 16),),
                 SizedBox(height: 25,),  
                  
              //email textfield
              MyTextField(controller: emailController, hindText: 'Email', obscureText: false),
                 SizedBox(height: 10,),
                  
              //password extfield
                MyTextField(controller: passwordController, hindText: 'Password', obscureText:true),  
                   SizedBox(height: 25,),
              //sign in button
                MyButton(onTap:signUp, text: "Sign in"),
                 SizedBox(height: 50,),  
                  
              //not a member? register now 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Not a member?'),
                SizedBox(width: 4,),
                GestureDetector(onTap: widget.onTap,child: Text('Register now',style: TextStyle(fontWeight: FontWeight.bold),)),
              ],)
            ],),
          ),
        ),
      ),
    );
  }
}