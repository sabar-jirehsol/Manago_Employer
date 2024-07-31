import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/models/walkThrough_model.dart';
import 'package:manago_employer/views/intro_screen/login_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalkThroughController extends ControllerMVC {
  final slideList = [
    Slide(
      imageURL: 'assets/images/1.png',
      title: 'Hire',
      description:
          'Employers can find talents to grow their organization and job seekers can find their dream jobs, according to preferences.',
    ),
    Slide(
      imageURL: 'assets/images/2.png',
      title: 'Create Offer Letters',
      description:
          "Customisable template online - Immediate download - Word and PDF - Created by professionals. Complete and download your document online.\n It's quick and easy! Just fill out and print. Simple and easy.",
    ),
    Slide(
      imageURL: 'assets/images/3.png',
      title: 'Post Jobs',
      description:
          'Post jobs & find thousands of qualified candidates on the go. Free Hiring APP. Services: \nPost Jobs Free, Hire Employees. ',
    ),
    Slide(
      imageURL: 'assets/images/4.png',
      title: 'Employee Check',
      description:
          'Prevent Employee Fraud. Share your Background Screening needs to get a suitable solution. Identity, Address, Education, Employment, Criminal/Police Record & more background checks.',
    )
  ];

  int currentPage = 0;
  final PageController pageController = PageController(initialPage: 0);

  onPageChange(int index) {
    setState(() {
      currentPage = index;
    });
  }

  moveToNextScreen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isWalkThrough", true);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }
}
