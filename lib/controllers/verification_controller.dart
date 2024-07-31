import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/services/EmployeeByUserIdService.dart';
import 'package:manago_employer/services/OtpVerificationServices.dart';
import 'package:manago_employer/services/ResendOtpServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/views/controller_screen.dart';
import 'package:manago_employer/views/intro_screen/profile_completion.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/intro_screen/setpassword_screen.dart';

class VerificationController extends ControllerMVC {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? otp;



  bool mobile_otp=false, email_otp=false;
  String?invalid_Otp_text="Invalid OTP Enter Right OTP";

  listenForOTP() async {
    await SmsAutoFill().listenForCode;
  }

  otpVerification(String id, String mobile, BuildContext context) {
    //EasyLoading.show(status: 'Please wait...');
    EasyLoading.show(status: 'Please wait ...',dismissOnTap:true);
    OtpVerificationServices.otpVerify(API.verifyOTP, id, mobile, scaffoldKey)
        .then((value) async {
      EasyLoading.dismiss();
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('mobile', mobile);
        print("mobilerr ${mobile!}");
        prefs.setString('id', value.data!.id!);
        print("idrr ${value.data!.id!}");
        //prefs.setString('token', value.data!.token!);
       // print("tokenrr ${value.data!.token!}");
      setState(() {  mobile_otp=false;  });

        employeeId(value.data!.id!, context);
      }



    });
    mobile_otp=true;
    invalid_Otp_text="Invalid OTP Enter Right OTP";
    EasyLoading.dismiss();



  }
  emailOtpVerification(String id, String email, BuildContext context) {
    //EasyLoading.show(status: 'Please wait...');
    EasyLoading.show(status: 'Please wait ...',dismissOnTap:true);
    OtpVerificationServices.otpEmailVerify(API.verifyEmailOTP,email,'employer', id,scaffoldKey)
        .then((value) async {
      EasyLoading.dismiss();
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        print("email isss ${email}");
        prefs.setString('id', value.data!.id!);
        print("idrr ${value.data!.id!}");
        //prefs.setString('token', value.data!.token!);
        // print("tokenrr ${value.data!.token!}");

        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SetPasswordScreen(email: email)));
        //employeeId(value.data!.id!, context);
      }

    });
    setState(() {
       email_otp=true;
      invalid_Otp_text="Invalid OTP Enter Right OTP";
       EasyLoading.dismiss();
    });
  }




  employeeId(String id, BuildContext context) {
    EasyLoading.show(status: 'Please wait ...',dismissOnTap:true);
    EmployeeByUserIdService.getEmployeeId(
            '${API.employeeByUserId}/$id',scaffoldKey)
        .then((value) async {
          print("iid${id}");
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print(value);
        prefs.setString('employerId', value.data!.id!);
        prefs.setString('employerUserId', value.data!.userId!);
        print("vercontroll${value.data!.userId!}");
        prefs.setBool('isLoggedIn', true);
        await FirebaseAnalytics.instance.logEvent(name: 'login');
        if (value.data!.name == null && value.data!.email == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileCompletion(),
              ));
        } else {
          setState(() {mobile_otp=false; });
         EasyLoading.dismiss();
          prefs.setBool('isProfileSet', true);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ControllerScreen(),
              ));
        }

      }

    });




  }

  resendOtp(String id, String token, BuildContext context) {
    EasyLoading.show(status: 'Please wait...');
    ResendOtpServices.otpResend(API.resendOTP, id, token, scaffoldKey)
        .then((value) async {
      EasyLoading.dismiss();
      if (value != null) {
        print('resend otp is ${value.data!.otp}');

        setState(() {
          otp = value.data!.otp;
        });
        Alert.showSnackbar('OTP sent', context);
      }
    });
  }
}
