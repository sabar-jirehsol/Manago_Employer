import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';

class Steppers extends StatefulWidget {
  final int activeStep;


  const Steppers({Key? key, required this.activeStep}) : super(key: key);

  @override
  _SteppersState createState() => _SteppersState();
}

class _SteppersState extends State<Steppers> {
  static const Color myColor = Color.fromRGBO(30, 56, 82, 1.0);

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: widget.activeStep,
      lineStyle:LineStyle(
        lineLength: 30,
        lineSpace: 0,
        lineType: LineType.normal,
        defaultLineColor: Colors.white,
        finishedLineColor:myColor,
        lineThickness: 2,

      ),
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.black87,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 20,
      showStepBorder: false,
      stepBorderRadius: 1,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            radius: 20,
            backgroundColor:myColor,
            child: CircleAvatar(
              radius: 16,
              backgroundColor:
              widget.activeStep >=0 ? myColor : Colors.white,
              child: Text("1",style: TextStyle(fontSize: 20,
                color: widget.activeStep >=0 ? Colors.white :myColor,
              ),),
            ),
          ),

        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 20,
            backgroundColor:myColor,
            child: CircleAvatar(
              radius: 16,
              backgroundColor:
              widget.activeStep >=1 ? myColor : Colors.white,
              child: Text("2",style: TextStyle(fontSize: 20,
                color: widget.activeStep >=1 ? Colors.white :myColor
                ,
              ),),
            ),
          ),

        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 20,
            backgroundColor: myColor,
            child: CircleAvatar(
              radius: 16,
              backgroundColor:
              widget.activeStep >=2 ? myColor : Colors.white,
              child: Text("3",style: TextStyle(fontSize: 20,
                color: widget.activeStep >=2 ? Colors.white :myColor,
              ),),
            ),
          ),

        ),

        EasyStep(
          customStep: CircleAvatar(
            radius: 20,
            backgroundColor:myColor,
            child: CircleAvatar(
              radius: 16,
              backgroundColor:
              widget.activeStep >= 3 ? myColor : Colors.white,
              child: Text("4",style: TextStyle(fontSize: 20,
                color: widget.activeStep >= 3 ? Colors.white : myColor,
              ),),
            ),
          ),

        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 20,
            backgroundColor:myColor,
            child: CircleAvatar(
                radius: 16,
                backgroundColor:
                widget.activeStep >=4 ? myColor : Colors.white,
                child:Icon(Icons.flag,size: 20,color: widget.activeStep >=4 ? Colors.white : myColor,)

            ),),
        ),




      ],
      //onStepReached: (index) => setState(() => activeStep = index),
    );
  }
}


