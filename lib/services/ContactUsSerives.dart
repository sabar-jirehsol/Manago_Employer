import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import '../utils/alert.dart';
import '../utils/connection.dart';
import 'ContactUsModel.dart';




class ContactUsService {
  static BuildContext? context;

  static Future<ContactUsModel?> submitContactus(
      String api,
      String userid,
      String name,
      String email,
      String message,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        final body =({
          "userId":userid,
          "name": name,
          "email": email,
          "context": message,
        });

        print("Contact Us Body${body}");
        final response = await http.post(Uri.parse(api), body: body);

        if (response.statusCode == 200) {
          print("CONTACT Update process status code is ${response.statusCode}");
          print(response.body);
          ContactUsModel jsonResponse =
          contactUsModelFromJson(response.body);
          print("JSON RESPONSE");
          print(jsonResponse);
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