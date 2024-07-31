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

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = 'login_screen_id';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends StateMVC<ForgotPasswordScreen> {
  RegistrationController? _con;

  _ForgotPasswordScreenState() : super(RegistrationController()) {
    _con = controller as RegistrationController?;
  }

  bool forgot_email=false;




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
      onWillPop: () async{
        // Navigate back to the previous screen
        Navigator.pop(context);
        print("Back button pressed");
        // Return true to allow popping the screen
        return true;
        // _closeApp();
        // return Future.value(true);
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
                  'Enter registered Email Address',
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


                        TextField(
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
                            _con!.email = val;
                          },
                        ),
                        forgot_email?
                        errorText(_con!.forgot_email_text): const SizedBox(),
                        SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child:
                          RoundedReusableButton(

                            title: 'Send OTP',
                            onPressed: () {
                              print(_con!.email);
                              FocusManager.instance.primaryFocus
                                  ?.unfocus();
                              if (_con!.email == null ||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+[a-zA-Z0-9]$|^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+[a-zA-Z0-9._%+-]@[a-zA-Z0-9.-]+\.[a-zA-Z]+$").hasMatch(_con!.email!)) {
                                setState(() {
                                  forgot_email=true;
                                  _con!.forgot_email_text="${'* '}Email Should Not be Empty.\n ${'*'} Enter Valid Email Format \n ${'*'} Entered Registered Email.";

                                });
                                }


                               else {
                                _con!.forgotPassword(_con!.email!,context);

                              }
                            },
                          )

                        ),
                        SizedBox(height: 30),



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
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
