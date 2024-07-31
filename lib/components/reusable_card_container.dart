import 'package:flutter/material.dart';

class ReusableCardContainer extends StatefulWidget {
  final String? title;
  final String? value;

  const ReusableCardContainer({Key? key, this.title, this.value})
      : super(key: key);
  @override
  _ReusableCardContainerState createState() => _ReusableCardContainerState();
}

class _ReusableCardContainerState extends State<ReusableCardContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title!,
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          widget.value!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: Colors.blue),
        ),
      ],
    );
  }
}
