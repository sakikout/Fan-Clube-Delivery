import 'package:flutter/material.dart';

class CustomOptionsButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final Color? backgroundColor; 
  final IconData? icon;
  final double borderWidth; 

  const CustomOptionsButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.iconColor,
    this.borderColor,
    this.backgroundColor,
    this.icon = Icons.arrow_forward_ios,
    this.borderWidth = 2.0,
    });


  @override
  Widget build(BuildContext context){
    return  GestureDetector(
      onTap: onTap,
      child: Container(
              decoration: 
                    BoxDecoration(
                      color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                      border: borderColor != null
                              ? Border.all(color: borderColor!, width: borderWidth)
                              : null,
                      ),
              margin: const EdgeInsets.only(left: 25, top: 10, right: 25),
              padding: const EdgeInsets.all(25),
              child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text(text, 
                style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: textColor ?? Theme.of(context).colorScheme.inversePrimary)
              ),
              Icon(
                icon ?? Icons.arrow_forward_ios,
                color: iconColor ?? Theme.of(context).colorScheme.primary
                ),

              ],
            ),
      
          ),
    );
  }
}