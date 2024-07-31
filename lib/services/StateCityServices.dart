import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:manago_employer/models/StateCityModel.dart';
import 'package:manago_employer/models/common_location_model.dart';
import 'package:manago_employer/utils/alert.dart';
import 'package:manago_employer/utils/connection.dart';

import '../models/SelectCountryModel.dart';
import '../models/StateCityViaPincodeModel.dart';

class FilterDataServices {
  static BuildContext? context;





  static Future<StateCountryModel?> getCountriesList(
      String api,

      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
        print("COUNTRY LIST");
        print(api);

        //final response = await http.get(Uri.parse(api));
        final response = await http.get(Uri.parse(api));

        if (response.statusCode == 200) {

          StateCountryModel jsonResponse = stateCountryModelFromJson(response.body);
          Map<String, dynamic> json = jsonDecode(response.body);
          print(json);
          List<String> country = [];
          for (var item in json['data']){
            country.add(item);
          }



          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }






  static Future<List<String>?> getStatesList(
    String api,


    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };

        final response = await http.get(Uri.parse(api));
        if (response.statusCode == 200) {
          StateCityModel jsonResponse = stateCityModelFromJson(response.body);
          final states = <String>[];

          for (final stateData in jsonDecode(response.body).values.first) {
            final state = stateData['state'] as String;
            states.add('$state');
          }
          return states;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }

  static Future<List<String>?>getCitiesOfaStateList(String api,String statename,GlobalKey<ScaffoldState> scaffoldKey,) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };

        final response = await http.get(Uri.parse(api));
        if (response.statusCode == 200) {
          StateCityModel jsonResponse = stateCityModelFromJson(response.body);
          final cities = <String>[];

          for (final stateData in jsonDecode(response.body).values.first) {
            final state = stateData['state'] as String;
            if (state == statename) {
              for (final city in stateData['cities'] as List) {
                // cities.add('$city,$state');
                cities.add('$city');
              }
            }
          }
          return cities;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }

  static Future<List<String>?> getCitiesList(
    String api,

    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
         // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final response = await http.get(Uri.parse(api), headers: header);
        if (response.statusCode == 200) {
          StateCityModel jsonResponse = stateCityModelFromJson(response.body);
          final cities = <String>[];

          for (final stateData in jsonDecode(response.body).values.first) {
            final state = stateData['state'] as String;
            for (final city in stateData['cities'] as List) {
              // cities.add('$city,$state');
              cities.add('$city');
            }
          }
          return cities;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }

  static Future<CommonLocationModel?> getAllStateCitiesList(
      String api,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };

        final response = await http.get(Uri.parse(api), headers: header);
        if (response.statusCode == 200) {
          CommonLocationModel jsonResponse = CommonLocationModel.fromJson(jsonDecode(response.body));
          // final cities = <String>[];
          //
          // for (final stateData in jsonDecode(response.body).values.first) {
          //   final state = stateData['state'] as String;
          //   for (final city in stateData['cities'] as List) {
          //     // cities.add('$city,$state');
          //     cities.add('$city');
          //   }
          // }
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }

  static Future<List<String>?>getDesignations(
    String api,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
       // };

        final response = await http.get(Uri.parse(api));
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          List<String> labels = [];

          for (var item in json['data']) {
            if (item.containsKey('designationTitle')) { // Check if 'designationTitle' key exists
              labels.add(item['designationTitle']);
            }

          }
          print("Desigination ${labels}");
          return labels;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }

  static Future<List<String>?> getSkills(
    String api,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   // HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
         print("API of firms&Size&skill&ex ${api}");

        final response = await http.get(Uri.parse(api));
        print("firm &Size&skill res ${response.statusCode}");
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          print(json);
          List<String> labels = [];

          // for (var item in json['data']) {
          //   print('Keys in item: ${item.keys}');
          //  if (item.containsKey('firmname')) { // Check if 'firmname' key exists
          //     labels.add(item['firmname']);
          //   }
          //  else if(item.containsKey('strength')){
          //    labels.add(item['strength']);
          //  }
          //  else if(item.containskey('skillName')){
          //    labels.add(item['skillName']);
          //  }
          for (var item in json['data']) {
            if (item.containsKey('firmname')) {
              labels.add(item['firmname']);
            }
            if (item.containsKey('strength')) {
              labels.add(item['strength']);
            }
            if (item.containsKey('skillName')) {
              labels.add(item['skillName']);
            }




        }
          return labels;


        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }



  static Future<List<String>?>getExperience(
      String api,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };

        final response = await http.get(Uri.parse(api));
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          List<String> labels = [];

          for (var item in json['data']) {
            if (item.containsKey('experienceRange')) { // Check if 'designationTitle' key exists
              labels.add(item['experienceRange']);
            }

          }
          print("Experience ${labels}");
          return labels;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }













  static Future<List<String>?> getJobTitles(
    String api,
    //String token,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   //HttpHeaders.authorizationHeader: 'token $token',
        //  // HttpHeaders.contentTypeHeader: 'application/json'
        // };
        print(api);
        final response = await http.get(Uri.parse(api));
        print("GETT APPLICATION DESIGNSTION");
        print(response.statusCode);

        print((response.body));
        if (response.statusCode == 200) {
          Map<String, dynamic> json =jsonDecode(response.body);
          print("JSON APPLICA ${json}");
          List<String> labels = [];

          // for (var item in json['values']) {
          //   labels.add(item['label']);
          // }

          for (var item in json['data']) {
            // if (item.containsKey('cities')) {
            //   labels.add(item['cities']);
            // }
            if (item.containsKey('designationTitle')) {
              labels.add(item['designationTitle']);
              print("designation Title");
              print(labels);
            }
            if (item.containsKey('experienceRange')) {
              labels.add(item['experienceRange']);
            }
            if (item.containsKey('skillName')) {
              labels.add(item['skillName']);
            }
          }


          return labels;
         }else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }


  static Future<List<String>?> getSearchCountryList(
      String api,
      String value,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body=jsonEncode({

          "name":value

        });

        final response = await http.post(Uri.parse(api),body: body, headers: header);
        print("SEARCH country");
print("body");
print(body);
        print(api);
        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          //StateCityModel jsonResponse = stateCityModelFromJson(response.body);
          Map<String, dynamic> json =jsonDecode(response.body);
          //final Searchcities = <String>[];
          List<String> Searchcountries = [];

          // for (final stateData in jsonDecode(response.body).values.first) {
          //   final state = stateData['India'] as String;
          //   for (final city in stateData['cities'] as List) {
          //     // cities.add('$city,$state');
          //     Searchcities.add('$city');
          //   }
          // }
          for (var item in json['data']) {


              Searchcountries.add(item);

          }
          print(Searchcountries);
          return Searchcountries;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }




  static Future<List<String>?> getSearchCitiesList(
      String api,
      String value,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body=jsonEncode({

             "cityName":value

        });

        final response = await http.post(Uri.parse(api),body: body, headers: header);
        print("SEARCH LOCATION");
        print(api);
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          //StateCityModel jsonResponse = stateCityModelFromJson(response.body);
          Map<String, dynamic> json =jsonDecode(response.body);
          //final Searchcities = <String>[];
          List<String> Searchcities = [];

          // for (final stateData in jsonDecode(response.body).values.first) {
          //   final state = stateData['India'] as String;
          //   for (final city in stateData['cities'] as List) {
          //     // cities.add('$city,$state');
          //     Searchcities.add('$city');
          //   }
          // }
          for (var item in json['data']) {

            if (item.containsKey("_id")) {
              Searchcities.add(item["_id"]);
            }
          }
          print(Searchcities);
          return Searchcities;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }















  static Future<stateCityViaPincodeModel?> getSearchCitiesviaPincode(
      String api,
      String value,
      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        Map<String, String> header = {
          // HttpHeaders.authorizationHeader: 'token $token',
          HttpHeaders.contentTypeHeader: 'application/json'
        };
        final body=jsonEncode({

          "pincode":value

        });

        final response = await http.post(Uri.parse(api),body: body, headers: header);
        print("Pincode ___>LOCATION");
        print(api);
        print(response.statusCode);
        print(response.body);
        if (response.statusCode == 200) {
          stateCityViaPincodeModel jsonResponse = stateCityViaPincodeModelFromJson(response.body);
         // Map<String, dynamic> json =jsonDecode(response.body);
          //final Searchcities = <String>[];
          List<String> Searchcities = [];


          // for (final stateData in jsonDecode(response.body).values.first) {
          //   final state = stateData['India'] as String;
          //   for (final city in stateData['cities'] as List) {
          //     // cities.add('$city,$state');
          //     Searchcities.add('$city');
          //   }
          // }
          // for (var item in json['data']) {
          //
          //   if (item.containsKey('regionName')) {
          //     Searchcities.add(item['regionName']);
          //   }
          // }
          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }











  static Future<StateCountryModel?> getCompanyStatesList(
      String api,
      String country,

      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
        final body=({

          "country":country

        });
        print(body);
 print("company state List");
        final response = await http.post(Uri.parse(api),body: body);
        if (response.statusCode == 200) {
          StateCountryModel jsonResponse = stateCountryModelFromJson(response.body);
          Map<String, dynamic> json = jsonDecode(response.body);
          print(json);
          List<String> country_states = [];
          for (var item in json['data']){
            country_states.add(item);
          }

         print("Company COuntry States");

          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }








  static Future<StateCountryModel?> getCompanyStatesCityList(
      String api,
      String country,
      String state,

      GlobalKey<ScaffoldState> scaffoldKey,
      ) async {
    var connectivityResult =
    await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        // Map<String, String> header = {
        //   HttpHeaders.authorizationHeader: 'token $token',
        //   HttpHeaders.contentTypeHeader: 'application/json'
        // };
        final body=({

          "country":country,
          "state":state

        });
        print(body);
        print("company state city List");
        final response = await http.post(Uri.parse(api),body: body);
        if (response.statusCode == 200) {
          StateCountryModel jsonResponse = stateCountryModelFromJson(response.body);
          Map<String, dynamic> json = jsonDecode(response.body);
          print(json);
          List<String> country_statescity = [];
          for (var item in json['data']){
            country_statescity.add(item);
          }

          print("Company COuntry States cities");

          return jsonResponse;
        } else if (response.statusCode == 401) {
          final errorMessage = jsonDecode(response.body);
          Alert.showSnackbar(errorMessage['errorMessage'], context!);
          return null;
        } else {
          Map<String, dynamic> errorMessage = json.decode(response.body);
          print(errorMessage);
          Alert.showSnackbar(errorMessage['message'], context!);
          return null;
        }
      } on SocketException catch (e) {
        print(e.toString());
        Alert.showSnackbar('Connection timed out!', context!);
        return null;
      } on NoSuchMethodError catch (e) {
        print(e.toString());
        Alert.showSnackbar('Profile does not exist', context!);
        return null;
      } catch (e) {
        // print(e.toString());
        Alert.showSnackbar(e.toString(), context!);
        return null;
      }
    } else {
      Alert.showSnackbar('No Internet!', context!);
      return null;
    }
  }




}
