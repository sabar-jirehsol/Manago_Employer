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

class SetPasswordScreen extends StatefulWidget {
  // static const String id = 'login_screen_id';
  final String? email;
  SetPasswordScreen({this.email});
  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends StateMVC<SetPasswordScreen> {
  RegistrationController? _con;

  _SetPasswordScreenState() : super(RegistrationController()) {
    _con = controller as RegistrationController?;
  }


  bool _loginpasswodVisible = true,_loginconfirmpasswodVisible = true;
  bool setnewPasswordError=false, setconfirmPasswordError=false;
  String? newpasswordtexterror,confirmpasswordtexterror;



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
                SizedBox(height: 30),
                Image.asset(
                  'assets/images/registrationLogo.png',
                  height: 150,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                TitleText(text: 'Mobile Number'),
                SizedBox(height: 5),
                Text(
                  'Email id ${widget.email}',
                  style: TextStyle(fontSize: 16, color: kOrangeColor),
                  textAlign: TextAlign.center,
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
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
                            controller: _con!.setNewPassword,
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
                        ),setnewPasswordError?errorText(newpasswordtexterror):const SizedBox(),

                        SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child:  TextFormField(
                            controller: _con!.setConfirmPassword,
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
                        ),setconfirmPasswordError?errorText(confirmpasswordtexterror):const SizedBox(),
                        SizedBox(height: 30),

                             Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: RoundedReusableButton(
                            title: 'Reset Password',
                            onPressed: () {
                              print(_con!.mobile);
                              FocusManager.instance.primaryFocus
                                  ?.unfocus();
                              if (_con!.setNewPassword.text.isEmpty) {
                                setState(() {
                                  setnewPasswordError=true;
                                  newpasswordtexterror="Password should not be Empty";
                                });

                                // Alert.showSnackbar(
                                //     'Password should not be null ',
                                //     context);
                              } else if (_con!.setConfirmPassword.text.isEmpty) {
                                setState(() {
                                  setnewPasswordError=false;
                                  setconfirmPasswordError=true;
                                  confirmpasswordtexterror='Password should not be null';
                                });

                                // Alert.showSnackbar(
                                //     'Password should not be null',
                                //     context);
                              }
                              else if (_con!.setNewPassword.text != _con!.setConfirmPassword.text) {
                                setState(() { setconfirmPasswordError=true;
                                confirmpasswordtexterror='Password not matching';
                                //'Password doesn\'t match  Please enter the correct passwords in both fields.';

                                });


                               // Alert.showSnackbar(
                               //     'Password doesn\'t match  Please enter the correct password in both fields.',
                               //     context);
                              }
                              else {
                                _con!. updateNewPassword(widget.email!,_con!.setNewPassword.text,context);
                              }
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
            child: Text(' $text',style: const TextStyle(color: Colors.red),),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }

}
