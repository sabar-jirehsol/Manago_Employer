import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/models/CandidateSaveModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_education_card.dart';

class CandidateSaveServicesviamoible {
  static BuildContext? context;
  static Future<CandidateSaveModel?> saveCandidateviaMobile(
      String api,

      String mobile,

      GlobalKey<ScaffoldState> scaffoldKey,
      // //Professional info screen
      // double totalExperince,
      // List<String> keySkills,
      // String prefferedIndustry,
      // String preferedFunction,
      // List<CardView> jobdetails,
      //
      // //Education info screen
      // String highestQualification,
      // List<EducationCardView> educationDetails,
      // //jobPreference screen
      // String profileTitle,
      // List<String> preferedLocation,
      // String preferedRole,
      // String preferedJobType,
      // String shiftType,
      // String launguage,
      // String iAmSpeciallyAbled,
      // String id,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
          //HttpHeaders.contentTypeHeader: 'application/json'
        };
       final body=({ "mobile": mobile,
       });
        print("candidate saveVia Mobile response ${body}");

        final response =
        await http.post(Uri.parse("http://apimanago2.v3red.com/employee/findCandidateViaMobile"), body:body);
        if (response.statusCode == 200) {
          print(" RESPONSE BODY");
          print(response.body);
          CandidateSaveModel jsonResponse =
          candidateSaveModelFromJson(response.body);
          print("JSON RESPONSE");
          print(jsonResponse);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }
}
