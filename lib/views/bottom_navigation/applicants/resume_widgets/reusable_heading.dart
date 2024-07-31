import 'package:flutter/material.dart';

class ReusableHeading extends StatelessWidget {
  final String? title;

  const ReusableHeading({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '⚪',
            style: TextStyle(color: Colors.white, fontSize: 5),
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
