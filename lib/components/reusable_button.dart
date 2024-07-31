import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class ReusableButton extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? fontSize;
  ReusableButton(
      {this.title,
      this.onPressed,
      this.buttonColor = kPrimaryColor,
      this.textColor = Colors.white,
      this.fontSize = 18});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 30,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title!,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
      onPressed: (){
        onPressed!();
      },
    );
  }
}
