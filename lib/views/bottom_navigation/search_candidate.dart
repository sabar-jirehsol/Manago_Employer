import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/Search_Candidate_Controller.dart';
import 'package:manago_employer/controllers/search_candidates_result.dart';
import 'package:manago_employer/services/StateCityServices.dart';
import 'package:manago_employer/utils/city_constant.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/common_location_model.dart';

class SearchCandidate extends StatefulWidget {
  @override
  _SearchCandidateState createState() => _SearchCandidateState();
}

class _SearchCandidateState extends State<SearchCandidate> {
  @override
  void initState() {
    getJobTitleList();
    getDesignationList();
    getSkillsList();
    super.initState();
  }

  bool min_maxError = false;
  bool fields_error = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController aadharController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  TextEditingController designationController =
      TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController keyskillController = TextEditingController();

  String minSalary = '0';
  String maxSalary = '0';
  String minExpereince = '0';
  String maxExperience = '0';
  String designation = '';
  List<String> selectedKeySkills = [];
  String? jobTitle;
  List<String> city = [];
  List<String> citesList = [];
  List<String> desList = [];
  List<String> countryList = [];
  CommonLocationModel? locationList;
  bool cityVisible = false;
  List<String>? jobTitlesList;
  String searchText = '';

  final _multiKey1 = GlobalKey<DropdownSearchState<String>>();
  final _multiKey2 = GlobalKey<DropdownSearchState<String>>();

  getJobTitleList() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    String? id = _prefs.getString('employerId');
    FilterDataServices.getJobTitles(
            '${API.getDesignation}',
            //'${API.getSearchJobTitles}/$id?\$orderBy=jobTitle asc&\$limit=500&\$apply=groupby(jobTitle)',
            //_token!,
            scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        jobTitlesList = value;
        setState(() {});
      }
    });
  }

  List<String> designationList = [];

  getDesignationList() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // String? _token = _prefs.getString('token');
    FilterDataServices.getDesignations(API.getDesignation, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        designationList = value;
        setState(() {});
      }
    });
  }

  List<String> skillSetList = [];

  getSkillsList() async {
    EasyLoading.show(status: 'Please wait...');
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    FilterDataServices.getSkills(API.getSkills, scaffoldKey).then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        skillSetList = value;
        setState(() {});
      }
    });
  }

  List<String> searchCitiesList = [];

  getSearchCitiesList(String value) async {
    EasyLoading.show(status: 'Please wait...', dismissOnTap: true);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // String? _token = _prefs.getString('token');
    FilterDataServices.getSearchCitiesList(
            API.preferredLocation,
        //API.preferredCountry,
        value, scaffoldKey)
        .then((value) {
      EasyLoading.dismiss();
      if (value != null) {
        searchCitiesList = value;
        print("Search Places");
        setState(() {});
      }
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCandidateFilterOptions();
  }

  _buildCandidateFilterOptions() {
    return GestureDetector(
      onTap: () {
        // FocusScope is used to manage the focus of the text fields
        FocusScope.of(context)
            .unfocus(); // Unfocus text field to dismiss keyboard
      },

      child:SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: 90,
                height: 6,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Location',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  //Navigator.pop(context);
                  setState(() {
                    searchText = ''; // Clear the search text
                    designation = ''; // Clear the designation
                    minExpereince = '0'; // Reset experience levels
                    maxExperience = '0';
                    selectedKeySkills = []; // Clear selected key skills
        
                    citesList = [];
                    desList = [];
        
                    desList.clear();
                    citesList.clear();
                    searchController.clear();
                    designationController.clear();
                    minController.clear();
                    maxController.clear();
                    keyskillController.clear();
                    min_maxError = false;
                    fields_error = false;
        
                    _multiKey1.currentState?.clear();
                    _multiKey2.currentState?.clear();
                  });
                  print('search Controller ${searchController.text}');
                  print('Search Text: $searchText');
                  print('Designation: $desList');
                  print('Min Experience: $minExpereince');
                  print('Max Experience: $maxExperience');
                  print('Selected Key Skills: $selectedKeySkills');
                  print('  minController ${minController}');
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: kBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                final filteredList = searchCitiesList.where((String option) {
                  return option.toLowerCase().startsWith(
                        textEditingValue.text.toLowerCase(),
                      );
                }).toList();
        
                if (filteredList.isEmpty) {
                  return [
                    'No items match'
                  ]; // Return a list containing the message
                } else {
                  return filteredList;
                }
              },
              onSelected: (String selectedCity) {
                setState(() {
                  searchText = selectedCity;
                  // Update the selected city
                  //searchController.text = selectedCity; // Update the text in searchController
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController fieldController,
                  FocusNode focusNode,

                  VoidCallback onFieldSubmitted) {
                searchController = fieldController;
                return TextFormField(
                  controller: searchController,
                  // Use the searchController for both TextFormField and Autocomplete
                  focusNode: focusNode,
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  onChanged: (String value) {
                    setState(() {
                      if(value.isNotEmpty){
                        getSearchCitiesList(value);
                        searchText = value;
                        setState(() {
                          fields_error=false;
                        });
                      }else if(value=='') {
                        // Ensure the options close when the value is empty
                        print("emptynn");
                        searchCitiesList.clear();
                      }

                      // print(searchText);
                      print("value is " + value);
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.location_on,
                      size: 30,
                      color: Colors.black54,
                    ),
                    filled: true,
                    fillColor: kPrimaryColor.withOpacity(0.1),
                    hintText: 'Search Your Location...',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    suffixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black54,
                    ),
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) => Align(
                alignment: Alignment.topLeft,
                child: Material(
                  //elevation: 4,
                 // color: Colors.orange,
                  shadowColor: kGreyColor,
                  child: SizedBox(
                    height: 100,
                    width: 328,
                    child: ListView(
                      children: options
                          .map((e) => ListTile(
                                //onTap: () => onSelected(e),
                        onTap: e=='No items match' ? null : () => onSelected(e),
                                title: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
        
            SizedBox(width: 8),
            //Container(height: 16,),
        
            Text('Designation',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // Container(
            //   height: 50,
            //   child:  SearchableDD(
            //    controller: designationController,
            //     validate: (designation) {
            //       if (designation == null) {
            //         return 'Designation is required';
            //       }
            //     },
            //     hintText: 'Designationyy',
            //     label: 'Designatioiin',
            //     items: designationList,
            //     onChanged: (value) {
            //       FocusScope.of(context).requestFocus(FocusNode());
            //       designation = value;
            //
            //       setState(() {});
            //     },
            //   ),
            // ),
            // Container(
            //   height: 50,
            //   child: SearchableDD(
            //     controller: designationController ,
            //     hintText: 'Choose Designation',
            //     label: 'Choose Designation',
            //     items: designationList,
            //     selectedItem:designation,
            //     showClearButton: false,
            //     onChanged: (value) {
            //       setState(() {
            //         designation = value;
            //         designationController.text=value;
            //       });
            //     },
            //   ),
            // ),
            // SearchFieldwithSingleSelection(
            //   label: 'Designation',
            //   itemList: designationList,
            //   itemController: designationController,
            //
            //   onChanged: (selectedItem) {
            //     setState(() {
            //       if(! desList.contains(selectedItem)){
            //         desList.add(selectedItem);
            //       }
            //
            //     });
            //     FocusManager.instance.primaryFocus?.unfocus();
            //     print(" desListLIST: ${ desList}");
            //   },
            // ),
            // SizedBox(height: 10),
            // Wrap(
            //   spacing: 10,
            //   children: desList.map((e) => Chip(
            //     label: Text(e),
            //     onDeleted: () {
            //       setState(() {
            //
            //         desList.remove(e);
            //         designationController.clear();
            //       });
            //     },
            //   )).toList(),
            // ),


            MultiLevelDropdown<String>(
              dropdownKey: _multiKey1,
              hintText: 'Designation',
              label: 'Designation',
              items: designationList,
              filled: false,
              // Assuming skillSetList is a list of strings
              selectedItem: desList,
              // Reset selected items if reset flag is true
              onChanged: (selectedItems) {

                // designationController.text = selectedItems.isNotEmpty ? selectedItems.join(', ') : ''; // Update the controller with the selected items
                setState(() {
                  desList = selectedItems;
                  fields_error=false;
                  // Update the list of selected skills
                });

                print("DESLIST${desList}");
              },
            ),
        
            // SearchableDD(
            //   //controller: designationController,
            //   hintText: 'Designation',
            //   label: 'Designation',
            //   showClearButton: false,
            //   items: designationList,
            //   selectedItem:designation,
            //   onChanged: (value) {
            //     designation = value;
            //    designationController.text=value;
            //   },
            // ),
        
            SizedBox(height: 8),
            Text('Experience Level',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 2),
            Container(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: ReusableTextField(
                      limitnum: 2,
                      controller: minController,
                      labelText: 'Min',
                      hintText: 'in years',
                      onChanged: (value) {
                        setState(() {
                          fields_error=false;

                        });
                        if(value=="00"){
                          minExpereince="0";
                        }
                        else{
                          minExpereince = value;
                        }


                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ReusableTextField(
                      limitnum: 2,
                      controller: maxController,
                      labelText: 'Max',
                      hintText: 'in years',
                      onChanged: (value) {
                        setState(() {
                          fields_error=false;

                        });
                        if(value=="00"){
                          maxExperience="0";
                        }
                        else{
                          maxExperience = value;
                        }

                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            min_maxError
                ? errorText(
                    "Minimum experience is always less than maximum.")
                : const SizedBox(),
            SizedBox(height: 8),
            Text('Skill Set',
                style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // Container(
            //   height: 50,
            //   child: SearchableDD(
            //     controller: keyskillController ,
            //     hintText: 'Choose Skills',
            //     label: 'Choose Skills',
            //     items: skillSetList,
            //     showClearButton: false,
            //     onChanged: (value) {
            //       setState(() {
            //         keyskillController.text=value;
            //         selectedKeySkills.add(value);
            //       });
            //     },
            //   ),
            // ),

            // SearchFieldwithSingleSelection(
            //   label: 'key skills',
            //   itemList: skillSetList,
            //   itemController: keyskillController,
            //
            //   onChanged: (selectedItem) {
            //     setState(() {
            //       if(! selectedKeySkills.contains(selectedItem)){
            //         selectedKeySkills.add(selectedItem);
            //       }
            //
            //     });
            //     FocusManager.instance.primaryFocus?.unfocus();
            //     print(" selectedKeySkills: ${ selectedKeySkills}");
            //   },
            // ),
            // SizedBox(height: 10),
            // Wrap(
            //   spacing: 10,
            //   children: selectedKeySkills.map((e) => Chip(
            //     label: Text(e),
            //     onDeleted: () {
            //       setState(() {
            //
            //         selectedKeySkills.remove(e);
            //         keyskillController.clear();
            //       });
            //     },
            //   )).toList(),
            // ),
        
            MultiLevelDropdown<String>(
              dropdownKey: _multiKey2,
              hintText: 'key skills',
              label: 'key skills',
              items: skillSetList,
              filled: false,
              // Assuming skillSetList is a list of strings
              onChanged: (selectedItems) {
                setState(() {
                  fields_error=false;
                });
                FocusScope.of(context).requestFocus(FocusNode());
                // Handle the selected items here
                // selectedItems is a list of strings
                keyskillController.text = selectedItems.isNotEmpty
                    ? selectedItems.join(', ')
                    : ''; // Update the controller with the selected items
                selectedKeySkills =
                    selectedItems; // Update the list of selected skills
              },
            ),
        
            // SearchableDDM(
            //   controller: keyskillController,
            //   hintText: 'Key skills',
            //   label: 'keyskills',
            //   showClearButton: false,
            //   items: skillSetList,
            //   selectedItems: [keyskillController.text], // Pass the selected item in a list
            //   onChanged: (value) {
            //     keyskillController.text = value[0]; // Update the controller with the selected item
            //     selectedKeySkills.add(value[0]); // Add the selected item to the list of selected skills
            //   },
            // ),
        
            // SearchableDD(
            //   controller: keyskillController,
            //   hintText: 'Key skills',
            //   label: 'keyskills',
            //   showClearButton: false,
            //   items: skillSetList,
            //   selectedItem: keyskillController.text,
            //   onChanged: (value) {
            //     keyskillController.text=value;
            //     selectedKeySkills.add(value);
            //
            //   },
            // ),
        
            // Container(
            //   height: 40,
            //   child: SearchableDD(
            //     hintText: 'Key Skills',
            //     label: 'Key Skills',
            //     items: skillSetList,
            //     onChanged: (String value) {
            //       FocusScope.of(context).requestFocus(FocusNode());
            //       setState(() {
            //         if (value != null) {
            //           if(selectedKeySkills.isNotEmpty){
            //             for(var i = 0; i < selectedKeySkills.length; i++) {
            //               if (selectedKeySkills.contains(value)) {
            //
            //               }else{
            //                 selectedKeySkills.add(value);
            //               }
            //             }
            //           }
            //           else{
            //             selectedKeySkills.add(value);
            //           }
            //         }
            //       });
            //     },
            //   ),
            // ),
        
            // selectedKeySkills.isEmpty
            //     ? Container()
            //     : Container(
            //         child: Wrap(
            //           runSpacing: 6,
            //           spacing: 6,
            //           children: List<Widget>.generate(selectedKeySkills.length,
            //               (index) {
            //             return Chip(
            //               padding: EdgeInsets.all(8),
            //               deleteIconColor: Colors.white,
            //               backgroundColor: kPrimaryColor,
            //               label: Text(
            //                 selectedKeySkills[index],
            //                 style: TextStyle(color: Colors.white, fontSize: 14),
            //               ),
            //               onDeleted: () {
            //                 setState(() {
            //                   selectedKeySkills.removeAt(index);
            //                 });
            //               },
            //             );
            //           }),
            //         ),
            //       ),
        
            SizedBox(height: 25),
            Center(
                child: Container(
                    width: 188,
                    child: fields_error
                        ? errorText("Please fill atleast one field.")
                        : const SizedBox())),
            Center(
              child: Container(
                width: 130,
                child: ReusableButton(
                  onPressed: () {
                    print(minExpereince.runtimeType);
                    print(maxExperience);
                    if (searchText.isNotEmpty) {
                      citesList.add(searchText);
                    }
                    if (nameController.text.isEmpty &&
                        mobileController.text.isEmpty && desList.isEmpty &&
                        selectedKeySkills.isEmpty
                        && citesList.isEmpty && minExpereince == '0' &&
                        maxExperience == '0'||minExpereince.isEmpty||maxExperience.isEmpty
                    ) {
                      print("Empty Value");
                      setState(() {
                        fields_error = true;
                      }
                      );
                    }
        
        
                    else {
                      print("NO value");
                      print("name Controller text is ${nameController.text}");
                      print(
                          "mobile Controller text is ${mobileController.text}");
                      print("desList is ${desList}");
                      print("cities List ${citesList}");
                      print("selected keylist ${selectedKeySkills}");
                      print("MinExperience is ${minExpereince}");
                      print("MaxExperience is ${maxExperience}");
                      if (int.parse(minExpereince) != 0 &&
                          int.parse(maxExperience) != 0 &&
                          minExpereince.length > 0 &&
                          maxExperience.length > 0) {
                        if (int.parse(minExpereince) <
                            int.parse(maxExperience)) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SearchCandidateResults(
                                    name: nameController.text,
                                    mobile: mobileController.text,
                                    aadhar: aadharController.text,
                                    designation: desList,
                                    cities: citesList,
                                    keySkills: selectedKeySkills,
                                    minExp: int.parse(minExpereince),
                                    maxExp: int.parse(maxExperience),
                                  ),
                            ),);
                        } else {
                          setState(() {
                            min_maxError = true;
                          });
                        }
                      }
                      else {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchCandidateResults(
                                  name: nameController.text,
                                  mobile: mobileController.text,
                                  aadhar: aadharController.text,
                                  designation: desList,
                                  cities: citesList,
                                  keySkills: selectedKeySkills,
                                  minExp: 0,
                                  maxExp: 0,
                                ),
                          ),
                        );
                      }
                    }
        
                  },
                  title: 'Apply',
                ),
              ),
            ),
          ],
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
