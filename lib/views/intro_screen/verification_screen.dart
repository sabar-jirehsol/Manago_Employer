import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/controllers/verification_controller.dart';
import 'package:manago_employer/models/LoginModel.dart';
import 'package:manago_employer/services/login_services.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/intro_screen/profile_completion.dart';
import 'package:manago_employer/views/intro_screen/profile_one_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationScreen extends StatefulWidget {
  static const String id = 'verification_screen_id';
  final LoginModel? value;
  final String? mobile;

  VerificationScreen({this.value, this.mobile});
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends StateMVC<VerificationScreen>
    with CodeAutoFill {
  VerificationController? _con;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _textEditingController = new TextEditingController();

  int flag = 0;
  Timer? _timer;

  int _start = 60;

  _VerificationScreenState() : super(VerificationController()) {
    _con = controller as VerificationController?;
  }

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();

    startTimer();
    _con!.listenForOTP();
    _con!.otp = widget.value!.data!.otp;
  }

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 22),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kGreyColor),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the previous screen
        Navigator.pop(context);
        print("Back button pressed");
        // Return true to allow popping the screen
        return true;
      },
      child: Scaffold(
        key: _con!.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: kBlueGrey,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Stack(
                  alignment: Alignment.center,
                    children:[
                      Image.asset(
                        'assets/images/login_circle.png',
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                      Image.asset(
                        'assets/images/login_logo.png',
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ]
                ),
                SizedBox(height: 10),
                TitleText(text: 'OTP',color: Colors.white,),
                SizedBox(height: 5),
                Text(
                  'Enter OTP sent to ${widget.mobile}',
                  style: TextStyle(fontSize: 16, color: kOrangeColor),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(60))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Pinput(
                            controller: _textEditingController,
                            focusNode: focusNode,
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                            listenForMultipleSmsOnAndroid: true,
                            defaultPinTheme: defaultPinTheme,
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: kGreyColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: kGreyColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: kGreyColor),
                              ),
                            ),
                            // errorPinTheme: defaultPinTheme.copyBorderWith(
                            //   border: Border.all(color: Colors.redAccent),
                            // ),
                          ),
                        ),_con!.mobile_otp?errorText(_con!.invalid_Otp_text):const SizedBox(),
                        SizedBox(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: RoundedReusableButton(
                            title: 'VERIFY',
                            onPressed: () {
                              if (_textEditingController.text.isEmpty) {
                                setState(() {
                                  _con!.mobile_otp=true;
                                  _con!.invalid_Otp_text="OTP is required";
                                });
                                // Alert.showSnackbar(
                                //     "OTP is required.", context);
                              } else if (_textEditingController.text.length !=
                                  4) {
                                setState(() {
                                  _con!.mobile_otp=true;
                                  _con!.invalid_Otp_text="OTP should be of 4 digits.";
                                });
                                // Alert.showSnackbar('OTP should be of 4 digits.',
                                //     context);
                              } else {
                                _con!.otpVerification(_textEditingController.text,
                                    widget.value!.data!.mobile!, context);
                                // _con!.candidateId(widget.value.data.id,
                                //     widget.value.data.token, context);
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        flag == 0
                            ? Text(
                                "Resend OTP in $_start",
                                style: TextStyle(color: kGreyColor, fontSize: 16),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    flag = 0;
                                    _start = 60;
                                    LoginServices.login(
                                        API.login,
                                        widget.value!.data!.mobile!,
                                        'employer',
                                        scaffoldKey,context);
                                    startTimer();
                                  });
                                },
                                child: RichText(
                                  text: TextSpan(
                                      text: "Didn't receive OTP?",
                                      style: TextStyle(
                                          color: kGreyColor, fontSize: 16),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' Resend',
                                          style: TextStyle(
                                              color: kBlueColor, fontSize: 16),
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

    // return Scaffold(
    //   key: _con!.scaffoldKey,
    //   body: GestureDetector(
    //     onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
    //     child: SingleChildScrollView(
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             SizedBox(height: 30),
    //             Image.asset(
    //               'assets/images/verificationLogo.png',
    //               height: 150,
    //               fit: BoxFit.contain,
    //             ),
    //             Text(
    //               'OTP verification',
    //               style: TextStyle(fontSize: 20),
    //             ),
    //             Text('Please enter verification code sent to your '),
    //             Text('Registered Mobile number'),
    //             TextField(
    //               textAlign: TextAlign.center,
    //               controller: _textEditingController,
    //               decoration: InputDecoration(hintText: 'Enter OTP'),
    //               keyboardType: TextInputType.visiblePassword,
    //               obscureText: true,
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             Column(
    //               children: [
    //                 Padding(
    //                   padding:
    //                       EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //                   child: ReusableButton(
    //                     title: 'Verify OTP',
    //                     onPressed: () {
    //                       if (_textEditingController.text.isEmpty) {
    //                         Alert.showSnackbar(
    //                             "OTP is required.", _con!.scaffoldKey);
    //                       } else if (_textEditingController.text.length != 4) {
    //                         Alert.showSnackbar(
    //                             'OTP should be of 4 digits.', _con!.scaffoldKey);
    //                       } else {
    //                         _con!.otpVerification(_textEditingController.text,
    //                             widget.value.data.mobile, context);
    //                         // _con!.candidateId(widget.value.data.id,
    //                         //     widget.value.data.token, context);
    //                       }
    //                     },
    //                   ),
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text('You will receive the Otp with in'),
    //                     SizedBox(
    //                       width: 5,
    //                     ),
    //                     flag == 0
    //                         ? Text(
    //                             "$_start",
    //                             style: TextStyle(
    //                                 color: Colors.deepPurple, fontSize: 18),
    //                           )
    //                         : InkWell(
    //                             onTap: () async {
    //                               setState(() {
    //                                 flag = 0;
    //                                 _start = 60;
    //                                 LoginServices.login(
    //                                     API.login,
    //                                     widget.value.data.mobile,
    //                                     'candidate',
    //                                     scaffoldKey);
    //                                 startTimer();
    //                               });
    //                             },
    //                             child: Text("Resend OTP",
    //                                 style: TextStyle(
    //                                     color: Colors.deepPurple,
    //                                     fontSize: 18)),
    //                           )
    //                   ],
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  @override
  void codeUpdated() {
    // TODO: implement codeUpdated
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            flag = 1;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }





  errorText(text){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 10),
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
