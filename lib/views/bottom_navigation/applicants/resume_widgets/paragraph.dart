import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final String? text;

  const Paragraph({Key? key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 10),
      child: Text(
        text ?? 'No data',
        style: TextStyle(fontSize: 10, color: Colors.black54),
      ),
    );
  }
}
