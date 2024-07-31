import 'package:flutter/material.dart';

class ReusableJobHighlight extends StatefulWidget {
  final IconData? icon;
  final String? text;

  const ReusableJobHighlight({Key? key, this.icon, this.text}) : super(key: key);
  @override
  _ReusableJobHighlightState createState() => _ReusableJobHighlightState();
}

class _ReusableJobHighlightState extends State<ReusableJobHighlight> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: Colors.white70,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            child: Text(
              widget.text!,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
