import 'package:flutter/material.dart';

class AchievementsDetail extends StatelessWidget {
  final String? award;
  final String? category;
  final String? year;
  final String? placement;

  const AchievementsDetail(
      {Key? key, this.award, this.category, this.year, this.placement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            award!,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            category!,
            style: TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            year!,
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            placement!,
            style: TextStyle(fontSize: 10, color: Colors.white),
          )
        ],
      ),
    );
  }
}
