import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class MoreListtile extends StatelessWidget {
  final String? iconAddress;
  final String? title;

  const MoreListtile({Key? key, this.iconAddress, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      child: Row(
        children: [
          Image.asset(
            iconAddress!,
            scale: 2.0,
          ),
          SizedBox(width: 20),
          Text(
            title!,
            style: TextStyle(color: kPrimaryColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
