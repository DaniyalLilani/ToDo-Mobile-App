import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;

  VoidCallback onPressed;

  
   MyButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child:Text(text),
      color: const Color.fromARGB(255, 115, 88, 6),
      //padding: EdgeInsets.all(10),
      
    );
  }
}