import 'package:flutter/material.dart';

class EducationDetails extends StatelessWidget {
  final String? qualification;
  final String? year;
  final String? study;
  final String? university;

  const EducationDetails(
      {Key? key, this.year, this.study, this.university, this.qualification})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            qualification!,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            year ?? " ",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            study!,
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            university ?? " ",
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
