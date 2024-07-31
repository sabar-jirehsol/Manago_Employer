import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class Alert {
  // static void showSnackbar(String title, GlobalKey<ScaffoldState> scaffoldKey) {
  //   final _snackBar = SnackBar(
  //     //behavior: SnackBarBehavior.floating,
  //     //elevation: 5,
  //     //duration: Duration(seconds: 10),
  //     content: Text(title),
  //     action: SnackBarAction(
  //       textColor: kPrimaryColor,
  //       onPressed: () => scaffoldKey.currentState.hideCurrentSnackBar(),
  //       label: 'Dismiss',
  //     ),
  //   );
  //
  //   scaffoldKey.currentState.showSnackBar(_snackBar);
  // }

  static void showSnackbar(String text, BuildContext context){
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: (Colors.black),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showLogOutAlert(BuildContext context, Function? onTap) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titlePadding: EdgeInsets.symmetric(vertical: 16),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Are you sure you want to log out ?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xffF9F5F5),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 14),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: kBlueGrey, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: (){
                    onTap!();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
