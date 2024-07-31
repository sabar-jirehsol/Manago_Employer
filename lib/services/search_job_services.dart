import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/models/search_job_model.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

class SearchJobServices {

  static BuildContext? context;

  static Future<SearchJobModel?> searchJobService(
      String api,
      String minSalary,
      String maxSalary,
      String minExperience,
      String maxExperience,
      String designation,
      List<String> keySkills,
      List<String> city,
      String token,
      GlobalKey<ScaffoldState> scaffoldKey) async {
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
          "employerID": null,
          "MinSalary": minSalary,
          "MaxSalary": maxSalary,
          "MinExperience": minExperience,
          "MaxExperience": maxExperience,
          "designation": designation,
          "keyskills": keySkills,
          "city": city
        });

        final response =
            await http.post(Uri.parse(api), headers: header, body: body);

        if (response.statusCode == 200) {
          print(response.body);
          SearchJobModel jsonResponse = searchJobModelFromJson(response.body);
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
