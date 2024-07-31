import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manago_employer/models/DeleteJobModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

import '../models/DeleteOfferLetterModel.dart';

class DeleteOfferLetterService {
  static BuildContext? context;
  static Future<DeleteOfferLetterModel?>deleteOfferLetter(
      String api, GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token'
        // };


        print(api);
        final response = await http.delete(Uri.parse(api));
        print("Delete offerLetter ${response.statusCode}");

        if (response.statusCode == 200) {
          DeleteOfferLetterModel jsonResponse = deleteOfferLetterModelFromJson(response.body);
          return jsonResponse;

        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        }  else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed Out', context!);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet', context!);
    }


  }
}




