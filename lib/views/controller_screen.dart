import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/controllers/dashboard_controller.dart';
import 'package:manago_employer/services/notificationService/NotificationHelper.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/applicants.dart';
import 'package:manago_employer/views/bottom_navigation/dashboard.dart';
import 'package:manago_employer/views/bottom_navigation/employees.dart';
import 'package:manago_employer/views/bottom_navigation/job/jobs.dart';
import 'package:manago_employer/views/bottom_navigation/more.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bottom_navigation/emptyscreen.dart';
import 'bottom_navigation/more/Webviewmanagoapp.dart';
import 'bottom_navigation/more/notification.dart';

class ControllerScreen extends StatefulWidget {
  final int? screenidx;

  const ControllerScreen({Key? key, this.screenidx}) : super(key: key);

  @override
  _ControllerScreenState createState() => _ControllerScreenState();
}

class _ControllerScreenState extends StateMVC<ControllerScreen> {
  _ControllerScreenState() : super(dashboardController()) {
    _con = controller as dashboardController?;
  }

  dashboardController? _con;
  int? currentIndex;

  int? idx;
  TextEditingController version = TextEditingController();
  final List<Widget> tabs = [DashBoard(), Jobs(), Applicants(), Employees(),Emptyscreen()];


  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    _checkPermissions();
    NotificationService.addFCMtoken();

    _con!.getUserDetails();


    Timer(Duration(seconds: 1), () {});
  }

  Future<void> _checkPermissions() async {
    await Permission.mediaLibrary.request();
    await Permission.photos.request();
    await Permission.photosAddOnly.request();
    await Permission.accessMediaLocation.request();
    await Permission.notification.request();
    await Permission.storage.request();
    await Permission.videos.request();
  }





  Future<void> _closeApp() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Are you sure you want to close the app?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'No',
                style: TextStyle(color: kPurple),
              ),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text(
                'Yes',
                style: TextStyle(color: kPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    idx = 0;
    currentIndex = widget.screenidx ?? idx;
    print("current Index in didChangeDependencies ${currentIndex}");
  }
  bool isDrawerOpened = false;
  @override
  Widget build(BuildContext context) {
    version.text = "1.0.2";
    RenderErrorBox.backgroundColor = Colors.transparent;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) {
          _closeApp();
          return false;
        } else {
          setState(() {
            currentIndex = 0;
          });
          return false;
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: _con!.scaffoldKey,
          drawer: More(),

          onDrawerChanged: (isOpen) {
            Future.delayed(Duration.zero, () {
              isDrawerOpened = isOpen;
              setState(() {});
            });


          },
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                _con!.scaffoldKey.currentState!.openDrawer();
              },
              icon: Image.asset('assets/images/menu.png'),
            ),
            title: Text(
              getTitle(currentIndex!),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: kPrimaryColor,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPage(),
                    ),
                  );
                },
                icon: Image.asset('assets/images/bell.png'),
              ),
            ],
          ),
          body:  isDrawerOpened?tabs[4]: tabs[currentIndex!],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: klightGreyColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex!,
            onTap: (int index) {
              setState(() {
                currentIndex = index;

              });
            },
            items: [
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                  currentIndex == 0 ? Colors.white : Colors.transparent,
                  child: Image.asset('assets/images/dashboard.png',
                      scale: 1.3, color: kBlueGrey),
                ),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                  currentIndex == 1 ? Colors.white : Colors.transparent,
                  child: Image.asset('assets/images/jobs.png',
                      height: 24, color: kBlueGrey),
                ),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                  currentIndex == 2 ? Colors.white : Colors.transparent,
                  child: Image.asset('assets/images/offerletter.png',
                      scale: 1.6, color: kBlueGrey),
                ),
                label: 'Applicants',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor:
                  currentIndex == 3 ? Colors.white : Colors.transparent,
                  child: Image.asset('assets/images/employee.png',
                      scale: 1.3, color: kBlueGrey),
                ),
                label: 'Employee',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
  }

  String getTitle(int idx) {
    switch (idx) {
      case 0:
        // return 'Dashboard';
        return '';
      case 1:
        return 'Posted Jobs';
      case 2:
        return 'Applicants';
      case 3:
        return 'Employees';
      default:
        return '';
    }
  }
}
