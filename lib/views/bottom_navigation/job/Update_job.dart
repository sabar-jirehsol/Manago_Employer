import 'dart:async';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/controllers/job/update_job_controller.dart';
import 'package:manago_employer/models/JobDetailsModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../components/searchable_dropDown.dart';

class UpdateJob extends StatefulWidget {
  final JobDetailsModel? jobdetails;

  const UpdateJob({Key? key, this.jobdetails}) : super(key: key);
  @override
  _UpdateJobState createState() => _UpdateJobState();
}

class _UpdateJobState extends StateMVC<UpdateJob> {
  UpdateJobController? _con;
  _UpdateJobState() : super(UpdateJobController()) {
    _con = controller as UpdateJobController?;
  }

  Timer? _timer;
  FocusNode countryFocusNode = FocusNode();


  @override
  void initState() {
    // _timer=Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   apiRefresh();
    // });
    countryFocusNode.addListener(() {
      if (!countryFocusNode.hasFocus) {
        setState(() {
          _con!.searchCountryList.clear();
        });
      }
    });
    super.initState();
    _con!.skills = [];
    _con!.getJobDetails(widget.jobdetails!.data!.id!);
    _con!.getDesignationList();
    _con!.getSkillsList();
    _con!.getExperinceList();
    //_con!.loadStates(context);
    //_con!.loadCountries(context);
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
    return Scaffold(
      key: _con!.scaffoldKey,
      backgroundColor: Colors.white,
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
          'Update Job',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
       body:_con!.jobDetails == null ||_con!.skills == null
          ? Container()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ReusableTextField(
                      hintText: 'Job Title',
                      initialValue: _con!.jobTitle,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String value) {
                        _con!.jobTitle = value;
                        setState(() { _con!.jobTitleError=false; });

                      },
                      labelText: 'Job Title',
                    ),
                    _con!.jobTitleError?errorText("Job Title should not be Empty"):const SizedBox(),

                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: ReusableDropDown(
                    //         hintText: 'Designation',
                    //         value: _con!.designation,
                    //         onChanged: (value) {
                    //           FocusScope.of(context).requestFocus(FocusNode());
                    //
                    //           setState(() {
                    //             _con!.designationError=false;
                    //           });
                    //           _con!.designation = value;
                    //         },
                    //         options: _con!.designationList,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 20,
                    //     ),
                    //     Expanded(
                    //       child: ReusableDropDown(
                    //         hintText: 'Experience',
                    //         value: _con!.experience,
                    //         onChanged: (value) {
                    //           FocusScope.of(context).requestFocus(FocusNode());
                    //
                    //           setState(() {
                    //             _con!.expError=false;
                    //
                    //           });
                    //           _con!.experience = value;
                    //         },
                    //         options: _con!.experienceList,
                    //       ),
                    //
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: SearchableDD(
                    //         // hintText: 'exp',
                    //         label: 'Designation',
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
                    //         // hintText: 'exp',
                    //         label: 'Experience',
                    //         items: _con!.experienceList,
                    //         selectedItem:_con!.experience,
                    //         showClearButton: false,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             _con!.expError=false;
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
                  label: 'Designation',
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(child:  SearchableDD(
                          hintText: 'MinExp',
                          label: 'MinExperience',
                          hintStyle: TextStyle(fontSize: 14),
                          items: _con!.Min_MaxexperienceList,
                          selectedItem:_con!.minexperience.toString(),
                          showClearButton: false,
                          onChanged: (value) {
                            setState(() {
                              _con!.maxexpError=false;
                              _con!.minexpError=false;

                            });
                            _con!.minexperience = int.parse(value!);

                          },
                        ),),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child:  SearchableDD(
                          hintText: 'MaxExp',
                          label: 'MaxExperience',
                          hintStyle: TextStyle(fontSize: 12),
                          items: _con!.Min_MaxexperienceList,
                          selectedItem:_con!.maxexperience.toString(),
                          showClearButton: false,
                          onChanged: (value) {
                            setState(() {
                              _con!.maxexpError=false;
                              _con!.minexpError=false;

                            });
                            _con!.maxexperience = int.parse(value!);

                          },
                        ),)
                      ],
                    ),
                    Row(
                      children: [

                        Expanded(child: _con!.minexpError?errorText("MinExperience must be less than MaxExperience"):const SizedBox()),
                        Expanded(child: _con!.maxexpError?errorText("MaxExperience must be more than MinExperience"):const SizedBox()),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    MultiLevelDropdown<String>(
                      //dropdownKey: _multiKey1.currentState?.getSelectedItems(_con!.skills),
                      selectedItem: _con!.skills,
                      hintText: '',
                      label: '',
                      items: _con!.keySkills,
                      filled: false,
                      // Assuming skillSetList is a list of strings
                      onChanged: (selectedItems) {
                        setState(() {  _con!.skillError=false;});

                        _con!.skills=selectedItems;
                           setState(() {
                         _con!.skillError=false;
                          });
                        print("_CON!>SKILLS IN UPDATE JB:");

                        print('${_con!.skills}');
                      },
                    ), _con!.skillError?errorText("Skills Should not be Empty"):const SizedBox(),
                    // ReusableDropDown(
                    //   hintText: 'Key Skills',
                    //   value: _con!.skills[0],
                    //   options: _con!.keySkills,
                    //   onChanged: (value) {
                    //     FocusScope.of(context).requestFocus(FocusNode());
                    //
                    //     if (value != null) {
                    //       _con!.skills.clear();
                    //       _con!.skills.add(value.toString());
                    //     }
                    //     setState(() {
                    //       _con!.skillError=false;
                    //     });
                    //   },
                    // ),  _con!.skillError?errorText("Skills Should not be Empty"):const SizedBox(),


                    SizedBox(
                      height: 20,
                    ),
                    // //TODO: key skils(chips(tags) , autocomplete)
                    // AutoCompleteTextField(
                    //   key: null,
                    //   textChanged: (value) {
                    //     if (value.contains(',')) {
                    //       value = value.split(',').first;
                    //       _con!.textController.clear();

                    //       setState(() {
                    //         _con!.skills.add(value);
                    //       });
                    //       value = null;
                    //     }
                    //   },
                    //   controller: _con!.textController,
                    //   style: TextStyle(fontSize: 14, color: Colors.black),
                    //   decoration: InputDecoration(
                    //       hintStyle: TextStyle(fontSize: 14),
                    //       labelStyle: TextStyle(fontSize: 14),
                    //       contentPadding: EdgeInsets.symmetric(
                    //           horizontal: 15, vertical: 14),
                    //       hintText: ' Type like flutter,',
                    //       labelText: 'Key Skills',
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(10)),
                    //           borderSide: BorderSide(color: kPrimaryColor)),
                    //       focusedBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(color: kPrimaryColor),
                    //           borderRadius: BorderRadius.circular(10))),
                    //   itemSubmitted: (item) {
                    //     setState(() {
                    //       _con!.skills.add(item);
                    //     });
                    //   },
                    //   suggestions: _con!.keySkills,
                    //   itemBuilder: (context, item) {
                    //     return Container(
                    //       padding: EdgeInsets.all(10),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             item,
                    //             style: TextStyle(fontSize: 14),
                    //           ),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   itemSorter: (a, b) {
                    //     return a.compareTo(b);
                    //   },
                    //   itemFilter: (item, query) {
                    //     return item
                    //         // .toString()
                    //         .toLowerCase()
                    //         .startsWith(query.toLowerCase());
                    //   },
                    // ),

                    // SearchableDD(
                    //   hintText: 'Country',
                    //   label: 'Country',
                    //   items: _con!.countries,
                    //   selectedItem: _con!.jobCountry,
                    //   showClearButton: false,
                    //   onChanged: (value) {
                    //     _con!.jobCountry = value;
                    //     _con!.jobcity = null;
                    //     _con!.loadjobStates(_con!.jobCountry!);
                    //   },
                    // ),
                    TextFormField(
                      controller: _con!.updatejobCountryController,
                      focusNode: countryFocusNode,
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
                    _con!.jobCountryError?errorText("Country is required."):const SizedBox(),
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
                                  _con!.updatejobCountryController.text=_con!.searchCountryList[index];
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
                            label: 'State',
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
                            label: 'City',
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
                        Expanded(child:_con!. jobStateError?errorText("State is required."):const SizedBox(), ),
                        Expanded(child:  _con!.jobcityError?errorText("City is Required."):const SizedBox(),),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // _con!.skills.isEmpty
                    //     ? Container()
                    //     : Container(
                    //         child: Wrap(
                    //           runSpacing: 6,
                    //           spacing: 6,
                    //           children: List<Widget>.generate(
                    //               _con!.skills.length, (index) {
                    //             return Chip(
                    //               padding: EdgeInsets.all(8),
                    //               deleteIconColor: Colors.white,
                    //               backgroundColor: kPrimaryColor,
                    //               label: Text(
                    //                 _con!.skills[index],
                    //                 style: TextStyle(
                    //                     color: Colors.white, fontSize: 16),
                    //               ),
                    //               onDeleted: () {
                    //                 setState(() {
                    //                   _con!.skills.removeAt(index);
                    //                 });
                    //               },
                    //             );
                    //           }),
                    //         ),
                    //       ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue:_con!.salary.toString(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(9),


                      ],
                      onChanged: (String value) {

                        _con!.salary = value;
                        print("_CON!.salary ${_con!.salary} and value is $value");
                        setState(() {

                          _con!.salaryError=false;
                        });

                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: 'Salary',
                        labelText: 'Salary',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:  kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:  kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    // ReusableTextField(
                    //
                    //   initialValue: _con!.jobDetails!.data!.salary.toString(),
                    //   hintText: 'Salary',
                    //   onChanged: (String value) {
                    //     _con!.salary = (value);
                    //      //_con!.salary = value;
                    //     setState(() {
                    //       _con!.salaryError=false;
                    //     });
                    //   },
                    //   labelText: 'Salary',
                    // ),
                    _con!.salaryError?errorText("Salary is Required and  can\'t be  less han 4 digit."):const SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: _con!.vaccancyOpening.toString(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly,

                      ],
                      onChanged: (String value) {
                        //_con!.vaccancyOpening = int.parse(value);
                        _con!.vaccancyOpening = value;
                        //_con!.vaccancyOpening = value;
                        setState(() {

                          _con!.vaccancyOpeningError=false;
                        });

                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: 'Vaccancy Openings',
                        labelText: 'Vaccancy Openings',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:  kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:  kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    _con!.vaccancyOpeningError?errorText("Vacancy Should not be Empty"):const SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: _con!.description,
                      maxLines: 5,
                      onChanged: (String value) {
                        _con!.description = value;
                        setState(() {
                          _con!.descError=false;
                        });
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: 'Description ',
                        labelText: 'Description',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kGreyColor),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),_con!.descError?errorText("Description Should not be Empty"):const SizedBox(),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: ReusableButton(
                        title: 'Update',
                        onPressed: () {
                        setState(() { });
                          _con!.updateJob(widget.jobdetails!.data!.id!, context);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
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
            child: Text(' $text', style: TextStyle(color: Colors.red,fontSize: 14)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
