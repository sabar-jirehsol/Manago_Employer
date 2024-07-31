import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_readonly_textfield.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/more/my_profile_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class CompanyProfile extends StatefulWidget {
  static const String id = 'profile_completion_screen_id';
  @override
  _CompanyProfileState createState() => _CompanyProfileState();
}

class _CompanyProfileState extends StateMVC<CompanyProfile> {
  MyProfileController? _con;
  _CompanyProfileState() : super(MyProfileController()) {
    _con = controller as MyProfileController?;
  }
  DateFormat formatter = DateFormat('dd/MM/yyyy');


  FocusNode countryFocusNode = FocusNode();


  //Timer? _timer;


  @override
  void initState() {
    // _timer=Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //  // apiRefresh();
    // });
    //_con!.loadStates(context);
    _con!.loadFirmSize(context);
    _con!.loadFirmType(context);
    _con!.getCompanyDetail();
   // _con!.loadCountries(context);
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
  Future<bool> checkIfUrlIsValid({required String url}) async {
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        // URL is valid and accessible
        return true;
      } else {
        // URL is not accessible (e.g., 404 Not Found)
        _con!.websiteError = true;
        _con!.websiteErrorText =
        "Invalid URL. Please enter a valid Website, and ensure the website URL must start with http://or htps://";
        return false;
      }
    } catch (e) {
      // Error occurred while accessing the URL
      _con!.websiteError = true;
      _con!.websiteErrorText =
      "Error: Failed to access the Website,try again with right website ";
      // "Error: Failed to access the URL. and ensure the website URL must start with  http:// ";
      return false;
    }
  }

  // Future<bool> checkIfUrlIsValid({required String url}) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     return true;
  //   }
  //   _con!.websiteError=true;
  //    _con!.websiteErrorText="Invalid Url Please Enter valid Url";
  //   return false;
  // }
  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: _con!.scaffoldKey,
        body: GestureDetector(
          onTap: () =>FocusScope.of(context).requestFocus(FocusNode()),
          child: _con!.companyData == null
              ? Container()
              : PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
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
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Company Profile',
                                style: TextStyle(
                                    color: kPrimaryColor, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          ReusableTextField(
                            hintText: 'Company\'s Name',
                            labelText: 'Company\'s Name',
                            initialValue: _con!.companyData!.businessName,
                              keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              setState(() {
                                _con!.companynameError=false;// Reset the error state

                              });


                              _con!.businessName = value;


                            }


                          ),_con!.companynameError? errorText('Name should not be empty'): const SizedBox(),


                          SizedBox(height: 30),
                          ReusableReadonlyTextField(
                            labelText: 'Company\'s Website',
                            hintText: 'Company\'s Website',
                            initialValue: _con!.companyData!.businessWebsite,
                              keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                                          setState(() {

                                            _con!.websiteError=false;// Reset the error state\
                                            _con!.companyWebsite = value;
                                                });
                                          print("CHECKING VALID URL OR NOT");
                                          checkIfUrlIsValid(url:_con!.companyWebsite!);


                            }
                          ),_con!.websiteError? errorText(_con!.websiteErrorText!): const SizedBox(),
                          SizedBox(height: 30),
                          ReusableReadonlyTextField(
                            hintText: 'Email Address',
                            labelText: 'Email Address',
                            initialValue: _con!.companyData!.email,
                              keyboardType: TextInputType.visiblePassword,
                            onChanged: (value){
                                setState(() {
                                  _con!.emailError=false;
                                });
                              _con!.companyEmail = value;
                            }
                          ),
                          _con!.emailError? errorText("Email is  should not be Empty and  invalid"):const SizedBox(),
                          SizedBox(height: 30),

                      //Todo  not yet add any  functionalities related  country
                      //     SearchableDD(
                      //   hintText: 'Country',
                      //   label: 'Country',
                      //   items: _con!.countries,
                      //   selectedItem: _con!.companyCountry,
                      //   showClearButton: false,
                      //   onChanged: (value) {
                      //     _con!.companyCountry = value;
                      //     _con!.city = null;
                      //     setState(() {  _con!.countryError=false;});
                      //     _con!.loadCompanyStates(_con!.companyCountry!);
                      //   },
                      // ),
                          TextFormField(
                            focusNode: countryFocusNode,
                            controller: _con!.searchcompanyCountryController,
                            // initialValue: _con!.profilecountry,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              print("values is ${value}");
                              if(value.isNotEmpty && value.length>2){
                                _con!.getSearchCountryList(value);
                              }

                              setState(() {
                                _con!.countryError=false;
                                _con!.companyCountry = value;
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
                          _con!.countryError?errorText("Country is required."):const SizedBox(),
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
                                        _con!.searchcompanyCountryController.text=_con!.searchCountryList[index];
                                        _con!.companyCountry = _con!.searchCountryList[index];
                                        _con!.loadCompanyStates(_con!.companyCountry!);
                                        _con!.personalcountryError = false; // Hide country list on selection
                                        _con!.searchCountryList.clear(); // Clear the list after selection
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                    SizedBox(height: 30,),

                          Row(
                            children: [
                              Expanded(
                                child: SearchableDD(
                                  hintText: 'Search State',
                                  label: 'State',
                                  items: _con!.newStates,
                                  selectedItem: _con!.companyState,
                                  showClearButton: false,
                                  onChanged: (value) {
                                    _con!.companyState = value;
                                    _con!.city = null;
                                    setState(() {
                                     _con!.stateError=false;
                                    });
                                    _con!.loadcompanyStateCities(_con!.companyCountry!,_con!.companyState!);
                                    //_con!.loadCities(_con!.companyState!);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SearchableDD(
                                  hintText: 'Search City',
                                  label: 'City',
                                  items: _con!.cities,
                                  showClearButton: false,
                                  selectedItem: _con!.companyCity,
                                  onChanged: (value) {
                                    setState(() { _con!.cityError=false;});
                                    _con!.companyCity = value;
                                  },
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child:_con!. stateError?errorText('State is Required.'):const SizedBox(), ),
                              Expanded(child:  _con!.cityError?errorText('City is Required.'):const SizedBox(),),
                            ],
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            initialValue: _con!.companyData!.businessAddress,
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (value) {
                              setState(() {
                                _con!.addressError=false;
                              });
                              _con!.companyAddress = value;
                            } ,
                            maxLines: 3,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              hintText: _con!.companyAddress,
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
                          ),_con!.addressError?errorText("Address should not be empty."):const SizedBox(),
                          SizedBox(height: 30),

                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child:TextFormField(
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text: _con!.companyFoundedDate != null
                                          ? formatter.format(DateTime.parse(_con!.companyFoundedDate!))
                                          : '',
                                    ),
                                    onTap: () async {
                                      DateTime? selectedDate = await DatePickerClass.selectDate(context);
                                      if (selectedDate != null) {
                                        print("SELECTED DATE: $selectedDate");
                                        setState(() {
                                          _con!.companyFoundedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                                        });
                                      }
                                    },
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      labelText: 'Foundation Date',
                                      hintText: 'Foundation Date',
                                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kGreyColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: kGreyColor),
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          DateTime? selectedDate = await DatePickerClass.selectDate(context);
                                          if (selectedDate != null) {
                                            print("SELECTED DATE: $selectedDate");
                                            setState(() {
                                              _con!.companyFoundedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.calendar_today), // Calendar icon
                                      ),
                                    ),
                                  ),








                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: SearchableDD(
                                    hintText: 'Company Size',
                                    label: 'Company Size',
                                    items: _con!.firmSize,
                                    selectedItem: _con!.selectedFirmSize,
                                    showClearButton: false,
                                    onChanged: (value) {
                                      _con!.selectedFirmSize = value;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            height: 50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SearchableDD(
                                    hintText: 'Category',
                                    label: 'Category',
                                    items: _con!.firmTypes,
                                    selectedItem: _con!.firmType,
                                    showClearButton: false,
                                    onChanged: (value) {
                                      _con!.firmType = value;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: _con!.companyData!.gstnNo,
                                    textCapitalization: TextCapitalization.characters,
                                    keyboardType: TextInputType.text,

                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Z]')),
                                      LengthLimitingTextInputFormatter(15),
                                    ],
                                    //onChanged: (value) => _con!.gstIn = value,
                                    onChanged:(value){
                                      setState(() {
                                        _con!.gstError=false;
                                         });
                                      _con!.gstIn = value;
                                                },
                                    //maxLines: 3,
                                    style: TextStyle(fontSize: 15),
                                    decoration: InputDecoration(
                                      hintText: _con!.gstIn,
                                      labelText: 'GSTIN(Optional)',
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kGreyColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: kGreyColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),//_con!.gstError?errorText("GST should not be Empty and Invalid."):const SizedBox(),
                          SizedBox(height: 30),
                          TextFormField(
                            initialValue:_con!.companyData!.description ,
                            keyboardType: TextInputType.visiblePassword,
                             // onChanged: (value) =>
                             //    _con!.companyDescription = value,
                            onChanged:(value){
                              setState(() {
                                _con!.descriptionError=false;
                              });
                              _con!.companyDescription = value;
                            },
                            maxLines: 5,
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              hintText: _con!.companyDescription,
                              labelText: 'Description',
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: kGreyColor),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),_con!.descriptionError ? errorText("Description is not empty."):const SizedBox(),
                          SizedBox(height: 30),
                          Center(
                            child: Container(
                              width: 175,
                              child: ReusableButton(
                                // title: 'Continue',
                                // onPressed: () {
                                //   pageController.animateToPage(++pageIndex,
                                //       duration: Duration(milliseconds: 400),
                                //       curve: Curves.linearToEaseOut);
                                // },
                                title: 'Continue',
                                onPressed: () {


                                  setState(() {


                                  });
                                  _con!.updateCompanyProfile(context);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),

                  ],
                ),
        ),
      ),
    );
  }


  Widget errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
