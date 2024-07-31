import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:manago_employer/components/notification_container.dart';
import 'package:manago_employer/controllers/NotificationController.dart';
import 'package:manago_employer/models/NotificationModel.dart';
import 'package:manago_employer/provider/profile.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends StateMVC<NotificationPage> {
  int? _selectedIndex;
  NotificationController? con;

  _NotificationPageState() : super(NotificationController()) {
    con = controller as NotificationController?;
  }
  // List<bool> seen = List.generate(alldata.length, (index) => false);

  @override
  void initState() {
    con!.getnotificationlist();
    RenderErrorBox.backgroundColor = Colors.transparent;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  }

  List<Notifications> alldata = [];

  @override
  Widget build(BuildContext context) {
    alldata = con!.notif;
    // Fluttertoast.showToast(msg: "Toast" + alldata[0].message!);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor.withOpacity(0.2),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kPrimaryColor,
                  )),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Notifications',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: ListView.builder(
          // separatorBuilder: (context, index) => SizedBox(
          //   height: 5,
          // ),
          reverse: true,
          shrinkWrap: true,
          itemCount: alldata.length,
          itemBuilder: (context, index) => Consumer<ProfileImage>(
            builder: (context, value, child) => NotificationContainer(
              title: alldata[index].message,
              date: alldata[index].date == null ? "Date" : alldata[index].date,
              color: alldata[index].newdata == 1 ? Colors.grey.shade300 : null,
              ontap: () {
                // setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}
