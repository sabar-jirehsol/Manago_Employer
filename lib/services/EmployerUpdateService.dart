import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manago_employer/models/EmployerUpdateModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class EmployerUpdateService {
  //static BuildContext? context;

  static Future<EmployerUpdateModel?>updateEmployer(
      String api,
      String id,
      String name,
      String email,
      String address,
      String mobile,
      String pincode,
      String country,
      String state,
      String city,
      //String pincode,
      String about,
      String Userid,
      GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //  // HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
        final body =({
          "id":id,
          "name": name,
          "mobile": mobile,
          "email": email,
          "address": address,
          "pincode":pincode,
          "country":country,
          "state": state,
          "city": city,
          "about": about,
          "userId": Userid,
          "createdBy ":Userid,
          "modifiedBy":Userid,
        });
        print("Personal Profile -->bodyy $body");
        print(api);
        final response =await http.post(Uri.parse(api),body: body);
        print("response Statuscode ${response.statusCode}");
        if (response.statusCode == 200) {
          print("emp update process");
          print("_id is ${id}");
          print("_userid is ${Userid}");
          print(response.body);
          EmployerUpdateModel jsonResponse =
          employerUpdateModelFromJson(response.body);
          print("jsonResponse${jsonResponse}");
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context);
    }
  }

















  static Future<EmployerUpdateModel?> updateCompany(
      String api,
      String id,
      String businessName,
      String businessWebsite,
      String businessEmail,
      String businessCountry,
      String businessState,
      String businessCity,
      String businessAddress,
      String businessFoundedDate,
      String firmSize,
      String category,
      String GSTNNo,
      String description,
      String Userid,
      // String facebook,
      // String linkedin,
      // String twitter,
      // String instagram,
      // String other,

      GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
        final body = ({
          "id":id,
          "businessName": businessName, //"My Comp1",
          "businessWebsite": businessWebsite, // "http://google.com",
          "businessEmail": businessEmail, // "test2@test2.com",
          "businessCountry":businessCountry,
          "businessState": businessState, // "Uttar Pradesh",
          "businessCity": businessCity, //"Allahabad",
          "businessAddress": businessAddress, //"Hii3",
          "businessFoundedDate":
              businessFoundedDate, // "2011-08-12T20:17:46.384Z",
          "firmSize": firmSize, //"0-50",
          "category": category, //"Cafe",
          "GSTNNo": GSTNNo, // "W123",
          "description": description,
          "userId": Userid,
          "createdBy ":Userid,
          "modifiedBy":Userid,

          // "test is an animal",
          // "facebook": facebook, //"https://www.facebook.com",
          // "linkedin": linkedin, //"https://in.linkedin.com/",
          // "twitter": twitter, //
          // // "https://twitter.com/i/flow/login?input_flow_data=%7B%22requested_variant%22%3A%22eyJsYW5nIjoiZW4ifQ%3D%3D%22%7D",
          // "instagram": instagram, // "https://www.instagram.com/",
          // "other": other, //"hello.com"
        });
        print('companybody${body}');
        final response =
            await http.post(Uri.parse(api), body: body);

        if (response.statusCode == 200) {
          print("company Update process");
          print(response.body);
          EmployerUpdateModel jsonResponse =
              employerUpdateModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context);
    }
  }











  static Future<EmployerUpdateModel?> updateSocialLinks(
      String api,
      String id,
      String facebook,
      String linkedin,
      String twitter,
      String instagram,
      String? other,
      String Userid,


      GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   //HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
        final body = ({
          "id":id,
          "facebook": facebook,
          "linkedin": linkedin,
          "twitter": twitter,
          "instagram": instagram, // "https://www.instagram.com/",

          "userId": Userid,
          "createdBy ":Userid,
          "modifiedBy":Userid,


          // "test is an animal",
          // , //"https://www.facebook.com",
          // , //"https://in.linkedin.com/",
          // //
          // // "https://twitter.com/i/flow/login?input_flow_data=%7B%22requested_variant%22%3A%22eyJsYW5nIjoiZW4ifQ%3D%3D%22%7D",
          // o.com"
        });

        //Add the other to the request body if provided
        if (other!= null) {
          body["other"] = other;
        }
        print('socialLINksbody${body}');
        final response =
        await http.post(Uri.parse(api), body: body);

        if (response.statusCode == 200) {
          print("social link Update process");
          print(response.body);
          EmployerUpdateModel jsonResponse =
          employerUpdateModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context);
    }
  }
















}
