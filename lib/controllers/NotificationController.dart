
import 'package:flutter/material.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/NotificationModel.dart';
import 'package:manago_employer/services/Getnotificationservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class NotificationController extends ControllerMVC {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Data? notify;
  List<Notifications> notif = [];
    getnotificationlist() async {
    //EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');

    String? _id = _prefs.getString('employerId');
      String? user_id = _prefs.getString('employerUserId');
    GetAllNotificationJobsServices.getAllNotificationJobs(
        "${API.getnotificationdata}/$user_id", scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {

       notif = value.data!.notify!;

       setState(() { });

      }
    });
  }



}