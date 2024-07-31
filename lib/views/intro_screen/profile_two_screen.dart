import 'package:flutter/material.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/controllers/profile_two_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileTwoScreen extends StatefulWidget {
  static const String id = 'profile_two_screen_id';
  @override
  _ProfileTwoScreenState createState() => _ProfileTwoScreenState();
}

class _ProfileTwoScreenState extends StateMVC<ProfileTwoScreen> {
  ProfileTwoController? _con;
  _ProfileTwoScreenState() : super(ProfileTwoController()) {
    _con = controller as ProfileTwoController?;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con!.scaffoldKey,
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleText(text: 'Profile Completion'),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                ReusableTextField(
                    hintText: 'Business Name',
                    onChanged: (value) {
                      _con!.businessName = value;
                    }),
                SizedBox(height: 30),
                ReusableDropDown(
                  hintText: 'Firm Type',
                  value: _con!.firmType,
                  options: _con!.firmArray,
                  onChanged: (value) {
                    setState(() {
                      _con!.firmType = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                ReusableTextField(
                    hintText: 'GSTIN No.',
                    onChanged: (value) {
                      _con!.businessName = value;
                    }),
                SizedBox(height: 30),
                ReusableTextField(
                    hintText: 'Total Staff',
                    onChanged: (value) {
                      _con!.businessName = value;
                    }),
                SizedBox(height: 30),
                ReusableDropDown(
                  hintText: 'Annual Turnover',
                  value: _con!.turnover,
                  options: _con!.turnoverArray,
                  onChanged: (value) {
                    setState(() {
                      _con!.turnover = value;
                    });
                  },
                ),
                SizedBox(height: 50),
                ReusableButton(
                  title: 'Submit',
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
