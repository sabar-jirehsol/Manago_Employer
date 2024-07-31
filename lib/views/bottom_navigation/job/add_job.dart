import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/job/add_job_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../api/api.dart';
import '../../../models/common_location_model.dart';
import '../../../services/StateCityServices.dart';

class AddJob extends StatefulWidget {
  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends StateMVC<AddJob> {
  AddJobController? _con;
  _AddJobState() : super(AddJobController()) {
    _con = controller as AddJobController?;
  }

  List<String> city = [];
  List<String> citesList = [];
  List<String> countryList = [];
  //CommonLocationModel? locationList;
  //bool cityVisible = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode countryFocusNode = FocusNode();
  // getAllStatesCitiesList() async {
  //   //EasyLoading.show(status: 'Please wait...');
  //   FilterDataServices.getAllStateCitiesList(API.getAllStatesAndCities, scaffoldKey).then((value) {
  //     //EasyLoading.dismiss();
  //     if (value != null) {
  //       setState(() {
  //         locationList = value;
  //         for(int j = 0; j < locationList!.value!.length; j++){
  //           countryList.add(locationList!.value![j].country.toString());
  //         }
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    countryFocusNode.addListener(() {
      if (!countryFocusNode.hasFocus) {
        setState(() {
          _con!.searchCountryList.clear();
        });
      }
    });
    super.initState();
    _con!.skills = [];
    //getAllStatesCitiesList();
    //_con!.getCitiesList();
    _con!.getDesignationList();
    _con!.getSkillsList();
    _con!.getExperinceList();
    //_con!.loadStates(context);
    //_con!.loadCountries(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Add Job',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: _con!.skillSetList == null
          ? Container()
          : Container(
             // color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TitleText(
                      text: 'Job Details',
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    TextField(

                      onChanged: (String value) {


                        setState(() {
                          _con!.jobTitleError=false;
                        });
                        _con!.jobTitle = value;
                      },
                      style: TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: 'Job Title ',
                        //labelText: 'Job Title',

                        hintStyle: TextStyle(fontSize: 17),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    // ReusableTextField(
                    //
                    //   hintText: 'Job Title',
                    //   textStyle: TextStyle(fontSize:16,fontWeight: FontWeight.bold ),
                    //   labelStyle: TextStyle(color:Colors.grey,fontSize: 15,),
                    //   keyboardType: TextInputType.visiblePassword,
                    //   onChanged: (value) {
                    //
                    //   },
                    //   labelText: 'Job Title',
                    // ),
                    _con!.jobTitleError?errorText(_con!.jobTitleError_text!):const SizedBox(),
                    SizedBox(
                      height: 20,
                    ),


                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: SearchableDD(
                    //         // hintText: 'exp',
                    //         label: 'Designation',
                    //         hintText: 'Designation',
                    //         hintStyle: TextStyle(fontSize: 14),
                    //         items: _con!.designationList,
                    //         selectedItem:_con!.designation,
                    //         showClearButton: false,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             _con!.designationError=false;
                    //           });
                    //           _con!.designation = value;
                    //
                    //         },
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Expanded(
                    //       child:    SearchableDD(
                    //          hintText: 'Experience',
                    //         label: 'Experience',
                    //         hintStyle: TextStyle(fontSize: 14),
                    //         items: _con!.experienceList,
                    //         selectedItem:_con!.experience,
                    //         showClearButton: false,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             _con!.experienceError=false;
                    //
                    //           });
                    //           _con!.experience = value;
                    //
                    //         },
                    //       ),
                    //
                    //     ),
                    //   ],
                    // ),
                    SearchableDD(
                      // hintText: 'exp',
                      //label: 'Designation',
                      hintText: 'Designation',
                      hintStyle: TextStyle(fontSize: 14),
                      items: _con!.designationList,
                      selectedItem:_con!.designation,
                      showClearButton: false,
                      onChanged: (value) {
                        setState(() {
                          _con!.designationError=false;
                        });
                        _con!.designation = value;

                      },
                    ),
                    _con!.designationError?errorText(_con!.designationError_text!):const SizedBox(),
                    // Row(
                    //   children: [
                    //     Expanded(child: _con!.designationError?errorText(_con!.designationError_text!):const SizedBox()),
                    //     Expanded(child: _con!.experienceError?errorText(_con!.expError_text!):const SizedBox()),
                    //   ],
                    // ),
                SizedBox(
                        height: 20,
                      ),
                     Row(
                       children: [
                         Expanded(child:  SearchableDD(
                                hintText: 'MinExp',
                               //label: 'MinExperience',
                               hintStyle: TextStyle(fontSize: 14),
                               items: _con!.Min_MaxexperienceList,
                           selectedItem: (_con!.minexperience != null ? _con!.minexperience.toString() : ""),
                              // selectedItem:_con!.minexperience.toString(),
                               showClearButton: false,
                               onChanged: (value) {
                                 setState(() {

                                   // if (_con!.minexperience!<_con!.maxexperience!){
                                   //   _con!.maxexperienceError=false;
                                   // }
                                   _con!.maxexperienceError=false;
                                   _con!.minexperienceError=false;

                                 });
                                 _con!.minexperience = int.parse(value!);

                               },
                             ),),
                         SizedBox(
                                 width: 10,
                               ),
                         Expanded(child:  SearchableDD(
                           hintText: 'MaxExp',
                           //label: 'MaxExperience',
                           hintStyle: TextStyle(fontSize: 12),
                           items: _con!.Min_MaxexperienceList,
                           selectedItem: (_con!.maxexperience != null ? _con!.maxexperience.toString() : ""),

                           showClearButton: false,
                           onChanged: (value) {
                             setState(() {

                               // if (_con!.minexperience!<_con!.maxexperience!){
                               //   _con!.minexperienceError=false;
                               //
                               // }
                               _con!.minexperienceError=false;
                               _con!.maxexperienceError=false;

                             });
                             _con!.maxexperience = int.parse(value!);

                           },
                         ),)
                       ],
                     ),
                // Row(
                //
                //     children: [
                //       Expanded(child: _con!.minexperienceError?errorText(_con!.minexpError_text!):const SizedBox()),
                //       Expanded(child: _con!.maxexperienceError?errorText(_con!.maxexpError_text!):const SizedBox()),
                //     ],
                //   ),
                Row(
                  children: [
                    Expanded(
                      child: _con!.minexperienceError
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal:5.0),
                        child: Text(
                          _con!.minexpError_text!,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                          : SizedBox(),
                    ),
                    Expanded(
                      child: _con!.maxexperienceError
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          _con!.maxexpError_text!,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                          : SizedBox(),
                    ),
                  ],
                ),

                    SizedBox(
                      height: 20,
                    ),
                    MultiLevelDropdown<String>(
                     // dropdownKey: _multiKey2,
                      hintText: 'key skills',
                      // label: 'key skills',
                      label: '',
                      items: _con!.skillSetList,
                      filled: false,
                      // Assuming skillSetList is a list of strings
                      onChanged: (selectedItems) {
                       setState(() {  _con!.skillError=false;});
                       _con!.skills=selectedItems;

                        print("_CON!>SKILLS IN ADD JB:");

                        print('${_con!.skills}');
                      },
                    ),
                    // ReusableDropDown(
                    //   hintText: 'Key Skills',
                    //   value: _con!.skill,
                    //   options: _con!.skillSetList,
                    //   onChanged: (value) {
                    //     FocusScope.of(context).requestFocus(FocusNode());
                    //     setState(() {
                    //       _con!.skillError=false;
                    //       _con!.skill = value.toString();
                    //       _con!.skills.clear();
                    //       _con!.skills.add(value.toString());
                    //     });
                    //   },
                    // ),
                    _con!.skillError?errorText(_con!.skillError_text!):const SizedBox(),
                    SizedBox(height: 20),
                    // Container(
                    //   height: 50,
                    //   child: SearchableDD(
                    //     hintText: 'Enter Country',
                    //     label: 'Select Country',
                    //     items: countryList,
                    //     onChanged: (String country) {
                    //       FocusScope.of(context).requestFocus(FocusNode());
                    //       print(country);
                    //       for(int j = 0; j < locationList!.value!.length; j++){
                    //         if(country == locationList!.value![j].country){
                    //           for(int i = 0; i < locationList!.value![j].states!.length; i++){
                    //             citesList = citesList + locationList!.value![j].states![i].cities!;
                    //             cityVisible = true;
                    //             print('citesList == $citesList');
                    //           }
                    //         }
                    //       }
                    //       setState(() {});
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // Visibility(
                    //   visible: cityVisible,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         height: 50,
                    //         child: SearchableDD(
                    //           hintText: 'Enter City',
                    //           label: 'Select City',
                    //           items: citesList,
                    //           onChanged: (String value) {
                    //             FocusScope.of(context).requestFocus(FocusNode());
                    //             setState(() {
                    //               if (value != null) {
                    //                 if(city.isNotEmpty){
                    //                   for(var i = 0; i < city.length; i++) {
                    //                     if (city.contains(value)) {
                    //
                    //                     }else{
                    //                       city.add(value);
                    //                     }
                    //                   }
                    //                 }
                    //                 else{
                    //                   city.add(value);
                    //                 }
                    //               }
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //       city.isEmpty
                    //           ? Container()
                    //           : Container(
                    //         margin: EdgeInsets.only(top: 10),
                    //         child: Wrap(
                    //           runSpacing: 6,
                    //           spacing: 6,
                    //           children: List<Widget>.generate(city.length, (index) {
                    //             return Chip(
                    //               padding: EdgeInsets.all(4),
                    //               deleteIconColor: Colors.white,
                    //               backgroundColor: kPrimaryColor,
                    //               label: Text(
                    //                 city[index],
                    //                 style: TextStyle(color: Colors.white, fontSize: 10),
                    //               ),
                    //               onDeleted: () {
                    //                 setState(() {
                    //                   city.removeAt(index);
                    //                 });
                    //               },
                    //             );
                    //           }),
                    //         ),
                    //       ),
                    //       SizedBox(height: 20),
                    //     ],
                    //   ),
                    // ),


                    // SearchableDD(
                    //   hintText: 'Country',
                    //   //label: 'Country',
                    //   items: _con!.countries,
                    //   selectedItem: _con!.jobCountry,
                    //   showClearButton: false,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _con!.jobCountryError=false;
                    //       _con!.jobCountry = value;
                    //     });
                    //
                    //     _con!.jobcity = null;
                    //     _con!.loadjobStates(_con!.jobCountry!);
                    //     print("_CON!>SKILLS IN ADD JB:");
                    //
                    //     print('${_con!.skills}');
                    //   },
                    // ),
                    TextFormField(
                      focusNode: countryFocusNode,
                      controller: _con!.addjobCountryController,
                      // initialValue: _con!.profilecountry,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        print("values is ${value}");
                        if(value.isNotEmpty && value.length>2){
                          _con!.getSearchCountryList(value);
                        }

                        setState(() {
                          _con!.jobCountryError=false;
                          _con!.jobCountry = value;
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
                    _con!.jobCountryError?errorText(_con!.jobCountryError_text!):const SizedBox(),
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
                                  _con!.addjobCountryController.text=_con!.searchCountryList[index];
                                  _con!.jobCountry = _con!.searchCountryList[index];
                                  _con!.loadjobStates(_con!.jobCountry!);
                                  _con!.jobCountryError=false;// Hide country list on selection
                                  _con!.searchCountryList.clear(); // Clear the list after selection
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SearchableDD(
                            hintText: 'Search State',
                            //label: 'State',
                            hintStyle: TextStyle(fontSize: 14),
                            items: _con!.newStates,
                            selectedItem: _con!.jobState,
                            showClearButton: false,
                            onChanged: (value) {
                              _con!.jobState = value;
                              _con!.jobcity = null;
                              _con!.loadjobStateCities(_con!.jobCountry!,_con!.jobState!);
                             // _con!.loadCities(_con!.jobState!);
                              setState(() { _con!. jobStateError=false; });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SearchableDD(
                            hintText: 'Search City',
                           // label: 'City',
                            hintStyle: TextStyle(fontSize: 14),
                            items: _con!.cities,
                            showClearButton: false,
                            selectedItem: _con!.jobcity,
                            onChanged: (value) {

                              setState(() {_con!.jobcityError=false; });
                              _con!.jobcity = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child:_con!. jobStateError?errorText(_con!.jobstateError_text!):const SizedBox(), ),
                        Expanded(child:  _con!.jobcityError?errorText(_con!.jobcityError_text!):const SizedBox(),),
                      ],
                    ),


                    SizedBox(height: 20,),




                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(9),
                      ],
                      onChanged: (String value) {

                        setState(() {
                          _con!.salaryError=false;
                        });
                        _con!.salary = value;
                      },
                      style: TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: 'Salary',
                        //labelText: 'Salary',

                        hintStyle: TextStyle(fontSize: 17),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),_con!.salaryError?errorText(_con!.salaryError_text!):const SizedBox(),

                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      onChanged: (String value) {

                        setState(() { _con!.vaccancyOpeningError=false;});
                        _con!.vaccancyOpening = value;
                      },
                      style: TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: 'Vaccancy Openings',
                        //labelText: 'Vaccancy Openings',
                        hintStyle: TextStyle(fontSize: 17),

                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),_con!.vaccancyOpeningError?errorText(_con!.vaccancyOpeningError_text!):const SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      maxLines: 5,
                      onChanged: (String value) {

                        setState(() {
                          _con!.descriptionError=false;
                        });
                        _con!.description = value;
                      },
                      style: TextStyle(fontSize: 17),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: 'Description ',
                        labelText: 'Description',

                        hintStyle: TextStyle(fontSize: 17),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),_con!.descriptionError?errorText(_con!.descError_text!):const SizedBox(),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ReusableButton(
                        title: 'Post',
                        onPressed: () {
                          setState(() {


                          });
                          _con!.addJob(context);
                        },
                      ),
                    ),
                    SizedBox(height: 30)
                  ],
                ),
              ),
            ),
    );
  }


  Widget errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(' $text', style: TextStyle(color: Colors.red,fontSize: 12)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }



}
