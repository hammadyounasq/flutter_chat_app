import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key,required this.controller,required this.hindText,required this.obscureText});

final TextEditingController controller;
final String hindText;
final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200)
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white),),
        fillColor: Colors.grey[100],
        filled: true,
        hintText: hindText,
        hintStyle: TextStyle(color: Colors.grey)
      ),
    );
  }
}