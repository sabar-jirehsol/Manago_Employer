import 'package:flutter/material.dart';

class Value extends StatelessWidget {
  final String? text;

  const Value({Key? key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        text == null || text!.isEmpty ? 'Not Specified' : text!,
        softWrap: true,
        maxLines: 3,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
