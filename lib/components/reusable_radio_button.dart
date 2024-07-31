import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class ReusableRadioButton extends StatelessWidget {
  final String? title;
  final Function? onpressed;
  final String? groupValue;

  const ReusableRadioButton(
      {Key? key, this.title, this.onpressed, this.groupValue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: kPurpleAccent,
          value: title,
          groupValue: groupValue,
          onChanged: onpressed!(),
        ),
        Text(
          title!,
          style: TextStyle(fontSize: 12, color: Colors.black45),
        )
      ],
    );
  }
}
