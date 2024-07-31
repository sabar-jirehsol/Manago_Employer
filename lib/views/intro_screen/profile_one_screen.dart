import 'package:flutter/material.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/profile_one_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/intro_screen/profile_two_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileOneScreen extends StatefulWidget {
  static const String id = 'profile_one_screen_id';
  @override
  _ProfileOneScreenState createState() => _ProfileOneScreenState();
}

class _ProfileOneScreenState extends StateMVC<ProfileOneScreen> {
  ProfileOneController? _con;
  _ProfileOneScreenState() : super(ProfileOneController()) {
    _con = controller as ProfileOneController?;
  }
  @override
  void initState() {
    super.initState();
    _con!.loadStates(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con!.scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              TitleText(text: 'Profile Completion'),
              SizedBox(height: 30),
              ReusableTextField(
                hintText: 'Full Name',
                onChanged: (value) => _con!.name = value,
              ),
              SizedBox(height: 30),
              ReusableTextField(
                hintText: 'Email Address',
                onChanged: (value) => _con!.email = value,
              ),
              SizedBox(height: 30),
              TextField(
                onChanged: (value) => _con!.address = value,
                maxLines: 5,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Full Address',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPurple),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPurple),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  // Expanded(
                  //   child: ReusableDropDown(
                  //     hintText: 'State',
                  //     value: _con!.newState,
                  //     items: _con!.newStates,
                  //     onSelected: (value) {
                  //       _con!.newState = value;
                  //       _con!.loadCities(value);
                  //     },
                  //   ),
                  // ),
                  // SizedBox(width: 10),
                  // Expanded(
                  //   child: ReusableDropDown(
                  //     hintText: 'City',
                  //     value: _con!.city,
                  //     items: _con!.cities,
                  //     onSelected: (value) {
                  //       setState(() {
                  //         _con!.city = value;
                  //       });
                  //     },
                  //   ),
                  // )
                  Expanded(
                    child: SearchableDD(
                      hintText: 'Search State',
                      label: 'State',
                      items: _con!.newStates,
                      selectedItem: _con!.newState,
                      onChanged: (value) {
                        _con!.newState = value;
                        _con!.loadCities(_con!.newState!);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SearchableDD(
                      hintText: 'Search City',
                      label: 'City',
                      items: _con!.cities,
                      selectedItem: _con!.city,
                      onChanged: (value) {
                        _con!.city = value;
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
              ReusableButton(
                title: 'Next',
                onPressed: () {
                  print('State is ${_con!.newState}');
                  print('City is ${_con!.city}');
                  Navigator.pushNamed(context, ProfileTwoScreen.id);
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
