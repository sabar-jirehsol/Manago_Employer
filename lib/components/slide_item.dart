import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/models/walkThrough_model.dart';
import 'package:manago_employer/utils/color_constants.dart';

class SlideItem extends StatelessWidget {
  final int? selectedPageIndex;
  final List<Slide>? pageList;
  SlideItem({this.selectedPageIndex, this.pageList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 150),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            pageList![selectedPageIndex!].title!,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: kBlueGrey,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            pageList![selectedPageIndex!].description!,
            style: TextStyle(fontSize: 16, color: kSubtitleText),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              //shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(pageList![selectedPageIndex!].imageURL!),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        // SizedBox(height: 60),
      ],
    );
  }
}
