import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/models/state_model.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProfileOneController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? name;
  String? email;
  String? address;
  String? newState;
  String? city;

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
}
