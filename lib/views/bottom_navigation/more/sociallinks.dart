import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/more/my_profile_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../components/reusable_button.dart';
import '../../../components/reusable_readonly_textfield.dart';
import '../../../utils/color_constants.dart';

class SocialLinks extends StatefulWidget {
  const SocialLinks({Key? key}) : super(key: key);

  @override
  _SocialLinksState createState() => _SocialLinksState();
}

class _SocialLinksState extends StateMVC<SocialLinks> {
  MyProfileController? _con;

  _SocialLinksState() : super(MyProfileController()) {
    _con = controller as MyProfileController?;
  }



  @override
  void initState() {
    _con!.getCompanyDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: kPrimaryColor.withOpacity(0.2),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Social Links',
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                ReusableReadonlyTextField(
                  hintText: 'Facebook',
                  labelText: 'Facebook',
                  initialValue: _con!.companyData!.facebook,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {

                      setState(() {
                        _con!.facebookError = false;
                      });


                    _con!.facebook = value;
                  },
                ),
                _con!.facebookError
                    ? errorText(_con!.facebookError_text!)
                    : const SizedBox(),
                SizedBox(height: 30),
                ReusableReadonlyTextField(
                  labelText: 'Linkedin',
                  hintText: 'Linkedin',
                  initialValue: _con!.companyData!.linkedin,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _con!.linkedinError = false;
                    });
                    _con!.linkedIn = value;
                  },
                ),
                _con!.linkedinError
                    ? errorText(_con!.linkedinError_text!)
                    : const SizedBox(),
                SizedBox(height: 30),
                ReusableReadonlyTextField(
                  hintText: 'Twitter',
                  labelText: 'Twitter',
                  initialValue: _con!.companyData!.twitter,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _con!.twitterError =false;
                    });
                    _con!.twitter = value;
                  },
                ),
                _con!.twitterError
                    ? errorText(_con!.twitterError_text!)
                    : const SizedBox(),
                SizedBox(height: 30),
                ReusableReadonlyTextField(
                  hintText: 'Instagram',
                  labelText: 'Instagram',
                  initialValue: _con!.companyData!.instagram,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    setState(() {
                      _con!.instagramError =false;
                    });
                    _con!.instagram = value;
                  },
                ),
                _con!.instagramError
                    ? errorText(_con!.instagramError_text!)
                    : const SizedBox(),
                SizedBox(height: 30),
                ReusableReadonlyTextField(
                  hintText: 'Other',
                  labelText: 'Other',
                  initialValue: _con!.companyData!.other,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => _con!.other = value,
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    width: 140,
                    child: ReusableButton(
                      title: 'Update',
                      onPressed: () {

                        setState(() {


                        });

                          _con!.socialLinksProfile(context);

                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }











  Widget errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('⨂ $text', style: TextStyle(color: Colors.red)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
