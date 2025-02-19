import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
  final Function()? onTap;
  final String text;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text
    });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 222, 91),
          borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            )),)
      ),
    );
  }
}