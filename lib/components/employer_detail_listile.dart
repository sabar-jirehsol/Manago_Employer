import 'package:flutter/material.dart';

class EmployerDetailListile extends StatelessWidget {
  final String? title;
  final String? value;
  final Color? colors;

  const EmployerDetailListile({Key? key, this.title, this.value, this.colors})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 100,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            value!,
            style: TextStyle(color: colors),
          ),
        ],
      ),
    );
  }
}
