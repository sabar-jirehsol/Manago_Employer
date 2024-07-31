import 'package:flutter/material.dart';

class ReusableSalaryDetails extends StatelessWidget {
  final String? title;
  final String? pay;

  const ReusableSalaryDetails({Key? key, this.title, this.pay})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(fontSize: 14),
          ),
          Text(
            '₹ $pay',
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
