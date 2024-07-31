import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manago_employer/api/api.dart';
// import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_notification_service.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static Future<void> addFCMtoken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? token = _prefs.getString('token');
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final fcmtoken = await _fcm.getToken();
    String? _employerUserId = _prefs.getString('employerUserId');
    // String? deviceId = await PlatformDeviceId.getDeviceId;

    try {
      Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'token $token',
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      final body = jsonEncode({
        "userId":_employerUserId,
         "deviceId": fcmtoken,
       // "fcmToken": fcmtoken,
        // "deviceType": "android",
        // "appName": "employer"
      });

      final response = await http.post(Uri.parse(API.updateFCMtoken),
          headers: header, body: body);
      print(body);
      print("Firebase Messaging ");
      print(response.body);
      print(response.statusCode);
      // Fluttertoast.showToast(
      //     msg:
      //         '$fcmtoken \n\n\n ${response.statusCode} : ${response.body.toString()}');
    } on SocketException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  static void getNotification() async {
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createAndDisplayNotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }
}
