import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:manago_employer/models/DashboardStatsModel.dart';
import 'package:manago_employer/models/LoginModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import '../models/ChangePasswordModel.dart';
import '../models/LoginOtpForgotPasswordModel.dart';
import '../models/UpdatePasswordModel.dart';

class LoginServices {

  // static BuildContext? context;

  static Future<LoginModel?> login(String api, String mobile, String userRole,
      GlobalKey<ScaffoldState> scaffoldkey,BuildContext context) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // try {
        Map<String, String> body = {"mobile": mobile, "userRole": userRole};

        final response = await http.post(Uri.parse(api), body: body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          LoginModel jsonResponse = loginModelFromJson(response.body);
          Fluttertoast.showToast(msg: jsonResponse.message!);

          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['error']['message'], context);
          return null;
        } else if (response.statusCode == 422) {
          final errorMessage = jsonDecode(response.body);
          print(errorMessage['error']['message']);
          Alert.showSnackbar(errorMessage['error']['message'], context);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          Alert.showSnackbar(errorMessage['error']['message'], context);
          return null;
        }
      // } on Sx
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }










  static Future<LoginModel?> loginwithpassword(String api, String email, String userRole,String password,
      GlobalKey<ScaffoldState> scaffoldkey,BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // try {
      Map<String, String> body = {"email": email, "userRole": userRole,"password": password};

      final response = await http.post(Uri.parse(api), body: body);
      print(api);
      print("loginwith password");
      print("email ${email} and  userRole is ${userRole} and  password is ${password}");
      print(response.statusCode);

      if (response.statusCode == 200) {
        LoginModel jsonResponse = loginModelFromJson(response.body);
        Fluttertoast.showToast(msg: jsonResponse.message!);

        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        print("INValid things");
        print(errorMessage);


      // Alert.showSnackbar(errorMessage['error'], context);
      //   Fluttertoast.showToast(msg: errorMessage['error'],
      //       timeInSecForIosWeb: 5,
      //       gravity:ToastGravity.BOTTOM,
      //       backgroundColor: Colors.white,
      //       textColor: Colors.red
      //   );
        return null;
      } else if (response.statusCode == 422) {
        final errorMessage = jsonDecode(response.body);
        print(errorMessage['error']['message']);

        Fluttertoast.showToast(msg: errorMessage['error']['message'],

        );
        //Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      } else {
       Map<String, dynamic> errorMessage = json.decode(response.body);

       // Fluttertoast.showToast(
       //     msg: errorMessage['error']['message'],
       //    timeInSecForIosWeb: 5,
       //     gravity:ToastGravity.BOTTOM,
       //     backgroundColor: Colors.white,
       //     textColor: Colors.red
       //
       // );
       //Alert.showSnackbar(errorMessage['error']['message'], context);

        return null;
      }
      // } on Sx
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }











  static Future<LoginForgotOtpModel?> sendEmailOTPForForgotPassword(String api, String email, String userRole,
      GlobalKey<ScaffoldState> scaffoldkey,BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // try {
      Map<String, String> body = {"email": email, "userRole": userRole,};

      final response = await http.post(Uri.parse(api), body: body);
      print(api);
      print("sendEmailOTPForForgotPassword");
      print("email ${email} and  userRole is ${userRole}");
      print(response.statusCode);

      if (response.statusCode == 200) {
        LoginForgotOtpModel jsonResponse = loginForgotOtpModelFromJson(response.body);
        Fluttertoast.showToast(msg: jsonResponse.message!);

        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        print("INValid things of sendEmailOTPForForgotPassword");
        print(errorMessage);

        Alert.showSnackbar(errorMessage['error'], context);
        return null;
      } else if (response.statusCode == 422) {
        final errorMessage = jsonDecode(response.body);
        print(errorMessage['error']['message']);
        //Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      } else {
        Map<String, dynamic> errorMessage = json.decode(response.body);
        Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      }
      // } on Sx
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }




  static Future<UpdatesetPasswordsModel?> updatepassword(String api, String email, String userRole,String password,
      GlobalKey<ScaffoldState> scaffoldkey,BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // try {
      Map<String, String> body = {"email": email, "userRole": userRole,"password": password};

      final response = await http.post(Uri.parse(api), body: body);
      print(api);
      print("Update password");
      print("email ${email} and  userRole is ${userRole} and  password is ${password}");
      print(response.statusCode);

      if (response.statusCode == 200) {
        UpdatesetPasswordsModel jsonResponse = updatenewPasswordFromJson(response.body);
        Fluttertoast.showToast(msg: jsonResponse.message!);

        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        print("INValid things update password");
        print(errorMessage);

        Alert.showSnackbar(errorMessage['error'], context);
        return null;
      } else if (response.statusCode == 422) {
        final errorMessage = jsonDecode(response.body);
        print(errorMessage['error']['message']);
        Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      } else {
        Map<String, dynamic> errorMessage = json.decode(response.body);
        Alert.showSnackbar(errorMessage['error']['message'], context);

        return null;
      }
      // } on Sx
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }






  static Future<changesetPasswordsModel?> changepassword(String api,String id, String oldpassword, String newpassword,
      GlobalKey<ScaffoldState> scaffoldkey,BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // try {
      Map<String, String> body = {

          "userID": id,
          "currentPassword": oldpassword,
          "newPassword":newpassword,

      };

      final response = await http.post(Uri.parse(api), body: body);
      print(api);
      print("change password");
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        changesetPasswordsModel jsonResponse = changenewPasswordFromJson(response.body);
        //Fluttertoast.showToast(msg: jsonResponse.message!);

        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        print("INValid things update password");
        print(errorMessage);

        Alert.showSnackbar(errorMessage['error'], context);
        return null;
      } else if (response.statusCode == 422) {
        final errorMessage = jsonDecode(response.body);
        print(errorMessage['error']['message']);
        Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      } else {
        Map<String, dynamic> errorMessage = json.decode(response.body);
        //Alert.showSnackbar(errorMessage['error']['message'], context);
        Fluttertoast.showToast(msg: errorMessage['error']['message'],
            timeInSecForIosWeb: 5,
            gravity:ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Colors.red
        );
        return null;
      }
      // } on Sx
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }










































  static Future<LoginModel?> register(String api, String name, String email, String mobile,String dialcode, String? country, String? password,
      String companyName, String firmType, String firmSize,String gstNum,
      GlobalKey<ScaffoldState> scaffoldkey,BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      // try {
      Map<String, String> body = {
        "mobile": mobile,
        "email": email,
        "name": name,
        "businessName": companyName,
        "category": firmType,
        "firmSize": firmSize,
        "GSTNNo": gstNum,
        "userRole": "employer",
      "dial_code":"+$dialcode",
      };

      // Add the password to the request body if provided
      if (password != null) {
        body["password"] = password;
      }
      if (country != null) {
        body["country"] =country;
      }

      print(body);

      final response = await http.post(Uri.parse(api), body: body);
      print("status code is ${response.statusCode}");
      print('registerBody ${response.body}');
      if (response.statusCode == 200) {
        LoginModel jsonResponse = loginModelFromJson(response.body);
        // Fluttertoast.showToast(msg: jsonResponse.message!);
        Fluttertoast.showToast(msg: "Registered Successfully");

        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      } else if (response.statusCode == 422) {
        final errorMessage = jsonDecode(response.body);
        print(errorMessage['error']['message']);
        Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      } else {
        Map<String, dynamic> errorMessage = json.decode(response.body);
        Alert.showSnackbar(errorMessage['error']['message'], context);
        return null;
      }
      // } on Sx
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }

  static Future<DashboardStats?> dashboardCount(String api, GlobalKey<ScaffoldState> scaffoldkey,BuildContext context) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token'
        // };
        print("DASHBOARD DATA'S");
        print(api);
        final response = await http.get(Uri.parse(api));
        print(response.statusCode);

        if (response.statusCode == 200) {
          DashboardStats jsonResponse = dashboardStatsFromJson(response.body);
          // Fluttertoast.showToast(msg: response.body);

          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context);
          return null;
        } else if (response.statusCode == 422) {
          final errorMessage = jsonDecode(response.body);
          print(errorMessage['message']);
          Alert.showSnackbar(errorMessage['message'], context);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context);
      }
    } else {
      Alert.showSnackbar('No Internet', context);
    }
  }
}
