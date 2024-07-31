import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class ReusableLisTile extends StatefulWidget {
  final IconData? icon;
  final String? title;

  const ReusableLisTile({Key? key, this.icon, this.title}) : super(key: key);
  @override
  _ReusableLisTileState createState() => _ReusableLisTileState();
}

class _ReusableLisTileState extends State<ReusableLisTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.icon,
        color: kPurpleAccent,
      ),
      title: Text(
        widget.title!,
        style: TextStyle(color: kPurpleAccent, fontSize: 18),
      ),
    );
  }
}
