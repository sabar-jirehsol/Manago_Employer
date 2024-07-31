import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:manago_employer/api/utils.dart';
import 'package:manago_employer/models/Forceupdate.dart';
import 'package:manago_employer/models/LoginModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'Resource.dart';
import 'Status.dart';
import 'network_client_impl.dart';

class ApiClient {
  ApiClient._internal();

  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  static final NetworkClient _networkClient = NetworkClient();
  static Function get onError => () {
        Fluttertoast.showToast(msg: "ERROR MSG" + onError.toString());
      };

  static Future<LoginModel?> postgroupdata(
      {String? url,
      String? token,
      String? requestData,
      Map<String, String>? header}) async {
    try {
      Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'token $token',
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      final response =
          await http.post(Uri.parse(url!), headers: header, body: requestData);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        LoginModel jsonResponse = loginModelFromJson(response.body);
        return jsonResponse;
        // LoginModel jsonResponse = loginModelFromJson(_response.data);
        // Data data= jsonResponse.data;
        // return Resource(status: STATUS.SUCCESS, data: responseMap);

        // if (responseMap["Status"] == 1) {
        // } else {
        //   return Resource(status: STATUS.ERROR, message: responseMap["Msg"]);
        // }
      } else {
        final errorMessage = jsonDecode(response.body);
        print(errorMessage);
      }
    } catch (ex) {
      if (ex is SocketException) {
        print(ex.toString());
      } else {}
    }
  }

  static Future<Resource?> buttonstatus(
      {@required String? url,
      @required String? token,
      String? requestData,
      Map<String, String>? header}) async {
    try {
      Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'token $token',
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      final response =
          await http.post(Uri.parse(url!), headers: header, body: requestData);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        return Resource(status: STATUS.SUCCESS, data: response.body);

        // LoginModel jsonResponse = loginModelFromJson(_response.data);
        // Data data= jsonResponse.data;
        // return Resource(status: STATUS.SUCCESS, data: responseMap);

        // if (responseMap["Status"] == 1) {
        // } else {
        //   return Resource(status: STATUS.ERROR, message: responseMap["Msg"]);
        // }
      } else {
        final errorMessage = jsonDecode(response.body);
        print(errorMessage);
      }
    } catch (ex) {
      if (ex is SocketException) {
        print(ex.toString());
      } else {}
    }
  }

  static Future<Resource> loadbackbutton(
      {String? url, Map<String, String>? header, String? token}) async {
    try {
      header = {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: 'token $token',
      };
      var response = await http.get(Uri.parse(url!), headers: header);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);

        if (responseMap["Status"] == 1) {
          return Resource(status: STATUS.SUCCESS, data: responseMap);
        } else {
          return Resource(status: STATUS.ERROR, message: responseMap["Msg"]);
        }
      } else {
        return Resource(
            status: STATUS.ERROR,
            message:
                _networkClient.getHttpErrorMessage(statusCode: statusCode));
      }
    } catch (ex) {
      if (ex is SocketException) {
        return Resource(status: STATUS.ERROR, message: CHECK_INTERNET);
      } else {
        return Resource(status: STATUS.ERROR, message: SOMETHING_WENT_WRONG);
      }
    }
  }

  static Future<Forceupdate?> getupdate({
    String? url,
  }) async {
    try {
      Map<String, String> header = {
        "content-type": "application/json",
      };
      final response = await http.get(Uri.parse(url!), headers: header);
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        Forceupdate jsonResponse = forceupdateFromJson(response.body);
        return jsonResponse;

        //   return responseMap;
        //   return Resource(status: STATUS.SUCCESS, data: responseMap);
        //
        //
        // } else {
        //   return Resource(
        //       status: STATUS.ERROR,
        //       message:
        //       _networkClient.getHttpErrorMessage(statusCode: statusCode));
        // }
      }
    } catch (ex) {
      if (ex is SocketException) {
        ex.toString();
      }
    }
  }
}
