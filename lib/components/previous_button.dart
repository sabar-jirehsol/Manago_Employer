import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class PreviousButton extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  const PreviousButton({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      color: kGoldenColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: Text(
        title!,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      onPressed: onPressed!(),
    );
  }
}
