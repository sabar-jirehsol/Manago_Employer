

import 'package:country_picker/country_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/services/login_services.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/intro_screen/login_screen.dart';
import 'package:manago_employer/views/intro_screen/verification_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/EmployeeByUserIdService.dart';
import '../services/StateCityServices.dart';
import '../views/controller_screen.dart';
import '../views/intro_screen/profile_completion.dart';
import '../views/intro_screen/verification_emailotpscreen.dart';

class RegistrationController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? mobile;
  String? email;
  String? password;

  bool register_mobile = false,
      register_email = false,
      register_email_password = false;
  String ?register_mobile_error_Text, register_email_error_Text,
      register_email_error_password_Text;

  String?forgot_email_text;

  String firmTypeString = "";
  String firmSizeString = "";
  String? country;

  //String countryCodes = '+912';
  Country countryCodes = Country(
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

 String? signupmobile;
  TextEditingController signUpName = TextEditingController();
  TextEditingController signUpMobile = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpCompanyName = TextEditingController();
  TextEditingController signUpGSTNumber = TextEditingController();


//Todo below controllers for reset  the  password section in setpassword_screen
  TextEditingController setNewPassword = TextEditingController();
  TextEditingController setConfirmPassword = TextEditingController();


//Todo below controllers for change  the  password section in change_password_screen
  bool oldPasswordError = false;
  bool setnewPasswordError=false, setconfirmPasswordError=false;
  String? oldpasswordtexterror;
  String? oldtonewpasswordtexterror,oldconfirmpasswordtexterror;
  String? chcurrentpassword;
  String? chnewpassword;
  String? chconfirmpassword;

  TextEditingController oldtoNewPassword = TextEditingController();
  TextEditingController setoldtoNewPassword = TextEditingController();
  TextEditingController setoldtoConfirmPassword = TextEditingController();


  login(BuildContext context) {
    // EasyLoading.show(status: 'Please wait ...');
    EasyLoading.show(status: 'Please wait ...', dismissOnTap: true);
    LoginServices.login(API.login, mobile!, 'employer', scaffoldKey, context)
        .then((value) async {
      EasyLoading.dismiss();
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('mobile', mobile!);
        // print('otp is: ${value.data.otp}');

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           VerificationScreen(
        //               value: value,
        //               mobile: mobile!
        //           ),
        //     ));

        register_mobile = false;

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerificationScreen(
                      value: value,
                      mobile: mobile!
                  ),
            ));
      }
      else {
        setState(() {
          register_mobile = true;
          register_mobile_error_Text = "User not Registered";
        });
      }
    });
  }


  loginWithPassword(BuildContext context) {
    if ( email == null && password == null) {
      register_email = true;
      register_email_error_Text = 'Email should not be Empty ';
      register_email_password = true;
      register_email_error_password_Text = 'Password should not be Empty';
    }
    if(email==null){
      register_email = true;
      register_email_error_Text = 'Email should not be Empty ';
    }
    if(password==null||password!.isEmpty){
      register_email_password = true;
      register_email_error_password_Text = 'Password should not be Empty';
    }
    if( !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(
        email!)){
      register_email = true;
      register_email_error_Text = 'Enter valid Email Format ';
    }


    // EasyLoading.show(status: 'Please wait ...');
    if ( register_email ==false && register_email_password == false){
      EasyLoading.show(status: 'Please wait ...', dismissOnTap: true);
    LoginServices.loginwithpassword(
        API.loginwithPasswords, email!, 'employer', password!, scaffoldKey,
        context)
        .then((value) async {
      EasyLoading.dismiss();
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email!);
        print("email ${email}");
        register_email = false;
        // prefs.setString('mobile', mobile!);
        // print("mobiless ${mobile}");
        prefs.setString('password', password!);
        print("paswss ${password}");
        // print('otp is: ${value.data.otp}');
        prefs.setString('id', value.data!.id!);
        print("idss${value.data!.id}");
        // prefs.setString('token',value.data!.token!);
        // print("tokeens ${value.data!.token!}");
        employeeIdS(value.data!.id!, context);
        // prefs.setBool('isProfileSet', true);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ControllerScreen()
        //
        //     ));


      }
      else {
        //   setState(() {
        //     register_email_password = true;
        //
        //      register_email_password=true;
        //     register_email_error_password_Text = "Invalid Password";
        //   });
        // }
        // register_email = true;
        // register_email_error_Text = "User not Registered Kindly check Your Email and password";
        register_email_password = true;
        register_email_error_password_Text = "user not registered kindly check your email and password";
      }
    });
  }


}
  //status: 'Please wait ...',


  forgotPassword(String email_id,BuildContext context) {
     //EasyLoading.show(status: 'Please wait ...');
    EasyLoading.show(status: 'Please wait ...',dismissOnTap:true);
    LoginServices.sendEmailOTPForForgotPassword(API.forgotPassword, email_id, 'employer',scaffoldKey, context)
        .then((value) async {
      EasyLoading.dismiss();
      if (value != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email!);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerificationEmailOtpScreen(

                      email: email_id
                  ),
            ));
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           VerificationEmailOtpScreen(
        //
        //               email: email_id
        //           ),
        //     ));

      }
      else{
        setState(() {forgot_email_text="User Not Registered!!"; });
        print("Invalid User name and Password");
      }
    });
     // setState(() {forgot_email_text="User Not Registered!!"; });
  }





  updateNewPassword(String email_id,String password,BuildContext context) async{
    // EasyLoading.show(status: 'Please wait ...');
    EasyLoading.show(status: 'Please wait ...',dismissOnTap:true);
    print("email ${email}");
    LoginServices.updatepassword(API.updatenewPassword, email_id, 'employer',password ,scaffoldKey, context)
        .then((value) async {
      EasyLoading.dismiss();
      if (value != null) {
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('email', email);
        // print("email ${email}");
        //
        // prefs.setString('password', password!);
        // print("paswss ${password}");
        // // print('otp is: ${value.data.otp}');
        // prefs.setString('id', value.data!.id!);
        // print("idss${value.data!.id}");
        print("success update password");

       // employeeIdS(value.data!.id!,context);
        // prefs.setBool('isProfileSet', true);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ControllerScreen()
        //
        //     ));
        Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>LoginScreen()

                ));

      }
      else{
        print("INvalid User name and Password");
      }
    });
  }





  changeNewPassword(BuildContext context) async {
    if (chcurrentpassword==null) {
      setState(() {
        oldPasswordError = true;
        oldpasswordtexterror =
        "CurrentPassword should not be Empty";
      });
    }
    if (chnewpassword==null) {
      setState(() {
       // oldPasswordError = false;
        setnewPasswordError = true;
        oldtonewpasswordtexterror = "NewPassword should not be Empty";
      });
    }
    if (chconfirmpassword==null) {
      setState(() {
        //setnewPasswordError = false;
        setconfirmPasswordError = true;
        oldconfirmpasswordtexterror = 'ConfirmPassword should not be Empty';
      });
    }
    if (chnewpassword != chconfirmpassword) {
      setState(() {
        setconfirmPasswordError = true;
        oldconfirmpasswordtexterror ='Password not matching';
        //'Password doesn\'t match  Please enter the correct passwords in both fields.';
      });
    }
    if (  oldPasswordError==false&&setnewPasswordError==false&&setconfirmPasswordError == false) {
      print(chcurrentpassword);
      print(chnewpassword);
      // EasyLoading.show(status: 'Please wait ...');
      //EasyLoading.show(status: 'Please wait ...',dismissOnTap:true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? EmployerUserId = prefs.getString('id');
      print("EMPID__>CHANGE PASSWORD:${EmployerUserId}");
      LoginServices.changepassword(
          API.resetPassword, EmployerUserId!, chcurrentpassword!,
          chnewpassword!, scaffoldKey, context)
          .then((value) async {
        // EasyLoading.dismiss();
        if (value != null) {
          EasyLoading.showToast(
              "Your Password Changed Successfully", dismissOnTap: true,
              duration: Duration(seconds: 2));

          print("success change password");
          oldPasswordError = false;
          //Navigator.pop(context);
          //Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen(country: "Others",)));

        }

      });

    }

  }





    register(BuildContext context) {
      //EasyLoading.showProgress(0.3, status: "Registering...",maskType: );
      EasyLoading.show(status: 'Please wait ...',dismissOnTap:true);
      LoginServices.register(
          API.register,
          signUpName.text,
          signUpEmail.text,
          signUpMobile.text,
          countryCodes.phoneCode,
          countryCodes.name,
          signUpPassword.text,
          signUpCompanyName.text,
          firmTypeString,
          firmSizeString,
          signUpGSTNumber.text,
          scaffoldKey,
          context)
          .then((value) async {
        EasyLoading.dismiss();
        if (value != null) {
          print("REgistertion country ${value.data!.country!}");
          if(value.data!.country=="India"){
            setState((){country=value.data!.country!;});

          }
          else{
            setState((){
              country="Others";
            });
           print(country);
          }


          SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString('mobile', mobile!);
          // print('otp is: ${value.data.otp}');
          Future.delayed(Duration(milliseconds: 700),(){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen(country:country),)); });
        }
      });
    }




    List<String> firmSize = [];
    String? selectedFirmSize;
    registerLoadFirmSize(BuildContext context) async {
     // EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _id = _prefs.getString('employerId');
      String? _token = _prefs.getString('token');
      FilterDataServices.getSkills(API.getFirmSize, scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          print("firmSize ${value}");
          firmSize = value;
          setState(() {});
        }
      });
    }

    List<String> firmTypes = [];
    registerLoadFirmType(BuildContext context) async {
      //EasyLoading.show(status: 'Please wait...');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _id = _prefs.getString('employerId');
      String? _token = _prefs.getString('token');
      FilterDataServices.getSkills(API.getFirmType, scaffoldKey)
          .then((value) {
        EasyLoading.dismiss();
        if (value != null) {
          print("firmTypes ${value}");
          firmTypes = value;
          setState(() {});
        }
      });
    }


//Todo i added below code lines  7.2.24
  void employeeIdS(String id,BuildContext context) {
    EmployeeByUserIdService.getEmployeeId('${API.employeeByUserId}/$id', scaffoldKey,)
        .then((value) async {
      print("idd${id}");
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
            ),
          );
        } else {
          setState(() {
            register_email=false;
            register_email_password=false;


          });
          prefs.setBool('isProfileSet', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ControllerScreen(),
            ),
          );
        }
      }
    });
  }







}

