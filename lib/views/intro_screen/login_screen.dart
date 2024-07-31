import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/controllers/registration_controller.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/intro_screen/register_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pinput/pinput.dart';

import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.country});

  String?country;
  static const String id = 'login_screen_id';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends StateMVC<LoginScreen> {
  RegistrationController? _con;

  _LoginScreenState() : super(RegistrationController()) {
    _con = controller as RegistrationController?;
  }

  TextEditingController regmob=TextEditingController();
  TextEditingController regemail=TextEditingController();
  TextEditingController regemail_password=TextEditingController();

@override
void initState(){
  super.initState();
  _con!.country=widget.country??"India";
}

  //Todo i added password controller 1.2.24 we need to modify it just an dummy data
  bool _loginpasswodVisible = true;
  Country selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'India',
    displayName: 'India',
    displayNameNoCountryCode: 'IN',
    e164Key: '',
    example: '',
  );

  Future _closeApp() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to close the app?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          // content: Text('You are going to close the app!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'No',
                  style: TextStyle(color: kPurple),
                )),
            TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                  // Navigator.of(context).pop(true);
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: kPurple),
                )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {

        _closeApp();
        return Future.value(true);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _con!.scaffoldKey,
        backgroundColor: kBlueGrey,
        body: GestureDetector(
          onTap: () {
            // FocusScope.of(context).unfocus();
            FocusScope.of(context).requestFocus(FocusNode());
          } ,
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
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
                )
               ,
                //SizedBox(height: 10),
                TitleText(text: _con!.country=='India'? 'Mobile Number':"E-mail",
                color: Colors.white,
                ),
                SizedBox(height: 5),
                Text(
                  _con!.country=='India'?'Enter registered mobile number':"Enter registered email id",
                  style: TextStyle(fontSize: 14, color: kOrangeColor),
                  textAlign: TextAlign.center,
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                        BorderRadius.only(topRight: Radius.circular(60))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(unselectedWidgetColor:kBlueGrey),
                                  child: Radio(
                                      activeColor: kBlueGrey,
                                      value: "India",
                                      groupValue:_con!.country ,
                                      onChanged: (value){
                                        setState(() {
                                          _con!.country = value!;
                                          regemail.clear();
                                          _con!.email=null;
                                          _con!.password=null;
                                          _con!.register_email=false;
                                          _con!.register_email_password=false;
                                        });
                                        FocusScope.of(context).unfocus();
                                      }
                                  ),
                                ),
                                const Text('India')
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(unselectedWidgetColor:kBlueGrey), // Change the color here

                                  child: Radio(
                                      activeColor: kBlueGrey,
                                      value: "Others",
                                      groupValue: _con!.country,
                                      onChanged: (value){
                                        setState(() {
                                          _con!.country = value!;
                                          regmob.clear();
                                          _con!.mobile=null;
                                          _con!.register_mobile=false;
                                        });
                                        FocusScope.of(context).unfocus();

                                      }
                                  ),
                                ),
                                const Text('Others')
                              ],
                            ),
                          ],
                        ),
                        _con!.country == 'India'?
                        TextFormField(
                          controller: regmob,
                          decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: () {
                                    // showCountryPicker(
                                    //     context: context,
                                    //     showPhoneCode: true,
                                    //     countryListTheme:
                                    //         const CountryListThemeData(
                                    //       bottomSheetHeight: 530,
                                    //     ),
                                    //     onSelect: (value) {
                                    //       setState(() {
                                    //         selectedCountry = value;
                                    //         print(selectedCountry);
                                    //         print(selectedCountry.phoneCode);
                                    //       });
                                    //     });
                                  },
                                  child:
                                  Text(
                                    "${selectedCountry.flagEmoji}  + ${selectedCountry.phoneCode} ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 13),

                              labelText: 'Enter Mobile number',
                              floatingLabelStyle: TextStyle(color:kBlueGrey),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10))),
                          style: TextStyle(fontSize: 18),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9+]")),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            _con!.mobile = val;
                          },
                        )
                            :
                        TextFormField(
                          controller: regemail,
                          decoration: InputDecoration(
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(10),
                                child:Icon(
                                  Icons.email_sharp,
                                  color: kBlueGrey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 14),
                              labelText: 'Enter Email',
                              floatingLabelStyle: TextStyle(color:kBlueGrey),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10))),
                          style: TextStyle(fontSize: 18),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.allow(RegExp("[0-9+]")),
                          // ],
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (val) {
                            setState(() {
                              _con!.register_email=false;
                             _con!.register_email_password=false;
                              regemail_password.clear();
                            });
                            _con!.email = val;
                          },
                        ),_con!.register_mobile?errorText(_con!.register_mobile_error_Text):const SizedBox(),
                        _con!.register_email?errorText(_con!.register_email_error_Text):const SizedBox(),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: _con!.country == 'India'
                              ? RoundedReusableButton(
                            title: 'Send OTP',
                            onPressed: () {
                              print(_con!.mobile);
                              FocusManager.instance.primaryFocus
                                  ?.unfocus();
                              if (_con!.mobile == null) {
                                setState(() {
                                  _con!.register_mobile=true;
                                  _con!.register_mobile_error_Text="Mobile no.should not be Empty";
                                });
                                // Alert.showSnackbar(
                                //     'Mobile no. should not be null',
                                //     context);
                              } else if (_con!.mobile!.length != 10) {
                                setState(() {
                                  _con!.register_mobile=true;
                                  _con!. register_mobile_error_Text='Mobile no. should be 10 digits';
                                });
                                // Alert.showSnackbar(
                                //     'Mobile no. should be 10 digits',
                                //     context);
                              } else {
                                _con!.login(context);
                              }
                            },
                          )
                              :  TextFormField(
                            controller: regemail_password,
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
                                    horizontal: 15, vertical:14),
                                labelText: 'Enter Password',
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
                            style: TextStyle(fontSize: 18),
                            // keyboardType: TextInputType.number,
                            onChanged: (val) {
                              setState(() {
                                _con!.register_email_password=false;
                              });
                              _con!.password = val;
                              print("_con!.password is ${_con!.password}");
                            },
                            enableSuggestions:false, // Disables suggestions
                          ),
                        ),_con!.register_email_password?errorText(_con!.register_email_error_password_Text):const SizedBox(),
                        SizedBox(height: 15),
                        _con!.country== 'India'
                            ? SizedBox()
                            : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: RoundedReusableButton(
                            title: 'Login',
                            onPressed: () {
                              print(_con!.email);
                              print(_con!.password);
                              FocusManager.instance.primaryFocus
                                  ?.unfocus();
                                     setState(() {});
                            _con!.loginWithPassword(context);
                              // if (_con!.email == null || _con!.email!.length==0||_con!.email!.isEmpty||regemail.text.isEmpty) {
                              //   setState(() {
                              //     _con!.register_email=true;
                              //     //_con!.register_email_password=false;
                              //     _con!.register_email_error_Text='Email should not be Empty';
                              //
                              //   });
                              //
                              // }else if (!RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$')
                              //     .hasMatch(_con!.email!)) {
                              //   setState(() {
                              //     _con!.register_email = true;
                              //     //_con!.register_email_password = false;
                              //     _con!.register_email_error_Text = 'Enter a valid email format';
                              //   });
                              // }
                              //
                              // else if (_con!.password == null) {
                              //   setState(() {
                              //     _con!.register_email_password=true;
                              //     // _con!.register_email=false;
                              //     _con!.register_email_error_password_Text='Password should not be Empty';
                              //   });
                              // }
                              //
                              //
                              // else {
                              //   setState(() {
                              //
                              //     // _con!.register_email_password=false;
                              //   });
                              //   _con!.loginWithPassword(context);
                              // }
                            },
                          ),
                        ),

                        SizedBox(height: 8),
                        // Add some space between the password field and the Forget Password? link
                        _con!.country == 'Others'?TextButton(
                          onPressed: () {
                            // Add your Forget Password logic here
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color:kBlueColor,
                              // You can adjust the color as per your design
                              fontSize: 16,
                            ),
                          ),
                        ):SizedBox(),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Not Registered yet?',
                                style: TextStyle(
                                    color:kGreyColor,
                                    fontSize: 16,
                                    fontFamily: 'Jost'),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Register Now',
                                    style: TextStyle(
                                        color: kBlueColor,
                                        fontSize: 16,
                                        fontFamily: 'Jost'),
                                    recognizer: TapGestureRecognizer()..onTap = () {
                                      print("REGISTER NOW PAGE");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RegisterScreen()));
                                           },
                                  )
                                ]),
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
