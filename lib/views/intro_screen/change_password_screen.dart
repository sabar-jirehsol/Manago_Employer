import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/controllers/registration_controller.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/intro_screen/register_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:country_picker/country_picker.dart';

import 'forgot_password_screen.dart';

class ChangePasswordScreen extends StatefulWidget {

  ChangePasswordScreen();
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends StateMVC<ChangePasswordScreen> {
  RegistrationController? _con;

  _ChangePasswordScreenState() : super(RegistrationController()) {
    _con = controller as RegistrationController?;
  }


  bool _oldtonewpasswordvisible=true,_loginpasswodVisible = true,_loginconfirmpasswodVisible = true;





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {

        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _con!.scaffoldKey,
        backgroundColor: kBlueGrey,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50 ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      // 'assets/images/registrationLogo.png',
                      'assets/images/login_circle.png',
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      // 'assets/images/registrationLogo.png',
                      'assets/images/login_logo.png',
                      height: 40,
                      fit: BoxFit.contain,
                    ),

                  ],
                ),
                // Image.asset(
                //   'assets/images/registrationLogo.png',
                //   height: 150,
                //   fit: BoxFit.contain,
                // ),
                SizedBox(height: 10),
                TitleText(text: 'Mobile Number'),
                SizedBox(height: 5),
                Text(
                  'Change Your Password',
                  style: TextStyle(fontSize: 16, color: kOrangeColor),
                  textAlign: TextAlign.center,
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(60))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child:  TextFormField(
                            onChanged: (value){
                              setState(() {
                                _con!.oldPasswordError=false;
                              });
                              _con!.chcurrentpassword=value;
                            },
                            controller: _con!.oldtoNewPassword,
                            obscureText: _oldtonewpasswordvisible,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.lock,
                                    color: kBlueGrey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 14),
                                labelText: 'Current Password',
                                floatingLabelStyle: TextStyle(color:kBlueGrey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _oldtonewpasswordvisible =
                                      !_oldtonewpasswordvisible;
                                    });
                                  },
                                  icon: _oldtonewpasswordvisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  color:kBlueGrey, //Theme.of(context).primaryColorDark,
                                )),
                            style: TextStyle(fontSize: 19),
                            // keyboardType: TextInputType.number,
                            // onChanged: (val) {
                            //   _con!.password = val;
                            // },
                            enableSuggestions:false, // Disables suggestions
                          ),
                        ),_con!.oldPasswordError?errorText(_con!.oldpasswordtexterror):const SizedBox(),
                        SizedBox(height: 15,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child:  TextFormField(
                            onChanged: (value){
                              setState(() {
                                _con!.setnewPasswordError=false;
                              });
                              _con!.chnewpassword=value;
                            },
                            controller: _con!.setoldtoNewPassword,
                            obscureText: _loginpasswodVisible,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.lock,
                                    color: kBlueGrey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 14),
                                labelText: 'New Password',
                                floatingLabelStyle: TextStyle(color:kBlueGrey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _loginpasswodVisible =
                                      !_loginpasswodVisible;
                                    });
                                  },
                                  icon: _loginpasswodVisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  color:kBlueGrey, //Theme.of(context).primaryColorDark,
                                )),
                            style: TextStyle(fontSize: 19),
                            // keyboardType: TextInputType.number,
                            // onChanged: (val) {
                            //   _con!.password = val;
                            // },
                            enableSuggestions:false, // Disables suggestions
                          ),
                        ),_con!.setnewPasswordError?errorText(_con!.oldtonewpasswordtexterror):const SizedBox(),

                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child:  TextFormField(
                            onChanged: (value){
                              setState(() {
                                _con!.setconfirmPasswordError=false;
                              });
                              _con!.chconfirmpassword=value;
                            },
                            controller: _con!.setoldtoConfirmPassword,
                            obscureText: _loginconfirmpasswodVisible,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.lock,
                                    color: kBlueGrey,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 14),
                                labelText: 'Confirm Password',
                                floatingLabelStyle: TextStyle(color:kBlueGrey),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kGreyColor),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.red),
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _loginconfirmpasswodVisible =
                                      !_loginconfirmpasswodVisible;
                                    });
                                  },
                                  icon: _loginconfirmpasswodVisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  color:kBlueGrey, //Theme.of(context).primaryColorDark,
                                )),
                            style: TextStyle(fontSize: 19),
                            // keyboardType: TextInputType.number,
                            // onChanged: (val) {
                            //   _con!.password = val;
                            // },
                            enableSuggestions:false, // Disables suggestions
                          ),
                        ),_con!.setconfirmPasswordError?errorText(_con!.oldconfirmpasswordtexterror):const SizedBox(),
                        SizedBox(height: 20),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: RoundedReusableButton(
                            title: 'Change Password',
                            onPressed: () {
                              print(_con!.mobile);
                              FocusManager.instance.primaryFocus
                                  ?.unfocus();
                                setState(() { });
                              _con!. changeNewPassword(context);
                              // if (_con!.oldtoNewPassword.text.isEmpty) {
                              //   setState(() {
                              //     _con!.oldPasswordError = true;
                              //    _con!.oldpasswordtexterror =
                              //     "CurrentPassword should not be Empty";
                              //   });
                              // }
                              //  if (_con!.setoldtoNewPassword.text.isEmpty) {
                              //   setState(() {
                              //     _con!.oldPasswordError=false;
                              //     setnewPasswordError=true;
                              //     oldtonewpasswordtexterror="NewPassword should not be Empty";
                              //   });
                              //
                              //
                              // }  if (_con!.setoldtoConfirmPassword.text.isEmpty) {
                              //   setState(() {
                              //     setnewPasswordError=false;
                              //     setconfirmPasswordError=true;
                              //     oldconfirmpasswordtexterror='ConfirmPassword should not be Empty';
                              //   });
                              //
                              //
                              // }
                              //  if (_con!.setoldtoNewPassword.text != _con!.setoldtoConfirmPassword.text) {
                              //   setState(() {
                              //
                              //     setconfirmPasswordError=true;
                              //   oldconfirmpasswordtexterror='Password doesn\'t match  Please enter the correct passwords in both fields.';});
                              //
                              //
                              //
                              // }
                              // if(  _con!.oldPasswordError ==false && setnewPasswordError==false && setconfirmPasswordError==false)
                              //  {
                              //
                              // }
                            },
                          ),
                        ),


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  errorText(text){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('$text',style: const TextStyle(color: Colors.red),),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

}
