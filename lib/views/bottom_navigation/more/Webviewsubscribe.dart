import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:manago_employer/api/ApiClient.dart';
import 'package:manago_employer/api/Status.dart';
import 'package:manago_employer/models/SubscriptionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:manago_employer/api/Resource.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/services/SubscriptionDetailService.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Subscription.dart';

class Webviewsubs extends StatefulWidget {
  String? id;
  String? subscriptionid;

  Webviewsubs({@required this.id});

  @override
  Webviewsubscription createState() => Webviewsubscription();
}

class Webviewsubscription extends State<Webviewsubs> {
  WebViewController? webcontroller;

  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    //      getgroupdata();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MySubscription()));
                    //  Navigator.of(context).pop();
                  },
                ),
                title: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Subscription'),
                )),
            body: WebView(
                initialUrl: widget.id,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url) {
                  setState(() {});
                },
                onWebViewCreated: (WebViewController webViewController) async {
                  _controllerCompleter.complete(webViewController);
                  EasyLoading.dismiss();
                })),
        onWillPop: () {
          // getgroupdata();
          return Future.value(true);
        });

    // TODO: implement build
  }
  // void getgroupdata() async {
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String _token = _prefs.getString('token');
  //   Resource _response = await ApiClient.loadbackbutton(
  //       url: API.getBacButtonSubscription,
  //       token: _token,
  //   );
  //
  //   if (_response.status == STATUS.SUCCESS) {
  //     try {
  //       // Directory tempDir = Directory('/storage/emulated/0/Download');
  //       // String tempPath = tempDir.path;
  //       // File file = new File('$tempPath/Trial_balance.xlsx');
  //       // await file.writeAsBytes(_response.data) as File;
  //       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardPage(names:names)), (route) => false);
  //     } catch (ex) {
  //       print(ex);
  //     }
  //   } else {
  //     setState(() {});
  //
  //     print(_response.data);
  //     print(_response.status);
  //     print(_response.message);
  //     // Fluttertoast.showToast(
  //     //     msg:_response.data,
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.CENTER,
  //     //     timeInSecForIosWeb: 1,
  //     //     backgroundColor: Colors.red,
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0
  //     // );
  //   }
  // }

}
