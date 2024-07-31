import 'package:manago_employer/models/SubscriptionModel.dart';
import 'package:manago_employer/services/SubscriptionDetailService.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manago_employer/api/api.dart';

class Mysubscriptioncontroller extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? status;
  String? amountperunit;
  String? plandescription;
  String? planname;

  Subscription? sub;
  List<SubscriptionDetails>? subscriptiondet;
  getsubscriptiondetails() async {
    //EasyLoading.show(status: "Please wait...");
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    SubscriptionDetailservice.getsubscriptionDetails(API.getsubscription, scaffoldKey)
        .then((value) {
      if (value != null) {
        subscriptiondet = value.data! ;

        printSubscriptions(); // Call method to print subscriptions

        setState(() {});
        EasyLoading.dismiss();
      }
    });
  }



  void printSubscriptions() {
    if (subscriptiondet != null) {
      for (var subscription in subscriptiondet!) {
        status=subscription.status;
        amountperunit=subscription.amountPerUnit;
        plandescription=subscription.planDescription;
        planname=subscription.planName;
        print('Subscription Details:');
        print('---------------------');
        print('Plan Name: ${subscription.planName}');
        print('Message: ${subscription.offerMessage}');
        print('Plan Description: ${subscription.planDescription}');
        print('Plan ID: ${subscription.planId}');
        print('Amount: ${subscription.amountPerUnit}');
        print("Biling Cycle :${subscription.billingCycle}");

         print('Subscription plans: ${subscription.plans}');
        print('Subscription subs: ${subscription.subscriptions}');


        // print('Subscription Status: ${subscription.subscriptionstatus}');
        //print('Plan Description: ${subscription.subdescription}');
        print('Subscription Action Buttons:');
        for (var button in subscription.subscriptions ?? []) {
          print('  Button Label: ${button.lebel}');
          print('  Button URL: ${button.url}');
          print('  Button API: ${button.api}');
        }
        print('---------------------');
      }
    } else {
      print('No subscriptions available.');
    }
  }
}
