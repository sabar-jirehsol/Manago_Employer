import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class TitleText extends StatelessWidget {
  final String? text;
  final Color?color;
  TitleText({this.text,this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          color:color??kBlueGrey, fontSize: 20, fontWeight: FontWeight.w500),
    );
  }
}
