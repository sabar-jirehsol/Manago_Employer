import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';
import 'package:manago_employer/utils/color_constants.dart';

class Aboutus extends StatelessWidget {
  final _htmlContent = """
<div class="tucupampam" style="z-index: 100;">
<h1 style="margin-top: 10px;"><center>About Us</center></h1> 

<h4>Manago is designed as end to end solution to all Food & Beverages Industry Needs.

Manago provide services like Manpower Solutions, Kitchen Planning, Kitchen Equipments, Interiors & Civil Work and Food Packaging Solutions.
Manago stands for personal Manager for each industry owner to take control and remove dependency on staffs.
Industry owners are benefitted by getting all required services under one umbrella. It helps them to optimize operations and
 easy access to all daily need services. </h4>   <br><br>
<br><br>
""";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor.withOpacity(0.2),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kPrimaryColor,
                  )),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'About Manago',
            style: TextStyle(
                color: Color(0xff666767),
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Who we do?',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                ),
                SizedBox(height: 20),
                Text(
                  'We are team to provide end to end solution for your hotel business',
                  style: TextStyle(
                      color: kSubtitleText,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                SizedBox(height: 25),
                Text(
                  '''Welcome to MANAGO, a premier service provider offering a comprehensive umbrella approach to the dynamic hospitality sector of Bangalore. With a steadfast commitment to excellence, MANAGO specializes in supplying skilled manpower to a diverse array of establishments, including pubs, restaurants, hotels, cafes, QSR outlets, and bars throughout Bangalore. Boasting a track record of over five years,MANAGO has emerged as a trusted partner in the industry, serving the needs of more than 500 satisfied clients. Our success is rooted in our dedication to delivering top-tier staffing solutions, contributing to the flourishing hospitality landscape of the city. ''',
                  style: TextStyle(
                      color: kSubtitleText,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                SizedBox(height: 50),
                Text(
                  'Our Purpose',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                ),
                SizedBox(height: 25),
                Text(
                 '''At MANAGO, our vision is to redefine the hospitality landscape in Bangalore by seamlessly integrating diverse services to empower businesses. We envision becoming the go-to-partner for establishments. in the hospitality industry,providing not only skilled manpower but also the essential infrastructure and resources necessary for success. Our aim is to enhance operational efficiency and elevate the overall guest experience, establishing MANAGO as the cornerstone of excellence in the hospitality sector ''',
                  style: TextStyle(
                      color: kSubtitleText,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
