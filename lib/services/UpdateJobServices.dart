import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/models/UpdateJobModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:http/http.dart' as http;

class UpdateJobService {
  //static BuildContext? context;
  static Future<UpdateJobModel?>updateJob(
      // String api,
      // String id,
      // List<String> keyskills,
      // String experience,
      // String jobTitle,
      // int salary,
      // int vaccancy,
      // String description,
      String api,
      String id,
      String designation,
      String jobTitle,
      // String experience,
      int minexperience,
      int maxexperience,
      List<String> skills,
      String country,
      String state,
      String city,
      String salary,
      //int salary,
      //int vaccancy,
      // String salary,
       String vaccancy,
      String description,
      //String token,
      GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {
    var connectivityResult = await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
       // final keyskillsString = keyskills.join(',');
         //Map<String, String> header = {
        //   // HttpHeaders.authorizationHeader: 'token $token',
           //HttpHeaders.contentTypeHeader: 'application/json'
         //};
        final body =jsonEncode({
          "id": id,
          "designation":designation,
          "jobTitle": jobTitle,
          "experience": minexperience,
          "minExperience":minexperience,
          "maxExperience":maxexperience,
          "keyskills": skills.map((skill) => skill.toString()).toList(),
          "country":country,
          "state":state,
          "city":city,
          "salary": salary.toString(),
          "vaccancy": vaccancy.toString(),
          "description": description
        });
        print("job updating body ${body}");

        final response = await http.put(Uri.parse(api),  body:body,headers: header);
        print("job updating progress ${response.body}");
        if (response.statusCode == 200) {
          print("Updating process");
          print(response.body);
          UpdateJobModel jsonResponse = updateJobModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context);
          return null;
        } else {
          Map<String, dynamic> errorMessage =json.decode(response.body);
          print("Update job error ${errorMessage}");
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
