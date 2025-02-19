import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget{
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final ValueChanged? onChanged;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onChanged
    });

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.tertiary,
        enabledBorder: OutlineInputBorder( 
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder( 
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)
      ),
    onChanged: onChanged,
    )
    );
  }
}