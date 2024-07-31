import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

Color PrimaryColor = const Color(0xff535f77);

const String CHECK_INTERNET = "Please check your internet connection!";
const String SOMETHING_WENT_WRONG = "Something went wrong DATA!";

const double HEADER_PADDING_HORIZONTAL = 12.0;
const double HEADER_PADDING_VERTICAL = 20.0;
const double MENU_PADDING_HORIZONTAL = 20.0;
const double MENU_PADDING_VERTICAL = 16.0;

class FileConverter {
  static String getBase64FormateFile(File file) {
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }

  static String getFileExtension(String path) {
    String str = path.split(".").last;
    return str;
  }
}

showLoaderDialog({BuildContext? context, String? msg, bool? barrierDismissible}){
  AlertDialog alert  =  AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(width: 12,),
        Container(margin: const EdgeInsets.only(left: 7),child:Text(msg ?? "Loading..." )),
      ],),
  );
  showDialog(barrierDismissible: barrierDismissible ?? false,
    context:context!,
    builder:(BuildContext context){
      return alert;
    },
  );
}



imageOption({BuildContext? context, Function? onTapOption}){
  AlertDialog alert  =  AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context!).size.width,

          alignment: Alignment.topRight,
          child: InkWell(child: const Icon(Icons.clear),onTap: (){
            Navigator.of(context).pop();
          },),
        ),

        Text("Take Image",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: PrimaryColor),),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){onTapOption!(1);},
                  child: Image.asset("assets/logo/camera.png",width: 70,height: 70,)),
              const SizedBox(width: 30,),
              InkWell(
                  onTap: (){onTapOption!(2);},
                  child: Image.asset("assets/logo/gallery.png",width: 70,height: 70,)),

            ],),
        ),
      ],
    ),
  );
  showDialog(barrierDismissible: true,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}



