import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ReusableProgress extends StatelessWidget {
  final String? title;

  const ReusableProgress({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40, right: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
          SizedBox(
            height: 3,
          ),
          StepProgressIndicator(
            totalSteps: 100,
            currentStep: 80,
            size: 5,
            padding: 0,
            selectedColor: Colors.orange,
            unselectedColor: Colors.black,
            // roundedEdges: Radius.circular(5),
          ),
        ],
      ),
    );
  }
}
