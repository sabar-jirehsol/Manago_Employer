
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/components/reusable_readonly_textfield.dart';
import 'package:manago_employer/services/EmployeeDetailsService.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/StateCityServices.dart';
import '../../../utils/success_dialogbox.dart';
import '../../intro_screen/login_screen.dart';
import 'company_profile.dart';
import 'myprofile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class MyProfileLanding extends StatefulWidget {
  const MyProfileLanding({Key? key}) : super(key: key);

  @override
  _MyProfileLandingState createState() => _MyProfileLandingState();
}

class _MyProfileLandingState extends State<MyProfileLanding> {
  @override
  void initState() {
    getEmployeeDetail();

    super.initState();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? name;
  String? email;
  String? mobile;
  String? address;
  String? profilepics;
  String? dialcode;
  DateTime? modify;


  getEmployeeDetail() async {
    EasyLoading.show(status: "Please wait...", dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //String? _token = _prefs.getString('token');
    String? _employeeID = _prefs.getString('employerId');
    String? _employerUserId = _prefs.getString('employerUserId');
    print('emp details');
    // print(_token);
    print(_employerUserId);
    EmployeeDetailsService.getEmployeeDetails(
        '${API.employeeByUserId}/$_employerUserId', scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        // name = value.data!.name;
        // email = value.data!.email;
        // address = value.data!.address;
        // mobile = value.data!.mobile;
        // profilepics=value.data!.profilepic;
        setState(() {
          name = value.data!.name;
          email = value.data!.email;
          address = value.data!.address;
          mobile = value.data!.mobile;
          profilepics = value.data!.profilepic;
          dialcode = value.data!.dialcode;
          print("profile Landing  dialcode is ${dialcode}");
          modify = value.data!.modifiedAt;
        });
      }
    });
  }

  deleteAccount()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _employerUserId = _prefs.getString('employerUserId');
    final response=await http.get(Uri.parse('${API.deleteaccount}/$_employerUserId'));

    if(response.statusCode==200){
      print("Deleting the Account....... ");
      print("UserId${_employerUserId}");
      print(response.body);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
      );
      final DelMessage = jsonDecode(response.body);
      Fluttertoast.showToast(msg: DelMessage["message"]);
      return response;

    }
  }
  Future<void> takePhoto(ImageSource source) async {
    PermissionStatus status;
    if (source == ImageSource.camera) {
      status = await Permission.camera.status;
      if (status.isDenied ) {
        status = await Permission.camera.request();
        print("camera access denied");
      }
    } else {
      status = await Permission.storage.status;
      if (status.isDenied ) {
        status = await Permission.photos.request();
        print("Gallery access denied");
      }
    }
    if (status.isGranted) {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _employerUserId = _prefs.getString('employerUserId');

    if (pickedFile != null) {
      String filename = pickedFile.path
          .split('/')
          .last;

      try {
        FormData data = FormData.fromMap({
          'file': [
            await MultipartFile.fromFile(pickedFile.path, filename: filename)
          ],
        });

        var dio = Dio();
        var response = await dio.post(
          'http://apimanago2.v3red.com/employer/uploadEmployerProfileFile/$_employerUserId',
          data: data,
          onSendProgress: (int sent, int total) {
            // Handle progress if needed
          },
        );

        if (response.statusCode == 200) {
          // Navigator.pop(context);
          setState(() {
            // Assuming the image URL is returned in the response
            profilepics = response.data['imageUrl'];
          });
          print('Image uploaded successfully');

          await EasyLoading.showToast("Profile pic uploaded successfully.",
              duration: Duration(seconds: 3));
          getEmployeeDetail();

          print(response.data);
          // Future.delayed(Duration(milliseconds: 700), () {
          //   Navigator.pop(context);
          //   EasyLoading.showToast("Profile pic uploaded successfully.");
          //   getEmployeeDetail();
          //   print(response.data);
          // });

        } else {
          print('Image upload failed. Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }
    else {
      showDialog(
        context: context!,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: StatefulBuilder(
              builder: (context, setState) {
                return FunkyOverlay(
                    imagePath: 'assets/images/app_permission.png',
                    message: 'This feature requires camera or gallery access. Please enable the required permissions in the app settings.',
                    onTap: () {
                      openAppSettings();
                      Navigator.pop(context);
                    }
                );
              },
            ),
          );
        },
      );
    }
}











  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor.withOpacity(0.2),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context,profilepics);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kPrimaryColor,
                  )),
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: name == null
            ? Container()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //SizedBox(height: 30),
                    // CircleAvatar(
                    //   radius: 70,
                    //   backgroundImage:NetworkImage(profilepics.toString()) //AssetImage('assets/images/logo.png'),
                    // ),
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          // CircleAvatar(
                          //   backgroundColor: kBlueGrey,
                          //   radius: 70,
                          //   backgroundImage: profilepics.isEmpty
                          //       ? AssetImage('assets/images/add_image.png')as ImageProvider<Object>
                          //       : NetworkImage(profilepics),
                          // ),
                          CircleAvatar(
                             backgroundColor: Colors.transparent,
                            radius: 70,
                            backgroundImage:(profilepics)==null?AssetImage('assets/images/logo.png') as ImageProvider<Object>:NetworkImage(profilepics.toString()),
                              ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: kBlueGrey),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.camera_alt,
                                  size: 20, color: Colors.white,

                                ),
                                onPressed: () {

                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 100,
                                        width: MediaQuery.of(context).size.width,
                                        margin:
                                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Choose a Profile Photo',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton.icon(
                                                    onPressed: () async{
                                                      Navigator.pop(context);

                                                      await takePhoto(ImageSource.camera);
                                                      //Navigator.pop(context);
                                                      // Future.delayed(Duration.zero, () {
                                                      //   Navigator.pop(context);
                                                      // });
                                                    },
                                                    icon: Icon(Icons.camera),
                                                    label: Text('Camera')),
                                                SizedBox(width: 10,),
                                                ElevatedButton.icon(
                                                    onPressed: () async{
                                                      Navigator.pop(context);

                                                      await

                                                      takePhoto(ImageSource.gallery);
                                                      //Navigator.pop(context);
                                                    },
                                                    icon: Icon(Icons.image),
                                                    label: Text('Gallery'))
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );









                                }


                            ),
                          ),
                        ],),
                    ),
                    SizedBox(height: 16),
                    Text(
                      name!,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    // #TODO
                    Text(
                      'This profile was last updated on ${modify?.day}-${modify?.month}-${modify?.year}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kGreyColor, fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Divider(
                        color: kGreyColor,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.phone,
                        color: kBlueGrey,
                      ),
                      title: Text(
                        'Phone Number',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${dialcode??" "} ${mobile!}',
                        style: TextStyle(
                            color: kGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.mail,
                        color: kBlueGrey,
                      ),
                      title: Text(
                        'Email',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        email!,
                        style: TextStyle(
                            color: kGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        Icons.location_pin,
                        color: kBlueGrey,
                      ),
                      title: Text(
                        'Address',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        address ?? '',
                        style: TextStyle(
                            color: kGreyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Divider(
                        color: kGreyColor,
                      ),
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: kGreyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfile(),
                            )).then((value) {
                          getEmployeeDetail();
                          setState(() {});
                        });
                      },
                      title: Text(
                        'Personal Profile',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: kBlueGrey,
                      ),
                    ),
                    SizedBox(height: 12),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: kGreyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CompanyProfile(),
                            )).then((value) {
                          getEmployeeDetail();

                          setState(() {});
                        });
                      },
                      title: Text(
                        'Company Profile',
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: kBlueGrey,
                      ),
                    ),
                    SizedBox(height: 12),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: kGreyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onTap: () async{

                        await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Delete'),
                            content: Text('Are you sure you want to delete account?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // User canceled delete
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async{
                                  Navigator.pop(context);
                                  await  deleteAccount();
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                        );
                          setState(() {});

                      },
                      title: Text(
                        'Delete Account',
                        style: TextStyle(

                             color: kPrimaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.delete,
                        color:kBlueGrey,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
