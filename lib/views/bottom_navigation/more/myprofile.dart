import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_readonly_textfield.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/more/my_profile_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../api/utils.dart';

class MyProfile extends StatefulWidget {
  static const String id = 'profile_completion_screen_id';
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends StateMVC<MyProfile> {

  MyProfileController? _con;
  _MyProfileState() : super(MyProfileController()) {
    _con = controller as MyProfileController?;
  }

  final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

  //Timer? _timer;
  // TextEditingController searchCountryController = TextEditingController();

  FocusNode countryFocusNode = FocusNode();

  @override
  void initState() {

    // _timer=Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   apiRefresh();
    // });
    //_con!.loadStates(context);
    _con!.getEmployeeDetail();
    //_con!.loadCountries(context);

    countryFocusNode.addListener(() {
      if (!countryFocusNode.hasFocus) {
        setState(() {
          _con!.searchCountryList.clear();
        });
      }
    });
    super.initState();



  }
  // Future <void>  apiRefresh() async {
  //
  //   // Cancel the previous timer to avoid multiple API calls
  //   _timer?.cancel();
  //   await _con!.loadCountries(context);
  //
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.white,
        key: _con!.scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor.withOpacity(0.2),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: kPrimaryColor,
                  )),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Personal Profile',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: _con!.employeeData == null
              ? Container()
              : SingleChildScrollView(

                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Center(
                      //   child: Stack(
                      //     alignment: Alignment.bottomRight,
                      //     children: [
                      //       CircleAvatar(
                      //         radius: 70,
                      //         backgroundImage:NetworkImage(_con!.profilepics.toString()),
                      //         // backgroundImage:_con!.profilepics == null
                      //         //    ? AssetImage('assets/images/logo.png') as ImageProvider
                      //         //     :Image.network("ff"),
                      //       ),
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             shape: BoxShape.circle, color: kBlueGrey),
                      //         child: IconButton(
                      //             padding: EdgeInsets.zero,
                      //             icon: Icon(Icons.camera_alt,
                      //                 size: 20, color: Colors.white,
                      //
                      //             ),
                      //             onPressed: () {
                      //
                      //               showModalBottomSheet(
                      //                 context: context,
                      //                 builder: (context) {
                      //                   return Container(
                      //                     height: 100,
                      //                     width: MediaQuery.of(context).size.width,
                      //                     margin:
                      //                     EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      //                     child: Column(
                      //                       children: [
                      //                         Text(
                      //                           'Choose a Profile Photo',
                      //                           style: TextStyle(fontSize: 20),
                      //                         ),
                      //                         SizedBox(
                      //                           height: 20,
                      //                         ),
                      //                         Row(
                      //                           mainAxisAlignment: MainAxisAlignment.center,
                      //                           children: [
                      //                             ElevatedButton.icon(
                      //                                 onPressed: () {
                      //                                   _con!.takePhoto(ImageSource.camera);
                      //                                 },
                      //                                 icon: Icon(Icons.camera),
                      //                                 label: Text('Camera')),
                      //                             ElevatedButton.icon(
                      //                                 onPressed: () {
                      //                                   _con!.takePhoto(ImageSource.gallery);
                      //                                 },
                      //                                 icon: Icon(Icons.image),
                      //                                 label: Text('Gallery'))
                      //                           ],
                      //                         )
                      //                       ],
                      //                     ),
                      //                   );
                      //                 },
                      //               );
                      //
                      //
                      //
                      //
                      //
                      //
                      //
                      //
                      //
                      //             }
                      //
                      //
                      //         ),
                      //   ),
                      //     ],),
                      // ),
                      SizedBox(height: 30),
                      ReusableReadonlyTextField(
                        keyboardType: TextInputType.visiblePassword,

                        hintText: 'Name',
                        labelText: 'Name',
                        initialValue: _con!.employeeData!.name,
                        onChanged: (value) {
                          setState(() {
                            _con!.nameError = false;
                          });
                          _con!.name = value;
                        }

                      ),_con!.nameError ? errorText('Name should not be empty'): const SizedBox(),

                      SizedBox(height: 30),
                      ReusableReadonlyTextField(
                        hintText: 'Email',
                        labelText: 'Email',
                        initialValue: _con!.employeeData!.email,
                          keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          setState(() {
                            _con!.personalemailError=false;
                          });
                          _con!.email = value;
                        }
                      ),_con!.personalemailError? errorText('Email should not be empty and Invalid'): const SizedBox(),
                      SizedBox(height: 30),
                      Row(children: [
                        Expanded(
                          flex: 1,
                          child: ReusableReadonlyTextField(
                              readOnly: true,
                              hintText: 'Dialcode',
                              labelText: 'Dialcode',
                              keyboardType: TextInputType.phone,
                              initialValue:"${_con!.employeeData!.dialcode} ",
                              // linum:_con!.profilecountry!="India"?13:10,
                              onChanged: (value) {


                              }
                          ),
                        ),
                         SizedBox(width: 6,),
                         Expanded(
                           flex: 3,
                           child: ReusableReadonlyTextField(
                              hintText: 'Phone Number',
                              labelText: 'Phone Number',
                              keyboardType: TextInputType.phone,
                              initialValue:_con!.employeeData!.mobile,
                              linum:_con!.employeeData!.dialcode!="+91"?13:10,
                              onChanged: (value) {

                                print("country name is in profile section");
                                print('${_con!.profilecountry} and ${_con!.employeeData!.dialcode} ');
                                setState(() {
                                  _con!.mobileError=false;
                                });

                                _con!.mobile = value;
                              }
                                                   ),
                         ),
                      ],),


                      _con!.mobileError? errorText(_con!.profile_mob_error_text!): const SizedBox(),
                      SizedBox(height: 30),
                      TextFormField(
                        initialValue: _con!.employeeData!.address,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          setState(() {
                           _con!.personaladdressError=false;
                          });
                          _con!.address = value;
                        },
                        maxLines: 3,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: _con!.address,
                          labelText: 'Address',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),  _con!.personaladdressError? errorText('Address should not be empty.'): const SizedBox(),
                      SizedBox(height: 30),
                      ReusableReadonlyTextField(
                          hintText: 'Pincode',
                          labelText: 'Pincode',
                          pattern: alphanumeric,
                          linum: 7,
                          initialValue: _con!.employeeData!.pincode,
                         // keyboardType: TextInputType.visiblePassword,
                          onChanged: (value) {
                            setState(() {
                              _con!.pincodeError = false;
                            });
                            // _con!.loadStateandCitiesViaPincode(value, context);
                            // if (value.length == 6) {
                            //   // Perform further validation if needed
                            //   _con!.loadStateandCitiesViaPincode(value, context);
                            // }
                            _con!.pincode = value;
                          }

                      ),_con!.pincodeError ? errorText(_con!.pincodeError_text!): const SizedBox(),
                      SizedBox(height: 30,),

                      TextFormField(
                       focusNode:countryFocusNode,
                        controller: _con!.searchCountryController,
                       // initialValue: _con!.profilecountry,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          print("values is ${value}");
                          if(value.isNotEmpty && value.length>2){
                            _con!.getSearchCountryList(value);
                          }

                          setState(() {

                            _con!.personalcountryError = false;
                            _con!.profilecountry = value;
                          });
                        },
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'country',
                          labelText: 'country',
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),

                      _con!.personalcountryError ? errorText("Country is required.") : const SizedBox(),

                      Visibility(
                        visible: _con!.searchCountryList.isNotEmpty,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: _con!.searchCountryList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10), // Remove padding
                                title: Container(
                                    padding: EdgeInsets.zero,
                                    child: Text(_con!.searchCountryList[index])),
                                dense: true, // Reduce the height of ListTile
                                visualDensity: VisualDensity.compact,
                                onTap: () {
                                  setState(() {
                                   _con!.searchCountryController.text=_con!.searchCountryList[index];
                                    _con!.profilecountry = _con!.searchCountryList[index];
                                    _con!.loadCompanyStates(_con!.profilecountry!);
                                    _con!.personalcountryError = false; // Hide country list on selection
                                    _con!.searchCountryList.clear(); // Clear the list after selection
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),



                      // Autocomplete<String>(
                      //   initialValue: TextEditingValue(text: _con!.profilecountry??'Country'),
                      //   optionsBuilder: (TextEditingValue textEditingValue) async{
                      //     final filteredList =await  _con!.countries.where((String option) {
                      //
                      //       return option.toLowerCase().contains(
                      //         textEditingValue.text.toLowerCase(),
                      //       );
                      //     }).toList();
                      //
                      //     if (filteredList.isEmpty) {
                      //
                      //       return [
                      //         'No items matchs'
                      //       ]; // Return a list containing the message
                      //     } else {
                      //       return filteredList;
                      //     }
                      //   },
                      //   onSelected: (String selectedCity) {
                      //     setState(() {
                      //       _con!.profilecountry  = selectedCity;
                      //       _con!.loadCompanyStates(_con!.profilecountry!);
                      //       // Update the selected city
                      //       //searchController.text = selectedCity; // Update the text in searchController
                      //     });
                      //   },
                      //   fieldViewBuilder: (BuildContext context,
                      //       TextEditingController fieldController,
                      //       FocusNode focusNode,
                      //
                      //       VoidCallback onFieldSubmitted) {
                      //     searchCountryController = fieldController;
                      //     return TextFormField(
                      //       controller: searchCountryController,
                      //
                      //       // Use the searchController for both TextFormField and Autocomplete
                      //       focusNode: focusNode,
                      //       keyboardType: TextInputType.visiblePassword,
                      //       inputFormatters: [
                      //         FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                      //       ],
                      //       onChanged: (String value) async{
                      //         await _con!.getSearchCountryList(value);
                      //         setState(()  {
                      //
                      //
                      //             _con!.profilecountry = value;
                      //             //_con!.loadCompanyStates(_con!.profilecountry!);
                      //             setState(() {
                      //               _con!.personalcountryError=false;
                      //             });
                      //
                      //           print("value is " + value);
                      //         });
                      //       },
                      //       decoration: InputDecoration(
                      //         contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      //         labelText:'Country' ,
                      //         hintText: 'Country',
                      //         hintStyle: TextStyle(color: Colors.black,),
                      //         enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(color: kGreyColor),
                      //             borderRadius: BorderRadius.circular(10)),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(color: kGreyColor),
                      //             borderRadius: BorderRadius.circular(10)),
                      //
                      //
                      //       ),
                      //     );
                      //   },
                      //   optionsViewBuilder: (context, onSelected, options) => Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Material(
                      //       //elevation: 4,
                      //       // color: Colors.orange,
                      //       shadowColor: kGreyColor,
                      //       child: SizedBox(
                      //         height: 100,
                      //         width: 328,
                      //         child: Visibility(
                      //           visible: _con!.searchCountryList.isNotEmpty,
                      //           child: ListView(
                      //             children: options
                      //                 .map((e) => ListTile(
                      //
                      //               //onTap: () => onSelected(e),
                      //               onTap: e=='No items match' ? null : () => onSelected(e),
                      //               title: Text(e),
                      //             ))
                      //                 .toList(),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // SearchableDD(
                      //   hintText: 'Country',
                      //   label: 'Country',
                      //   items: _con!.countries,
                      //   selectedItem: _con!.profilecountry,
                      //   showClearButton: false,
                      //   onChanged: (value) {
                      //     _con!.profilecountry = value;
                      //     _con!.city = null;
                      //     setState(() {
                      //       _con!.personalcountryError=false;});
                      //     _con!.loadCompanyStates(_con!.profilecountry!);
                      //   },
                      // ),
                      SizedBox(height: 10,),





                      _con!.personalcountryError?errorText("Country is required."):const SizedBox(),

                      SizedBox(height: 30,),

                      Row(
                        children: [
                          Expanded(
                            child: SearchableDD(
                              hintText: 'Search State',
                              label: 'State',
                              items: _con!.newStates,
                              selectedItem: _con!.newState,
                              showClearButton: false,
                              onChanged: (value) {

                                _con!.newState = value;
                                _con!.city = null;
                                setState(() {
                                  _con!.personalstatError=false;
                                });
                                _con!.loadcompanyStateCities(_con!.profilecountry!,_con!.newState!);
                                //_con!.loadCities(_con!.companyState!);
                              },
                            ),
                          ),
                          // child:  MultiLevelDropdown<String>(
                          //     // dropdownKey: _multiKey2,
                          //     hintText: 'keyskills',
                          //     label: '',
                          //     items: _con!.newStates,
                          //     filled: false,
                          //     // Assuming skillSetList is a list of strings
                          //     onChanged: (selectedItems) {
                          //       _con!.newState = selectedItems[0];
                          //             _con!.city = null;
                          //             setState(() {
                          //               _con!.personalstatError=false;
                          //             });
                          //             _con!.loadcompanyStateCities(_con!.profilecountry!,_con!.newState!);
                          //     },
                          //   ),),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SearchableDD(
                              hintText: 'Search City',
                              label: 'City',
                              items: _con!.cities,
                              showClearButton: false,
                              selectedItem: _con!.city,
                              onChanged: (value) {
                                setState(() { _con!.
                                personalcityError=false;});
                                _con!.city = value;
                              },
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 30),
                      TextFormField(
                        initialValue: _con!.employeeData!.about,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          setState(() {
                            _con!.aboutyourselfError=false;
                          });
                          _con!.aboutYourself = value;
                        },
                        maxLines: 3,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'About Yourself',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      _con!.aboutyourselfError? errorText('About yourself is not empty.'): const SizedBox(),
                      SizedBox(height: 30),
                      Center(
                        child: Container(
                          width: 140,
                          child: ReusableButton(
                            title: 'Update',
                            onPressed: () {
                              setState(() {

                              });
                              print("profile update button click");
                              _con!.UpdatePersonalProfile(context);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
        ),
      ),
    );
  }


  Widget errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('$text', style: TextStyle(color: Colors.red)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
