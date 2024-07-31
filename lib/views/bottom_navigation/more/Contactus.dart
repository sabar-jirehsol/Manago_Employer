import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_readonly_textfield.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/contact_us_controller.dart';

class  Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends StateMVC<Support> {
  ContactUsController? _con;
  _SupportState() : super(ContactUsController()) {
    _con = controller as ContactUsController?;
  }

  // String? name;
  // String? email;
  // String? message;

 void _launchCaller() async {
    const url = "tel:7338000475";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _launchWebsite() async {
    const url = "http:\\www.manago.in";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // void _launchEmail() async {
  //   final Uri params = Uri(
  //     scheme: 'mailto',
  //     path: 'info@manago.in',
  //   );
  //   String  url = params.toString();
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'info@manago.in',
      query: '', // Add any other query parameters here if needed
    );

    final String url = params.toString();
    try {
      await launch(url);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }




  void _launchConactapps(String url) async {
    //String url = '$baseUrl?userId=$userId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
            'Contact',
            style: TextStyle(
                color: kSubtitleText,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
        ),
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Get In Touch',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                ),
              ),
              SizedBox(height: 24),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(64))),
                  padding: EdgeInsets.all(32),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      _buildContactTile(
                          (){
                            _launchCaller();
                            print("calling......");
                          },
                       Icons.phone,
                          '+91 7338000475'
                      ),



                      _buildContactTile(
                          (){
                            _launchWebsite();
                            print("website loding......");
                          },

                          Icons.language_outlined,
                          'www.manago.in'),
                      _buildContactTile(
                          (){
                            _launchEmail();
                            print("website loding......");
                          } ,

                          Icons.mail, 'info@manago.in'),
                      _buildContactTile(
                          (){} ,
                          Icons.location_on,
                          'Manipal County Road, #56,  3rd \nCross, Bengaluru, Karnataka '),
                      Divider(height: 2, color: kSubtitleText),
                      SizedBox(height: 32),
                      Row(
                        children: [
                          GestureDetector(
                            onTap:(){
                              _launchConactapps("https://www.facebook.com/ManagoForEverything?mibextid=ZbWKwL");

                            },
                            child: Container(
                              padding: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: kSubtitleText),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/facebook.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: (){
                              _launchConactapps("https://www.linkedin.com/in/manago-one-point-solution-for-all-food-and-beverage-983258196?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: kSubtitleText),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/linkedin.png',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: (){
                              _launchConactapps("https://www.instagram.com/manago_official?utm_source=qr&igsh=MWRudHd5eGV2YzdodA==");

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: kSubtitleText),
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/instagram.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ReusableReadonlyTextField(
                              hintText: 'Name',
                              // labelText: 'Name',
                              onChanged: (value) => _con!.name = value,
                              textColor: kSubtitleText,
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: ReusableReadonlyTextField(
                              hintText: 'Email',
                              // labelText: 'Email',
                              onChanged: (value) => _con!.email = value,
                              textColor: kSubtitleText,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        onChanged: (value) =>_con!.message = value,
                        maxLines: 3,
                        style: TextStyle(fontSize: 18, color: kSubtitleText),
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(color: kSubtitleText),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: 150,
                          child: ReusableButton(
                            onPressed: () {
                                _con!.submitContactUs(context);
                            },
                            title: 'SUBMIT',
                            buttonColor: Colors.white,
                            textColor: kPrimaryColor,
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactTile(Function() onTap,
      IconData icon, String label, ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: GestureDetector(
        onTap:onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 15,
            ),
            SizedBox(width: 18),
            Text(label,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
