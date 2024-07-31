import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class SlideDots extends StatelessWidget {
  final bool? isActive;
  SlideDots({this.isActive});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 8,
      width: 8,
      duration: Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color:
            isActive! ? Theme.of(context).copyWith().primaryColor : kGreyColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}
