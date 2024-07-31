import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/models/CandidateUpdateModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_card_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/reusable_education_card.dart';

class CandidateUpdateServices {
  static BuildContext? context;
  static Future<CandidateUpdateModel?> updateCandidate(
      String api,
      String id,
      String name,
      String mobile,
      String email,
      String address,
      String state,
      String city,
      String pincode,
      String dob,
      String maritialStatus,
      String gender,
      String aadhar,
      String token,
      GlobalKey<ScaffoldState> scaffoldKey,
      //Professional info screen
      double totalExperince,
      List<String> keySkills,
      String prefferedIndustry,
      String preferedFunction,
      List<CardView> jobdetails,

      //Education info screen
      String highestQualification,
      List<EducationCardView> educationDetails,
      //jobPreference screen
      String profileTitle,
      List<String> preferedLocation,
      String preferedRole,
      String preferedJobType,
      String shiftType,
      String launguage,
      String iAmSpeciallyAbled) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body = jsonEncode({
          "id": id,
          "personalInfo": {
            "name": name,
            "mobile": mobile,
            "email": email,
            "address": address,
            "state": state,
            "city": city,
            "pinCode": pincode,
            "dob": dob,
            "maritialStatus": maritialStatus,
            "Gender": gender,
            "Aadhar": aadhar
          },
          "professionalInfo": {
            "totalExperience": totalExperince,
            "keySkills": keySkills,
            "prefferedIndustry": prefferedIndustry,
            "preferedFunction": preferedFunction,
            "jobDetails": [
              for (var i = 0; i < jobdetails.length; i++)
                {
                  "jobTitle": jobdetails[i].user!.jobTitle,
                  "employer": jobdetails[i].user!.employerController,
                  "startDate": jobdetails[i].user!.startDate,
                  "endDate": jobdetails[i].user!.endDate,
                  "IcurrentlyWorkHere": jobdetails[i].user!.checkBoxValue,
                  "Salary": jobdetails[i].user!.salaryController,
                  "salaryType": jobdetails[i].user!.salaryPer,
                  // "paymentMethod": jobdetails[i].user.paymentType,
                  "city": jobdetails[i].user!.city,
                  "noticePeroid": jobdetails[i].user!.noticePeriod,
                  "jobSummary": jobdetails[i].user!.jobSummary
                }
            ]
          },
          "educationalInfo": {
            "highestQualification": highestQualification,
            "educationDetails": [
              for (var i = 0; i < educationDetails.length; i++)
                {
                  "qualification": educationDetails[i].education!.qualification,
                  "educationType": educationDetails[i].education!.educationType,
                  "specialization":
                      educationDetails[i].education!.specialization,
                  "university": educationDetails[i].education!.university,
                  "passingYear": educationDetails[i].education!.passingYear,
                  "awardsAndAchivement": educationDetails[i].education!.awards,
                  "document": ""
                }
            ]
          },
          "jobPreference": {
            "profileTitle": profileTitle,
            "preferedLocation": preferedLocation,
            "prefferedRole": preferedRole,
            "prefferefJobType": preferedJobType,
            "shiftType": shiftType,
            "language": launguage,
            "iAmSpeciallyAbled": iAmSpeciallyAbled
          },
        });
        final response =
            await http.post(Uri.parse(api), body: body, headers: header);
        if (response.statusCode == 200) {
          print(response.body);
          CandidateUpdateModel jsonResponse =
              candidateUpdateModelFromJson(response.body);
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
