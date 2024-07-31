import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:manago_employer/models/AddOfferLetterModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/AddOfferLetter.dart';

import '../models/DeleteOfferLetterModel.dart';
import '../models/UpdateOfferLetterModel.dart';

class UpdateOfferLetterServices {
  static BuildContext? context;
  static Future<UpdateOfferLetterModel?> updateOfferLetterService(
      String api,
      String offerletterId,
      String employerId,
      String employeeId,
      String candidateId,
      String joiningDate,
      // int offeredSalary,
      String offeredSalary,
      String designation,
      String description,
      String createdBy,
      // String token,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
          // HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body =({
          "id":offerletterId,
          "employerID": employerId,
          "employeeID": employeeId,
          "candidateID": candidateId,
          "documentType": "Offer Letter",
          "joiningDate": joiningDate,
          "offeredSalary": offeredSalary,
          "designation": designation,
          "description": description,
          "createdBy": createdBy,
          "modifiedBy": createdBy
        });
        print("API is ${api}");
        print("Offer letter body ${body}");
        final response =
        await http.post(Uri.parse(api), body: body);
        print(response.body);
        if (response.statusCode == 200) {
          UpdateOfferLetterModel jsonResponse =
          updateOfferLetterModelFromJson(response.body);
          print(jsonResponse);
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
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet', context!);
      return null;
    }
  }
}
