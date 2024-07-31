import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String? heading;

  const Heading({Key? key, this.heading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        heading!,
        style: TextStyle(
            fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }
}
