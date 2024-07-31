import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class RoundedReusableButton extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  final Color? fillColor;
  final Color? textColor;

  final Color? borderColor;
  final bool showProgress; // Flag to determine whether to show progress indicator
  RoundedReusableButton(
      {this.title,
      this.onPressed,
      this.fillColor = kBlueGrey,
      this.borderColor = Colors.transparent,
      this.textColor = Colors.white,
      this.showProgress= false,
      });
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: fillColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side:
            BorderSide(color: borderColor!, width: 1, style: BorderStyle.solid),
      ),
      child:showProgress
          ? CircularProgressIndicator(
        color: textColor, // Set color for the progress indicator
      ): Text(
        title!,
        style: TextStyle(fontSize: 18, color: textColor),
      ),
      onPressed: (){
        onPressed!();
      },
    );
  }
}
