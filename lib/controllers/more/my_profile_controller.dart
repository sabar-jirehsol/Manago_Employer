

import 'package:http_parser/http_parser.dart';


import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/models/EmployerDetailsModel.dart';
import 'package:manago_employer/models/state_model.dart';
import 'package:manago_employer/services/EmployeeDetailsService.dart';
import 'package:manago_employer/services/EmployerUpdateService.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/more/sociallinks.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manago_employer/api/api.dart';

import '../../utils/success_dialogbox.dart';

class MyProfileController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //Personal Info
  PickedFile? profilePic;
  String? name;
  String? email;
  String? mobile;
  String? dialcode;
  String? address;
  String? aboutYourself;
  String? newState;
  String? city;
  String? PincodenewState;
  String? profilecountry;
  String? Pincodecity;
  String? pincode;
  String? profilepics;
  String? profile_mob_error_text;
  //buisness profile

  String? businessName;
  String? companyWebsite;
  String? companyEmail;
  //Todo i added below  country variable  from 8.4.24(6.12 pm) .it is new  and i am add  any for updating country
  String? companyCountry;
  String? companyState;
  String? companyCity;
  String? companyAddress;
  String? companyFoundedDate;
  String? companyDescription;
  String? firmType;
  String? gstIn;
  int? totalStaff;
  String? turnover;
  String? licenseNumber;
  String? facebook;
  String? linkedIn;
  String? twitter;
  String? instagram;
  String? other;

  List<India> tempStates = [];
  List<String> newStates = [];
  List<String> countries = [];
  List<String> cities = [];



  bool companynameError = false;
  bool websiteError = false;
  bool emailError = false;
  bool countryError=false;
  bool stateError=false;
  bool cityError=false;
  bool addressError=false;
  bool companyfounddateError=false;
  bool companySizeError=false;
  bool categoryError=false;
  bool gstError=false;
  bool descriptionError=false;

  String? websiteErrorText;

  bool nameError = false;
  bool personalemailError = false;
  bool mobileError = false;
  bool personaladdressError = false;
  bool pincodeError=false;
  bool personalcountryError=false;
  bool personalstatError=false;
  bool personalcityError=false;
  bool aboutyourselfError=false;
String?pincodeError_text;



  bool facebookError=false;
  bool linkedinError=false;
  bool twitterError=false;
  bool instagramError=false;


 String? facebookError_text,linkedinError_text,twitterError_text,instagramError_text;

  TextEditingController searchCountryController = TextEditingController();
  TextEditingController searchcompanyCountryController = TextEditingController();
  ImagePicker _picker = ImagePicker();

  //
  // takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(source: source);
  //   print("pickedfile ${pickedFile}");
  //   profilePic = pickedFile;
  //   notifyListeners();
  // }



  // Future<void> takePhoto(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.getImage(source: source);
  //   print("pickedfile $pickedFile");
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _employerUserId = _prefs.getString('employerUserId');
  //   if (pickedFile != null) {
  //     notifyListeners();
  //     String filename = pickedFile.path.split('/').last;
  //     print("filename ${filename}");
  //
  //     try {
  //       FormData data = FormData.fromMap({
  //         'file': [
  //           await MultipartFile.fromFile(pickedFile.path, filename: filename)
  //         ],
  //       });
  //
  //       var dio = Dio();
  //       var response = await dio.post(
  //         'http://apimanago2.v3red.com/employer/uploadEmployerProfileFile/$_employerUserId',
  //         data: data,
  //         onSendProgress: (int sent, int total) {
  //           // Handle progress if needed
  //         },
  //       );
  //       if (response.statusCode == 200) {
  //         print('Image uploaded successfully');
  //         print(response.data);
  //       } else {
  //         print('Image upload failed. Error: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       print('Error uploading image: $e');
  //     }
  //   }
  // }




  List<String> searchCountryList = [];

  getSearchCountryList(String value) async {
    EasyLoading.show(status: 'Please wait...', dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // String? _token = _prefs.getString('token');
    FilterDataServices.getSearchCountryList(
        API.preferredCountry, value, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        searchCountryList = value;
        print("Search Country Places");
        print(searchCountryList);
        setState(() {

        });
      }
    });
    EasyLoading.dismiss();
  }







  // loadCountries(BuildContext context) async {
  //   EasyLoading.show(status: 'Please wait...',dismissOnTap:false);
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _id = _prefs.getString('employerId');
  //   String? _token = _prefs.getString('token');
  //   FilterDataServices.getCountriesList(API.getCountryList,  scaffoldKey)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       countries = value.data;
  //       setState(() {});
  //     }
  //   });
  // }











  // loadStates(BuildContext context) async {
  //   EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _id = _prefs.getString('employerId');
  //   String? _token = _prefs.getString('token');
  //   FilterDataServices.getStatesList(API.getCityStateMap,  scaffoldKey)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       newStates = value;
  //       setState(() {});
  //     }
  //   });
  // }

  List<String> firmSize = [];
  String? selectedFirmSize;
  loadFirmSize(BuildContext context) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getSkills(API.getFirmSize, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        firmSize = value;
        setState(() {});
      }
    });
  }

  List<String> firmTypes = [];
  loadFirmType(BuildContext context) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getSkills(API.getFirmType, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        firmTypes = value;
        setState(() {});
      }
    });
  }



  loadCompanyStates(String country) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices.getCompanyStatesList(API.getCountryStateList,country, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        newStates = value.data;
        setState(() {});
      }
    });
  }


  loadcompanyStateCities( String country,String state) async {
    EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('employerId');
    String? _token = _prefs.getString('token');
    FilterDataServices. getCompanyStatesCityList(
        API.getCountryStatecityList, country,state, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        cities = value.data;
        setState(() {});
      }
    });
  }

  // loadCities(String state) async {
  //   EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _id = _prefs.getString('employerId');
  //   String? _token = _prefs.getString('token');
  //   FilterDataServices.getCitiesOfaStateList(
  //       API.getCityStateMap, state, scaffoldKey)
  //       .then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       cities = value;
  //       setState(() {});
  //     }
  //   });
  // }








  // loadStateandCitiesViaPincode(pincode,BuildContext context)async{
  //   EasyLoading.show(status: 'Please wait...',dismissOnTap: true,);
  //   SharedPreferences _prefs = await SharedPreferences.getInstance();
  //   String? _id = _prefs.getString('id');
  //   FilterDataServices.getSearchCitiesviaPincode(
  //       API.getLocationByPincode
  //   , pincode,
  //   scaffoldKey).then((value) {
  //     EasyLoading.dismiss();
  //     if (value != null) {
  //       pincodeError=false;
  //       pincodeError_text="";
  //      // cities = value;
  //       newState=value.data![0].stateName;
  //       city=value.data![0].districtName;
  //       print(value.data![0].stateName);
  //       print(value.data![0].districtName);
  //
  //       setState(() {});
  //     }
  //     // else{
  //     //   setState((){
  //     //     pincodeError=true;
  //     //     pincodeError_text="Enter Right Pincode";
  //     //   });
  //     // }
  //
  //
  //   });
  //   // pincodeError=true;
  //   // pincodeError_text="Enter Right Pincode";
  //
  // }





  Future<void> loadStateandCitiesViaPincode(String pincode, BuildContext context) async {
    EasyLoading.show(status: 'Please wait...', dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _id = _prefs.getString('id');

    try {
      final value = await FilterDataServices.getSearchCitiesviaPincode(API.getLocationByPincode, pincode, scaffoldKey);
      EasyLoading.dismiss();

      if (value != null && value.data != null && value.data!.isNotEmpty) {
        pincodeError = false;
        pincodeError_text = "";
        newState = value.data![0].stateName;
        city = value.data![0].districtName;
        print(value.data![0].stateName);
        print(value.data![0].districtName);
        setState(() {});
      } else {
        pincodeError = true;
        pincodeError_text = "Enter Right Pincode";
      }
    } catch (e) {
      EasyLoading.dismiss();
      pincodeError = true;
      //pincodeError_text = "Error occurred while fetching data";
      pincodeError_text = "Enter Right Pincode";
      newState='';
      city='';
      print("Error: $e");
    }
  }


  EmployerData? employeeData;
  EmployerData? companyData;

  getEmployeeDetail() async {
    EasyLoading.show(status: "Please wait...",dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _employeeID = _prefs.getString('employerId');
    String? _employerUserId = _prefs.getString('employerUserId');
    EmployeeDetailsService.getEmployeeDetails(
        '${API.employeeByUserId}/$_employerUserId',  scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        employeeData = value.data;

        profilepics=value.data!.profilepic;
        print(profilepics);
        name = value.data!.name;
        email = value.data!.email;
        dialcode=value.data!.dialcode;
        mobile=value.data!.mobile;
        address = value.data!.address;
        pincode=value.data!.pincode;
        profilecountry=value.data!.country;
        searchCountryController.text=value.data!.country??"";
        newState = value.data!.state;
        city = value.data!.city;
        aboutYourself = value.data!.about;
        setState(() {});
        print(dialcode);
        print("PINCODEEEEE");
        print(pincode);
        print("countryy");
        print(profilecountry);
      }
    });
  }

  getCompanyDetail() async {
    EasyLoading.show(status: "Please wait...",dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? _employeeID = _prefs.getString('employerId');
    String? _employerUserId = _prefs.getString('employerUserId');
    EmployeeDetailsService.getCompanyDetails(
        '${API.companyDetails}/$_employeeID',scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        companyData = value.data;
        businessName = companyData!.businessName;
        companyWebsite = companyData!.businessWebsite;
        companyEmail = companyData!.email;
        companyCountry=companyData!.businessCountry;
        searchcompanyCountryController.text=companyData!.businessCountry??"";
        companyState = companyData!.businessState;
        companyCity = companyData!.businessCity;
        companyAddress = companyData!.businessAddress;
        companyFoundedDate = companyData!.businessFoundedDate;
        selectedFirmSize = companyData!.firmSize;
        firmType = companyData!.category;
        gstIn = companyData!.gstnNo;
        companyDescription = companyData!.description;
        facebook = companyData!.facebook;
        linkedIn = companyData!.linkedin;
        twitter = companyData!.twitter;
        instagram = companyData!.instagram;
        other = companyData!.other;
        setState(() {});
        print("BUSINESS ADDREsss");
        print(companyAddress);
      }
    });
  }


  updateCompanyProfile(BuildContext context) async {
    if (businessName == null || businessName!.isEmpty) {
     companynameError=true;
      //return Alert.showSnackbar('Name should not be empty.', context);
    }  if (companyWebsite == null || companyWebsite!.isEmpty ) {
      websiteError=true;
      websiteErrorText="CompanyWebsite is not Empty.";
      //return Alert.showSnackbar('CompanyWebsite is not Empty.', context);
    }
     if (companyEmail == null || companyEmail!.isEmpty || !companyEmail!.contains('@')|| !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(companyEmail!)) {
      emailError=true;
      //return Alert.showSnackbar('Email is not valid.', context);
    }  if (companyAddress == null||companyAddress!.isEmpty) {
      addressError=true;
      //return Alert.showSnackbar('Address should not be empty.', context);
    }
    if (companyCountry == null) {
      countryError=true;
      // return Alert.showSnackbar('State should not be empty.', context);
    }
    if (companyState == null) {
      stateError=true;
     // return Alert.showSnackbar('State should not be empty.', context);
    }  if (companyCity == null) {
      cityError=true;
      //return Alert.showSnackbar('City should not be empty.', context);
    }
    // if (gstIn == null || gstIn!.isEmpty) {
    //   gstError=true;
    //   //return Alert.showSnackbar('Gst should not be empty.', context);
    // }
    if (firmType == null) {
      companySizeError=true;
      //return Alert.showSnackbar('Firm type should not be empty.', context);
        }
        if (gstIn!.isNotEmpty && !RegExp(r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$").hasMatch(gstIn!)) {
        gstError=true;
       // return Alert.showSnackbar('Please enter Gst in correct format', context);
     }
     if (companyDescription == null||companyDescription!.isEmpty) {
      descriptionError=true;

      //return Alert.showSnackbar('Description is not empty.', context);
    }
    if(companynameError==false &&websiteError==false &&emailError==false &&addressError==false  &&descriptionError==false) {
      EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _employerId = _prefs.getString('employerId');
      String? _employerUserId = _prefs.getString('employerUserId');
      //String? _token = _prefs.getString('token');
      EmployerUpdateService.updateCompany(
          API.companyUpdate,
          _employerId!,
          businessName!,
          companyWebsite!,
          companyEmail!,
          companyCountry!,
          companyState!,
          companyCity!,
          companyAddress!,
          companyFoundedDate!,
          selectedFirmSize!,
          firmType!,
          gstIn!,
          companyDescription!,
          // facebook!,
          // linkedIn!,
          // twitter!,
          // instagram!,
          //other!,
          _employerUserId!,
          scaffoldKey,context)
          .then((value) async {
        EasyLoading.dismiss();
        if (value != null) {
          //EasyLoading.showSuccess('Company Profile Updated',dismissOnTap: true,duration: Duration(seconds: 2));
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return   FunkyOverlay(
                      imagePath: 'assets/images/tick.png',
                      message:'Company Profile Updated successfully' ,
                      onTap:()async{

                      //Navigator.pop(context);
                     // await Future.delayed(Duration(milliseconds: 700)); //
                      print("AWAIT NAVIGATON");// Delay for 700 milliseconds
                       //Navigator.push(context, MaterialPageRoute(builder: (context) => SocialLinks()));
                     await Future.delayed(Duration(milliseconds: 700),(){
                       Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialLinks()));

                      });

                      }
                    );
                  },
                ),
              );
            },
          );


          //Alert.showSnackbar('Company Profile Updated', context);

          // Future.delayed(Duration(milliseconds: 700),(){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SocialLinks()));
          //
          // });


        }
      });
    }

  }





  socialLinksProfile(BuildContext context) async {
    // Validation for Facebook
    if (facebook == null || facebook!.isEmpty) {
      facebookError = true;
      facebookError_text = "Facebook should not be empty";
    } else if (_validateFacebook(facebook!)) {
      facebookError = true;
      facebookError_text = "Please enter a valid Facebook URL";
    }

    // Validation for LinkedIn
    if (linkedIn == null || linkedIn!.isEmpty) {
      linkedinError = true;
      linkedinError_text = "Linkedin should not be empty.";
    } else if (_validateLinkedin(linkedIn!)) {
      linkedinError = true;
      linkedinError_text = "Please enter a valid Linkedin URL";
    }

    // Validation for Twitter
    if (twitter == null || twitter!.isEmpty) {
      twitterError = true;
      twitterError_text = 'Twitter should not be empty.';
    } else if (_validateTwitter(twitter!)) {
      twitterError = true;
      twitterError_text = "Please enter a valid Twitter URL";
    }

    // Validation for Instagram
    if (instagram == null || instagram!.isEmpty) {
      instagramError = true;
      instagramError_text = 'Instagram should not be empty.';
    } else if (_validateInstagram(instagram!)) {
      instagramError = true;
      instagramError_text = "Please enter a valid Instagram URL";
    }

    // Proceed with update if all validations pass
    if (facebookError == false &&
        linkedinError == false &&
        twitterError == false &&
        instagramError == false) {
      // Show loading indicator

        EasyLoading.show(status: 'Please wait...', dismissOnTap: true);



      // Retrieve data from SharedPreferences
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _employerId = _prefs.getString('employerId');
      String? _employerUserId = _prefs.getString('employerUserId');

      // Call service to update social links
      EmployerUpdateService.updateSocialLinks(
        API.employeeUpdate,
        _employerId!,
        facebook!,
        linkedIn!,
        twitter!,
        instagram!,
        other,
        _employerUserId!,
        scaffoldKey,
        context,
      ).then((value) async {
        EasyLoading.dismiss();
        if (value != null) {
          // Show success message
          //Alert.showSnackbar('Social Links Updated', context);
          //EasyLoading.showSuccess('Company Details has been Updated',dismissOnTap: true,duration: Duration(seconds: 1));
          Navigator.pop(context);
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return   FunkyOverlay(
                        imagePath: 'assets/images/tick.png',
                        message:'Company Details has been Updated successfully' ,
                        onTap:(){

                          Navigator.pop(context);

                        }
                    );
                  },
                ),
              );
            },
          );

          // Navigate back after a delay
          // Future.delayed(Duration(milliseconds: 700), () {
          //   Navigator.pop(context);
          // });
        }
      });
    }
  }











  UpdatePersonalProfile(BuildContext context) async {
    if (name == null || name!.isEmpty) {
      nameError=true;
      //return Alert.showSnackbar('Name should not be empty.', context);
    }  if (email == null || email!.isEmpty || !email!.contains('@')|| !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$').hasMatch(email!)) {
      personalemailError=true;
      //return Alert.showSnackbar('Email is not valid.', context);
    } if (mobile == null || mobile!.isEmpty ) {
       mobileError=true;
       profile_mob_error_text='mobile is not Empty.';
      // return Alert.showSnackbar('mobile is not Empty.', context);
    }
    if ((dialcode!="+91" && mobile!.length<7)) {
      mobileError=true;
      profile_mob_error_text='Mobile number  must be at least 7 digits.';
      // return Alert.showSnackbar('mobile is not Empty.', context);
    }
    if (dialcode=="+91") {
      if(mobile!.length!=10){
      mobileError=true;
      profile_mob_error_text='Please Enter 10 digits ';
      // return Alert.showSnackbar('mobile is not Empty.', context);
    }}

     if (address == null || address!.isEmpty) {
       personaladdressError = true;
       //return Alert.showSnackbar('Adress should not be empty.', context);
     }
     if (pincode == null || pincode!.isEmpty) {
      pincodeError=true;
      pincodeError_text="Pincode should not be empty";
      //return Alert.showSnackbar('Adress should not be empty.', context);
    }
    if(profilecountry==null||profilecountry!.isEmpty){
      personalcountryError=true;
    }
     if (newState == null) {
      personalstatError=true;
       //return Alert.showSnackbar('State should not be empty.', context);
    }  if (city == null) {
       personalcityError=true;
      //return Alert.showSnackbar('City should not be empty.', context);
    }if (aboutYourself == null || aboutYourself!.isEmpty ) {
      aboutyourselfError=true;
       //return Alert.showSnackbar('About yourself is not empty.', context);
    }
    if(nameError == false&&personalemailError == false&&    mobileError == false&&
    personaladdressError == false&&pincodeError==false&&
    personalstatError==false&&
    personalcityError==false&&
    aboutyourselfError==false) {
      EasyLoading.show(status: 'Please wait...',dismissOnTap: true);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String? _employerId = _prefs.getString('employerId');
      String? _employerUserId = _prefs.getString('employerUserId');
      //String? _token = _prefs.getString('token');
      EmployerUpdateService.updateEmployer(
          API.employeeUpdate,
          _employerId!,
          name!,
          email!,
          address!,
          mobile!,
          pincode!,
          profilecountry!,
          newState!,
          city!,
          aboutYourself!,
         _employerUserId!,
          scaffoldKey,context)
          .then((value) async {
        EasyLoading.dismiss();
        if (value != null) {
          _prefs.setString('userName', name!);
         // _prefs.setString('profilePic', profilepics!);
          print("bdhjb");
          //print(( profilepics!));
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return WillPopScope(
                onWillPop: () async => false,
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return   FunkyOverlay(
                      imagePath: 'assets/images/tick.png',
                      message:'Profile Updated successfully' ,
                        onTap:(){

                          Navigator.pop(context);

                        }
                    );
                  },
                ),
              );
            },
          );

         // EasyLoading.showSuccess('Profile Updated',dismissOnTap: true,duration: Duration(seconds: 1));

          //Navigator.pop(context);

          // Alert.showSnackbar('Profile Updated', context);
          //
          // Future.delayed(Duration(milliseconds: 700),(){Navigator.pop(context);});

        }
      });
    }
  }















  bool _validateFacebook(String value) {

    if (value.isNotEmpty) {
      if (!RegExp(
          r'(?:(?:http|https):\/\/)?(?:www\.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?')
          .hasMatch(value)) {

        return true;
      }
    }
    return false;
  }

  bool _validateLinkedin(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(
          r'((https?:\/\/)?((www|\w\w)\.)?linkedin\.com\/)((([\w]{2,3})?)|([^\/]+\/(([\w|\d-&#?=])+\/?){1,}))$')
          .hasMatch(value)) {
       linkedinError_text='Please enter a valid LinkedIn URL';
        return true;
      }
    }
    return false;
  }

  bool _validateTwitter(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(
          r'(?:http:\/\/)?(?:www\.)?twitter\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-]*)')
          .hasMatch(value)) {
        twitterError_text='Please enter a valid Twitter URL';
        return true;
      }
    }
    return false;
  }

  bool _validateInstagram(String? value) {
    if (value != null && value.isNotEmpty) {
      if (!RegExp(
          r'(?:http:\/\/)?(?:www\.)?instagram\.com\/([a-zA-Z0-9_.]+)')
          .hasMatch(value)) {
       instagramError_text='Please enter a valid Instagram URL';
        return true;
      }
    }
    return false;
  }


}
