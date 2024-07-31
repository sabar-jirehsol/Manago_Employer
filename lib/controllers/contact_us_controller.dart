import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/services/ContactUsSerives.dart';
import 'package:manago_employer/views/bottom_navigation/dashboard.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/alert.dart';








class ContactUsController extends ControllerMVC{
     GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();

     String? name;
     String? email;
     String? message;

     submitContactUs(BuildContext context) async{
       if(name==null ||  name!.isEmpty){
         Alert.showSnackbar("Name is required",context);
       }
       else if (email == null || email!.isEmpty ) {
         return Alert.showSnackbar('Email is Required.', context);
       }
       else if(!email!.contains('@')|| !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(email!)){
         return Alert.showSnackbar('Email is invalid', context);
       }

       else if(message==null ||  message!.isEmpty){
         Alert.showSnackbar("Message is required",context);
       }
       else{
         SharedPreferences _prefs = await SharedPreferences.getInstance();
         String? _employerId = _prefs.getString('employerId');
         String? _employerUserId = _prefs.getString('employerUserId');

         ContactUsService.submitContactus(
             API.updatecontactus,
             _employerUserId!,
             name!,
             email!,
             message!,
             scaffoldKey,
             context)
             .then((value) async{

               if(value !=null){
                 print( _employerUserId );
                 print(value.data!.context);
                 
                 Alert.showSnackbar("Contacts submitted  successfully", context);
                 // Future.delayed(Duration(milliseconds: 700),(){
                 //   Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx)=>DashBoard()));
                 // });


               }




         });

       }


     }

}