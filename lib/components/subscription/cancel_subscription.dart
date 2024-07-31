import 'package:flutter/material.dart';

import '../../utils/color_constants.dart';
import '../reusable_button.dart';
import '../title_text.dart';



//TODO  i am write this on 7.1.2024

class CancelSubscription extends StatefulWidget {
  const CancelSubscription({super.key});



  @override
  State<CancelSubscription> createState() => _CancelSubscriptionState();
}

class _CancelSubscriptionState extends State<CancelSubscription> {
  String? _selectedReason;
  bool isButton1Pressed = false;
  void toggleButtonColors() {
    setState(() {
      isButton1Pressed = !isButton1Pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:60,top: 80),
                child: Text(
                  'Reasons For Leaving ?',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16,),
              Center(
                child: Text(
                  'Sad to see you  go!',
                  style: TextStyle(color: kOrangeColor, fontSize: 15,fontWeight:FontWeight.bold),
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: TitleText(
                  text: 'Tell Us why you are leaving?',
                   ),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.only(left:30.0,right: 20),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: '1',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value;
                            });
                          },
                        ),
                        Text(
                          'No longer required',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: '2',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value;
                            });
                          },
                        ),
                        Text(
                          'No longer required',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: '3',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value;
                            });
                          },
                        ),
                        Text(
                          'No longer required',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: '4',
                          groupValue: _selectedReason,
                          onChanged: (value) {
                            setState(() {
                              _selectedReason = value;
                            });
                          },
                        ),
                        Text(
                          'Other',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Stack(
                      children: [
                        // TextField widget
                        TextField(
                          maxLines: 5,
                          onChanged: (value) {
                            // Handle onChanged event if needed
                          },
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Kindly elaborate',
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        // Positioned to place the "SEND" text at the bottom right
                        Positioned(
                          bottom:8,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              // Implement send functionality
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'SEND',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
        
                    SizedBox(height: 16,),


        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReusableButton(
              title: 'I  changed  my mind',
              buttonColor: isButton1Pressed ? kPrimaryColor : Colors.white,
              textColor: isButton1Pressed ? Colors.white :kPrimaryColor,
              onPressed: () {
                // Add functionality for 'Next' button if needed
                toggleButtonColors();
              },
            ),
            SizedBox(height: 20),
            ReusableButton(
              title: 'Cancel subscription',
              buttonColor: isButton1Pressed ? Colors.white : kPrimaryColor,
              textColor: isButton1Pressed ? kPrimaryColor : Colors.white,
              onPressed: () {
                // Add functionality for 'Cancel' button if needed
                toggleButtonColors();
              },
            ),
          ],),
        
        
        
        
        
        
              ],  ),
        
              ),
        
        
        
        
        
            ],
          ),
        ),
      ) ,
    );
  }
}


