import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';
import 'package:http/http.dart' as http;

class ApplicationAgainstEmployerFilterService {
  static BuildContext? context;
  static Future<ApplicantDetailsModel?> applicationAgainstEmployerFilter(

      String api,
      String id,
      String?  selectedCity,
      String?  designationVal,
      int?   minexp,
      int?   maxexp,
      // String? skillSetVal,
      List<String>  skillSetVal,
      double? minSalary,
      double? maxSalary,

      GlobalKey<ScaffoldState> scaffoldKey) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          //HttpHeaders.authorizationHeader: 'token $token'
          HttpHeaders.contentTypeHeader: 'application/json'
        };


      final body=jsonEncode({
        "employerID":id,
        if (selectedCity != null) "location": selectedCity,
        if (designationVal != null) "designation": designationVal,
        if (minexp != null) "minExp": minexp.toString(),
        if (maxexp != null) "maxExp": maxexp.toString(),
        if (skillSetVal.isNotEmpty) "skills": skillSetVal,
        if (minSalary != null ) "minSalary": minSalary.toString(),
        if (maxSalary != null ) "maxSalary": maxSalary.toString(),

       // "location":  selectedCity,
        //"designation": "chef",
        // "minExp": minexp,
        // "maxExp": maxexp.toString(),
         //"skills": skillSetVal,
        // "minSalary": minSalary,
        // "maxSalary":maxSalary
      });
      // if(selectedCity !=null){body["location"]=  selectedCity;}
      // if(designationVal!=null){body["designation"]=designationVal;}
      // if(minexp!=null){body["minExp"]=minexp.toString();}
      // if(maxexp!=null){body["maxExp"]=maxexp.toString();}
      // if(skillSetVal!=null){body["skills"]=skillSetVal;}
      // if(minSalary!=null){body["minSalary"]=minSalary.toString();}
      // if(maxSalary!=null){body["maxSalary"]=maxSalary.toString();}


 print("FILTER BODY ");
 print(body);
      final response = await http.post(Uri.parse(api),body:body,headers: header);
        //final response = await http.get(Uri.parse("http://apimanago2.v3red.com/application/employer/6613711882ce01a8acb0268e"));
      print(api);
      // print(response.statusCode);
      print('Application against FILTER employer ${response.statusCode}');
      print(api);
      //print(response.body);

      if (response.statusCode == 200) {
        print("FILTER RESPONSE");
        print(response.body);
        final jsonResponse =
        applicantionAgainstEmployerModelFromJson(response.body);
        return jsonResponse;
      } else if (response.statusCode == 401) {
        final errorMessage = jsonDecode(response.body);
        Alert.showSnackbar(errorMessage['errorMessage'], context!);
        return null;
      } else {
        Map<String, dynamic> errorMessage = jsonDecode(response.body);
        print(errorMessage);
        Fluttertoast.showToast(
            msg: errorMessage['message'],
            timeInSecForIosWeb: 5,
            gravity:ToastGravity.BOTTOM,
            backgroundColor: Colors.white,
            textColor: Colors.red

        );
        //Alert.showSnackbar(errorMessage['message'], context!);
        return null;
      }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Null exception', context!);
        return null;
      } catch (e) {
        print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet', context!);
      return null;
    }
  }
}
