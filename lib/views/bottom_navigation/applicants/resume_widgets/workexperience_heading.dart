import 'package:flutter/material.dart';

class WorkexperienceHeading extends StatelessWidget {
  final String? title;

  const WorkexperienceHeading({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 10),
      child: Text(
        title!,
        style: TextStyle(
            fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }
}
