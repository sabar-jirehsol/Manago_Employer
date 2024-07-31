import 'package:flutter/material.dart';

class ReusableProfileInfo extends StatelessWidget {
  final String? title;
  final String? value;

  const ReusableProfileInfo({Key? key, this.title, this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '⚪',
            style: TextStyle(color: Colors.white, fontSize: 5),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  value!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
