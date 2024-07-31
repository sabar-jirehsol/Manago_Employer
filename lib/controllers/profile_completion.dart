import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/state_model.dart';
import 'package:manago_employer/services/EmployerUpdateService.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/validate_email.dart';
import 'package:manago_employer/views/controller_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCompletionController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //Personal Info
  PickedFile? profilePic;
  String? name;
  String? email;
  String? address;
  String? newState;
  String? city;
  String? pincode;
  //buisness profile
  String? businessName;
  String? firmType;
  String? gstIn;
  int? totalStaff;
  String? turnover;

  TextEditingController cityController = TextEditingController();

  List<India> tempStates = [];
  List<String> newStates = [];
  List<String> cities = [];

  loadStates(BuildContext context) async {
    String data = await rootBundle.loadString('assets/location/states.json');
    final jsonResult = stateModelFromJson(data);
    tempStates = jsonResult.india!;
    jsonResult.india!.forEach((element) {
      newStates.add(element.state!);
      setState(() {});
    });
  }

  loadCities(String state) {
    city = null;
    for (India item in tempStates) {
      if (item.state == state) {
        setState(() {
          cities = item.cities!;
        });
      }
    }
  }

  List<String> firmArray = [
    'Cafe',
    'Snacks center',
    'Hotel',
    'Restaurant ',
    'Pub',
    'Online Kitchen'
  ];
  List<String> turnoverArray = [
    "< 5L",
    "5L – 10L",
    "10L -25L",
    "25L +",
    "Doesn't want to share",
  ];

  //Documents
  String? adhaar;

  // pick file
  void getAdhar() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      String filePath = result!.files.single.path!;
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      filePath = filePath.split('/').last.toString();
      setState(() {
        adhaar = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  String? companyRegistration;
  void getCompanyRegistration() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      String filePath = result!.files.single.path!;
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      filePath = filePath.split('/').last.toString();
      setState(() {
        companyRegistration = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  ImagePicker _picker = ImagePicker();

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    profilePic = pickedFile;
    notifyListeners();
  }

  // updateEmployer(BuildContext context) async {
  //   if (name == null || name!.isEmpty) {
  //     return Alert.showSnackbar('Name is required.', context);
  //   } else if (email == null || email!.isEmpty || email!.contains('@.')) {
  //     return Alert.showSnackbar('Email is required.', context);
  //   } else if (address == null || address!.isEmpty) {
  //     return Alert.showSnackbar('Adress is required.', context);
  //   } else if (newState == null) {
  //     return Alert.showSnackbar('State is required.', context);
  //   } else if (city == null) {
  //     return Alert.showSnackbar('City is required.', context);
  //   } else if (pincode == null || pincode!.isEmpty) {
  //     return Alert.showSnackbar('Pincode is required.', context);
  //   } else if (businessName == null || businessName!.isEmpty) {
  //     return Alert.showSnackbar('Buisness is required.', context);
  //   } else if (firmType == null) {
  //     return Alert.showSnackbar('Firm type is required.', context);
  //   } else {
  //     EasyLoading.show(status: 'Please wait...');
  //     SharedPreferences _prefs = await SharedPreferences.getInstance();
  //     String? _employerId = _prefs.getString('employerId');
  //     String? _employerUserId = _prefs.getString('employerUserId');
  //     //String? _token = _prefs.getString('token');
  //     EmployerUpdateService.updateEmployer(
  //             API.employeeUpdate,
  //             _employerId!,
  //             name!,
  //             email!,
  //             address!,
  //             mobile!,
  //             pincode!,
  //             //country!,
  //             newState!,
  //             city!,
  //             //pincode!,
  //             businessName!,
  //         _employerUserId!,
  //             scaffoldKey, context)
  //         .then((value) async {
  //       EasyLoading.dismiss();
  //       if (value != null) {
  //         SharedPreferences _prefs = await SharedPreferences.getInstance();
  //         _prefs.setBool('isProfileSet', true);
  //         print(value.employer);
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => ControllerScreen(),
  //             ));
  //       }
  //     });
  //   }
  // }
}
