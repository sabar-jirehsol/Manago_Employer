import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/models/StateCityModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

class NewJobDataServices {
  static BuildContext? context;
  static Future<List<String>?> getStatesCityMap(
    String api,
    String token,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final response = await http.get(Uri.parse(api), headers: header);
        if (response.statusCode == 200) {
          StateCityModel jsonResponse = stateCityModelFromJson(response.body);
          final cities = <String>[];

          for (final stateData in jsonDecode(response.body).values.first) {
            final state = stateData['state'] as String;
            for (final city in stateData['cities'] as List) {
              // cities.add('$city,$state');
              cities.add('$city');
            }
          }
          return cities;
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
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }

  static Future<List<String>?> getDesignations(
    String api,
    String token,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final response = await http.get(Uri.parse(api), headers: header);
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          List<String> labels = [];

          for (var item in json['values']) {
            labels.add(item['label']);
          }
          return labels;
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
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }

  static Future<List<String>?> getSkills(
    String api,
    String token,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final response = await http.get(Uri.parse(api), headers: header);
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          List<String> labels = [];

          for (var item in json['values']) {
            labels.add(item['label']);
          }
          return labels;
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
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }
}
