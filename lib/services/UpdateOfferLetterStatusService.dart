import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:connectivity/connectivity.dart';


import '../models/UpdateOfferletterStatusModel.dart';

class UpdateOfferletterStatusService {
  static Future<UpdateOfferLetterStatus?> updateOfferletterStatus(
      String api,
      String id,
      String status,
      // String token,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final body =jsonEncode ({"id": id, "status": status});

        final response = await http.post(Uri.parse(api), headers: header, body: body);
        print(body);
        print("Offer Letter STATUS::::");

        print(response.statusCode);
        print("Offer Letter STATUS::::");
        print(response.body);
        if (response.statusCode == 200) {

          UpdateOfferLetterStatus jsonResponse = updateOfferLetterStatusFromJson(response.body);
          print("fjffjjf");
          print(jsonResponse);
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Fluttertoast.showToast(msg: errorMessage['errorMessage']);

          // SimpleDialog(title: Text(errorMessage['errorMessage']));

          //   Alert.showSnackbar(errorMessage['errorMessage'], scaffoldKey);
          return null;
        } else {
          Map<String, dynamic> errorMessage = jsonDecode(response.body);
          SimpleDialog(title: Text(errorMessage['error']['message']));
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        SimpleDialog(title: Text('Connection timed out!'));
        return null;
      } catch (e) {
        e.toString();
        SimpleDialog(title: Text(e.toString()));
        return null;
      }
    } else {
      SimpleDialog(title: Text('No Internet'));
      return null;
    }
  }

}
