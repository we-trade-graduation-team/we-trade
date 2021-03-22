import 'package:flutter/material.dart';
import 'package:we_trade/configs/constants/color.dart';
 
 class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.isFilled = true,
    required this.press,
    required this.text,
    required this.width
  }) : super(key: key);

  final bool isFilled;
  final VoidCallback press;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
      side: BorderSide(color: isFilled ? Colors.white : kPrimaryColor ,width: isFilled ? 0 : 2.5),
      ),
      elevation: isFilled ? 2 : 0,
      color: isFilled ? kPrimaryColor : Colors.white ,
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: isFilled ? Colors.white :  kPrimaryColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
