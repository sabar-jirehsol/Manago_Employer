import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:manago_employer/api/ApiClient.dart';
import 'package:manago_employer/api/Status.dart';
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

class Webviewmanago extends StatefulWidget {
  String? id;
  String? subscriptionid;


  @override
  Webviewsubscription createState() => Webviewsubscription();

}
class Webviewsubscription extends State<Webviewmanago> {
  WebViewController? webcontroller;

  final Completer<WebViewController> _controllerCompleter  =
  Completer<WebViewController>();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();

              } ,
            ),
            title:Padding(
              padding: EdgeInsets.all(10),
              child: Text('Download the APP'),

            )
        ),
        body:
        WebView(
            initialUrl: 'https://play.google.com/store/apps/details?id=com.manago.manpower',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished:  (String url){
              setState(() {
                EasyLoading.dismiss();

              });

            }   ,

        )
    );
    // TODO: implement build

  }



}



