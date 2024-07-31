import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manago_employer/models/AddJobModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';

class JobSaveServices {
  //static BuildContext? context;
  static Future<AddJobModel?> addJob(
      String api,
      String jobTitle,
      String designation,
      int minexperince,
      int maxexperince,
      List<String>skills,
     // String keyskills,
      String jobcountry,
      String jobstate,
      String jobcity,
      String salary,
      String vaccancy,
      String description,
      String employerId,
      GlobalKey<ScaffoldState> scaffoldKey,BuildContext context) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        //final keyskillsString = skills.join(','); // Convert List<String> to String
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
       // List<String> location = ["${jobstate},${jobcity}"];


        final body = jsonEncode({

          "jobTitle": jobTitle,
          "designation": designation,
           "experience":minexperince,
          "minExperience":minexperince,
          "maxExperience":maxexperince,
          "keyskills":skills.map((skill) => skill.toString()).toList(),
          "country":jobcountry,
          "state": jobstate,
          "city": jobcity,
          "salary": salary,
          "vaccancy": vaccancy,
          "description": description,
          "employerID": employerId
        });




          print("job posting body ${body}");
        final response =
            await http.post(Uri.parse(api), body: body,headers: header);
        print(response.statusCode);
        print("job posting progress ${response.body}");
        if (response.statusCode == 200) {
          AddJobModel jsonResponse = addJobModelFromJson(response.body);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final erroMessage = jsonDecode(response.body);
          Alert.showSnackbar(erroMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } catch (e) {
        e.toString();
        Alert.showSnackbar(e.toString(), context!);
      }
    }
  }
}
