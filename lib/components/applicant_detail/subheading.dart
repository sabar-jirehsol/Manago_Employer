import 'package:flutter/material.dart';

class Subheading extends StatelessWidget {
  final String? subheading;

  const Subheading({Key? key, this.subheading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        subheading!,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
    );
  }
}
