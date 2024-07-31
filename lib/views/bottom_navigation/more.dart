import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manago_employer/components/more_listtile.dart';
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/about.dart';
import 'package:manago_employer/views/bottom_navigation/more/expereince_letter/expereince_list.dart';
import 'package:manago_employer/views/bottom_navigation/more/myProfile_landing.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/offer_letters.dart';
import 'package:manago_employer/views/bottom_navigation/more/privacy_policy.dart';
import 'package:manago_employer/views/bottom_navigation/more/salary/salary_slip.dart';
import 'package:manago_employer/views/intro_screen/login_screen.dart';

import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../models/DashboardStatsModel.dart';
import '../../services/EmployeeDetailsService.dart';
import '../../services/login_services.dart';
import '../intro_screen/change_password_screen.dart';
import 'more/Contactus.dart';
import 'more/Subscription.dart';
import 'more/myprofile.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  void initState() {
    getUserDetails();
    getEmployeeDetail();

    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  SharedPreferences? _prefs;
  String name = '';
  String profilepics='';




  getUserDetails() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      name = _prefs!.getString('userName') ?? ' ';
      getEmployeeDetail();
       //profilepics=_prefs!.getString('profilePic')??' ';
    });


    print("jjjf");
    print(_prefs!.getString('profilePic'));
    print(profilepics);
    print(name);
  }
  getEmployeeDetail() async {
    //EasyLoading.show(status: "Please wait...");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _employeeID = _prefs.getString('employerId');
    String? _employerUserId = _prefs.getString('employerUserId');
    print('emp details');
    // print(_token);
    print(_employerUserId);
    EmployeeDetailsService.getEmployeeDetails('${API.employeeByUserId}/$_employerUserId',scaffoldKey)
        .then((value) {
      //EasyLoading.dismiss();
      if (value != null) {
        // name = value.data!.name;
        // email = value.data!.email;
        // address = value.data!.address;
        // mobile = value.data!.mobile;
        // profilepics=value.data!.profilepic;
        setState(() {
          profilepics=value.data!.profilepic!;
          print("cfggff");
          print(profilepics);
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
backgroundColor: Colors.white,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfileLanding(),
                  )).then((value) {
                getUserDetails();
                setState(() {});
              }),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => EmployeeUpdateView(),
                            builder: (context) => MyProfileLanding(),
                          )).then((value) {
                        getUserDetails();
                        setState(() {});
                      }),
                      child:CircleAvatar(
                        backgroundColor: Colors.transparent,
                       // backgroundColor: kBlueGrey,
                        radius: 20,
                        backgroundImage: profilepics.isEmpty
                            ? AssetImage('assets/images/add_image.png')as ImageProvider<Object>
                            : NetworkImage(profilepics),
                      ),

                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 3,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: kPrimaryColor,
                              fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        RoundedReusableButton(
                          title: 'Edit Profile',
                          fillColor: Colors.orange.shade50,
                          borderColor: kOrangeColor,
                          textColor: kOrangeColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyProfile(),//MyProfileLanding(),
                                )).then((value) {

                              getUserDetails();
                              setState(() {

                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.settings,
                      color: kPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),

          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SalarySlip(),
                )),
            child: MoreListtile(
              title: 'Salary Slip',
              iconAddress: 'assets/images/salaryslip.png',
            ),
          ),
          GestureDetector(
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OfferLetters(),
                ));

              },
            child: MoreListtile(
              title: 'Offer Letter',
              iconAddress: 'assets/images/offerletter.png',
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExperienceList(),
                )),
            child: MoreListtile(
              title: 'Experience Letter',
              iconAddress: 'assets/images/experienceletter.png',
            ),
          ),
          // InkWell(
          //   onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MySubscription(),
          //       )),
          //   child: MoreListtile(
          //     title: 'Subscription',
          //     iconAddress: 'assets/images/subscription.png',
          //   ),
          // ),
          InkWell(
            onTap: () {
              {
                // final RenderBox? box = context.findRenderObject();
                Share.share(
                    'https://play.google.com/store/apps/details?id=com.manago.manpower',
                    subject: 'Download Manago Employer app',
                    // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
                );
              }
            },
            child: MoreListtile(
              title: 'Share',
              iconAddress: 'assets/images/share.png',
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Support(),
                )),
            child: MoreListtile(
              iconAddress: 'assets/images/contactus.png',
              title: 'Contact Us',
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Aboutus(),
                )),
            child: MoreListtile(
              title: 'About Us',
              iconAddress: 'assets/images/aboutus.png',
            ),
          ),

          // InkWell(
          //   onTap: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => TermsCondition(),
          //       )),
          //   child: MoreListtile(
          //     title: 'Terms & Conditions',
          //     icon: Icons.pages,
          //   ),
          // ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(),
                )),
            child: MoreListtile(
              title: 'Privacy Policy',
              iconAddress: 'assets/images/privacypolicy.png',
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                )),
            child: MoreListtile(
              iconAddress: 'assets/images/ch.png',
              title: 'Change Password',
            ),
          ),

          InkWell(
            onTap: () {
              Alert.showLogOutAlert(context, () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('isLoggedIn');
                // prefs.remove('isWalkThrough');
                prefs.remove('isProfileSet');
                prefs.remove('mobile');
                prefs.remove('id');
                prefs.remove('token');
                prefs.remove('employerId');
                await FirebaseAnalytics.instance.logEvent(name: 'logout');
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.id, (Route<dynamic> route) => false);
              });
            },
            child: MoreListtile(
              title: 'Logout',
              iconAddress: 'assets/images/logout.png',
            ),
          ),




        ],
      ),
    );
  }
}
