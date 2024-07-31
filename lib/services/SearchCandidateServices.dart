import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/models/SearchhCandidateModel.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

class SearchCandidateServices {

  static BuildContext? context;

  static Future<SearchCandidateModel?> searchCanidate(
      String api,
      String mobile,
      //String token,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body = jsonEncode({"mobile": mobile});
        print("SEARCHED CANDIDATE BY MOBILE");
        print(body);
        print(api);
        final response =
        await http.post(Uri.parse(api), body: body, headers: header);

        print(response.statusCode);
        print(response.body);

        if (response.statusCode == 200) {
          SearchCandidateModel jsonResponse =
          searchCandidateModelFromJson(response.body);
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

  static Future<SearchCandidateModel?> searchCanidateV2(
      String api,
      //String designation,
      List<String> designation,
      List<String> cities,
      List<String> keySkills,
      int maxExp,
      int minExp,
      //String token,
      GlobalKey<ScaffoldState> scaffoldKey,
      int page) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        // final body = jsonEncode({
        //   "name":"Abinash",
        //   "mobile":"",
        //   "cityData": "",//cities,
        //   "designation": [designation],
        //   "keyskills": keySkills,
        //   "MinExperience": minExp,
        //   "MaxExperience": maxExp,
        // });
        final body=jsonEncode({
          "name":"",
          "mobile":"",
          "cityData":cities,
          "keyskills":keySkills,
          "MinExperience":minExp,
          "MaxExperience": maxExp,
          "designation":designation
        });


        print(api);
        print(body);

        final response = await http.post(Uri.parse(api), body: body, headers: header);
        print("SEARCHED CANDIDATE ");
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          SearchCandidateModel jsonResponse = searchCandidateModelFromJson(response.body);
          return jsonResponse;
        }
        else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        }
        else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar('Something went wrong',
              context!); //errorMessage['message'], context!);
          return null;
        }
      }
      on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      }
      // on NoSuchMethodError catch (e) {
      //   print(e.toString());
      //   Alert.showSnackbar('Profile does not exist', context!);
      //   return null;
      // }
      catch (e) {
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
