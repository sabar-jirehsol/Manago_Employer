import 'package:flutter/material.dart';

class WhiteHeading extends StatelessWidget {
  final String? title;

  const WhiteHeading({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '○',
            style: TextStyle(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: TextStyle(
                fontSize: 12,
                color: Colors.orange,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
