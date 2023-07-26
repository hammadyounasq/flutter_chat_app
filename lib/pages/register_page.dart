
import 'package:flutter/material.dart';


import '../components/my_button.dart';
import '../components/my_text_field.dart';

class ResgisterPage extends StatefulWidget {
 ResgisterPage({super.key,required this.onTap});
 void Function()? onTap;

  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
  final emailController=TextEditingController();

  final passwordController=TextEditingController();

   final confirmpasswordController=TextEditingController();

 

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

              //creat account massage
              const Text( "Let's create an account for you!",style: TextStyle(fontSize: 16),),
                 SizedBox(height: 25,),  
                  
              //email textfield
              MyTextField(controller: emailController, hindText: 'Email', obscureText: false),
                 SizedBox(height: 10,),
                  
              //password extfield
                MyTextField(controller: passwordController, hindText: 'Password', obscureText:true),  
                   SizedBox(height:10,),
                   //password extfield
                MyTextField(controller: confirmpasswordController, hindText: 'ConfirmPassword', obscureText:true),  
                   SizedBox(height: 25,),
              //sign in button
                MyButton(onTap: (){
                  
                }, text: "Sign in"),
                 SizedBox(height: 50,),  
                  
              //not a member? register now 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Already a member?'),
                SizedBox(width: 4,),
                GestureDetector(onTap:widget.onTap ,child: Text('Login now',style: TextStyle(fontWeight: FontWeight.bold),)),
              ],)
            ],),
          ),
        ),
      ),
    );
  }
}