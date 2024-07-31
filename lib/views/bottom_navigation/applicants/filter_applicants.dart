import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/range_slider.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/search_bar.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/applicants.dart/applicants_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FilterApplicants extends StatefulWidget {
  const FilterApplicants({Key? key}) : super(key: key);

  @override
  _FilterApplicantsState createState() => _FilterApplicantsState();
}

class _FilterApplicantsState extends StateMVC<FilterApplicants> {
  ApplicantsController? _con;

  bool Applyfilter_error=false,min_maxError=false,search_locationError=false;
  String? Applyfilter_error_text;
  TextEditingController searchController=TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController keyskillController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  // String minExpereince = '0';
  // String maxExperience = '0';
  RangeValues salaryRange = RangeValues(0, 0); // Default salary range
  final _multiKey = GlobalKey<DropdownSearchState<String>>();


  _FilterApplicantsState() : super(ApplicantsController()) {
    _con = controller as ApplicantsController?;
  }

  @override
  void initState() {
    //_con!.getJobTitleList();
    _con!.getCitiesList();
    _con!.getDesignationList();
    _con!.getExperienceList();
    _con!.getSkillsList();

    super.initState();
  }

  static const List<String> listItems = [
    "apple",
    "orange",
    "banana",
    "melon",
    "Replace _con!.citesList Instead of listItems"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

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
            'All Filters',
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  // _con!.resetScreen();
                  setState(() {});
                  _con!.selectedCity = null;
                  _con!.designationVal = null;
                  // _con!.skillSetVal = null;
                  _con!.experience = null;
                  _con!.jobTitle = null;
                  _con!.maxSalary = null;
                  _con!.minSalary = null;

                  _con!.selectedCity='';
                  _con!.designationVal='';
                  // _con!.skillSetVal='';
                  _con!.skillSetVal=[];
                  searchController.clear();
                  designationController.clear();
                  keyskillController.clear();
                  minController.clear();
                  maxController.clear();
                   salaryRange = RangeValues(0, 0); // Default salary range

                  _multiKey.currentState?.clear();


                  // _con!.formkey.currentState?.reset();
                  print("sec${_con!.selectedCity}");
                  //setState(() {});
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: kBlueColor),
                )),
            SizedBox(
              width: 8,
            )
          ],
        ),
        body: _con!.citesList == null
            ? Container()
            : Container(
          child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _con!.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 21),
                    Text(
                      'Location',
                      style: TextStyle(
                          fontSize: 18,
                          color: kBlueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),

                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        final filteredList = _con!.searchCitiesList.where((String option) {
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
                      onSelected: (String selectedCitys) {
                        setState(() {
                          _con!.selectedCity = selectedCitys; // Update the selected city
                          // Update the text in searchController
                        });
                      },
                      fieldViewBuilder: (BuildContext context,TextEditingController fieldController,
                          FocusNode focusNode, VoidCallback onFieldSubmitted) {
                        searchController=fieldController;
                        return TextFormField(
                          controller:searchController, // Use the searchController for both TextFormField and Autocomplete
                          keyboardType: TextInputType.visiblePassword,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                          ],
                          focusNode: focusNode,
                          onChanged: (String value) {
                            setState(() {
                              if(value.isNotEmpty){
                                _con!.getSearchCitiesList(value);
                                _con!.selectedCity = value;
                                search_locationError=false;
                                Applyfilter_error=false;
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

                          shadowColor: kGreyColor,
                          child: SizedBox(
                            height: 150,
                            width: 336,
                            child: ListView(
                              children: options
                                  .map((e) => ListTile(
                                onTap: e=='No items match' ? null : () => onSelected(e),
                                title: Text(e),
                              ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),

                    search_locationError
                        ? errorText(
                        "Please Select Right Location.")
                        : const SizedBox(),
                    SizedBox(height: 16),

                   // SizedBox(height: 24),

                    Text(
                      'Designation',
                      style: TextStyle(
                          fontSize: 18,
                          color: kBlueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
                    // SearchFieldwithSingleSelection(
                    //   label: 'Choose Designation',
                    //   itemList: _con!.designationList,
                    //   itemController: designationController,
                    //   // itemKey: 'designationTitle',
                    //   onChanged: (selectedItem) {
                    //     setState(() {
                    //       _con!.designationVal =selectedItem;
                    //     });
                    //     FocusManager.instance.primaryFocus?.unfocus();
                    //     print("DESLIST: ${_con!.designationVal}");
                    //   },
                    // ),
                    Container(
                      height: 50,
                      child: SearchableDD(
                        //controller: designationController,
                        hintText: 'Choose Designation',
                        label: 'Choose Designation',
                        items:  _con!.designationList,
                        selectedItem:_con!.designationVal ,
                        showClearButton: false,
                        onChanged: (value) {
                          setState(() {
                            _con!.designationVal = value;
                            Applyfilter_error=false;

                          });
                        },
                      ),
                    ),

                    SizedBox(height: 24),
                    Text(
                      'Experience Level',
                      style: TextStyle(
                          fontSize: 18,
                          color: kBlueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
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
                              //onChanged: (value)=> _con!.minexp = int.parse(value),
                              onChanged: (value){
                                _con!.minexp=int.parse(value);
                                setState((){
                                  min_maxError=false;
                                  Applyfilter_error=false;
                                });
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
                             // onChanged: (value) =>  _con!.maxexp =int.parse(value),
                              onChanged: (value){
                                _con!.maxexp=int.parse(value);
                                setState((){
                                  min_maxError=false;
                                  Applyfilter_error=false;
                                });
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

                    SizedBox(height: 24),
                    Text(
                      'Skill Set',
                      style: TextStyle(
                          fontSize: 18,
                          color: kBlueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
                    //
                    // SearchFieldwithSingleSelection(
                    //   label: 'Choose Skills',
                    //   itemList: _con!.skillSetList,
                    //   itemController: keyskillController,
                    //   // itemKey: 'designationTitle',
                    //   onChanged: (selectedItem) {
                    //     setState(() {
                    //       if(!_con!.skillSetVal.contains(selectedItem)){
                    //         _con!.skillSetVal.add(selectedItem);
                    //       }
                    //
                    //     });
                    //     FocusManager.instance.primaryFocus?.unfocus();
                    //     print("skillLIST: ${_con!.skillSetVal}");
                    //   },
                    // ),
                    // SizedBox(height: 10),
                    // Wrap(
                    //   spacing: 10,
                    //   children:  _con!.skillSetVal.map((e) => Chip(
                    //     label: Text(e),
                    //     onDeleted: () {
                    //       setState(() {
                    //
                    //         _con!.skillSetVal.remove(e);
                    //         keyskillController.clear();
                    //       });
                    //     },
                    //   )).toList(),
                    // ),
                    Container(height: 50,
                      child: MultiLevelDropdown<String>(

                     dropdownKey: _multiKey,
                      hintText: 'Choose Skills',
                      label: 'Choose Skills',
                      items:  _con!.skillSetList, // Assuming skillSetList is a list of strings
                      onChanged: (selectedItems) {
                        // Handle the selected items here
                        // selectedItems is a list of strings
                       // designationController.text = selectedItems.isNotEmpty ? selectedItems.join(', ') : ''; // Update the controller with the selected items
                        _con!.skillSetVal = selectedItems; // Update the list of selected skills
                        setState((){
                          Applyfilter_error=false;
                        });
                      },
                    ),
                        ),






                    // Container(
                    //   height: 50,
                    //   child: SearchableDD(
                    //     controller: TextEditingController(text:_con!.skillSetVal ),
                    //     hintText: 'Choose Skills',
                    //     label: 'Choose Skills',
                    //     showClearButton: false,
                    //     selectedItem: _con!.skillSetVal ,
                    //     items:  _con!.skillSetList,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         _con!.skillSetVal = value;
                    //       });
                    //     },
                    //   ),
                    // ),
                    // DropdownField(
                    //   initialValue: _con!.skillSetVal,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _con!.skillSetVal = value;
                    //     });
                    //   },
                    //   label: 'Choose Skills',
                    //   options: _con!.skillSetList,
                    // ),
                    SizedBox(height: 24),
                    Text(
                      'Expected Salary',
                      style: TextStyle(
                          fontSize: 18,
                          color: kBlueGrey,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 65,
                      child: SalaryRangeSelector(
                        key: GlobalKey(),
                        initialValues: salaryRange,
                        maxSalary: 100,
                        minSalary: 0,
                        onRangeChanged: (rangeValues) {
                          _con!.minSalary = rangeValues.start;
                          _con!.maxSalary = rangeValues.end;

                          // setState((){
                          //   Applyfilter_error=false;
                          // });
                        },
                      ),
                    ),

                    SizedBox(height: 24),
                    Center(
                        child: Container(
                            width: 188,
                            child:  Applyfilter_error
                                ? errorText(Applyfilter_error_text!)
                                : const SizedBox())),
                    Center(
                      child: Container(
                        width: 130,
                        child: ReusableButton(
                          onPressed: () {
                            print("APPLY BUTTON");
                            print(_con!.selectedCity);
                            print(_con!.designationVal);
                            print(_con!.skillSetVal);
                            print(_con!.minexp);
                            print(_con!.maxexp);
                            print(_con!.minSalary);
                            print(_con!.maxSalary);

                            if( (_con!.selectedCity==null||_con!.selectedCity=="")&& (_con!.designationVal==null||_con!.designationVal=="")
                                && _con!.skillSetVal.isEmpty && _con!.minexp==null &&_con!.maxexp==null&&(_con!.minSalary==0.0||_con!.minSalary==null)
                                &&(_con!.maxSalary==0.0||_con!.maxSalary==null)){
                             setState((){
                               Applyfilter_error=true;
                               Applyfilter_error_text="Please fill atleast one field.";
                             });
                            print("APPLY CONDITION should Not empty");
                            }
                            // else if (_con!.selectedCity!=null ||_con!.designationVal!=null ||_con!.skillSetVal.isNotEmpty||
                            //     _con!.minexp!=null|| _con!.minexp!=null||_con!.minSalary!=0.0||_con!.minSalary!=0.0){
                            //   setState((){
                            //     Applyfilter_error=false;
                            //   });
                            // }
                            else if(_con!.selectedCity!=null &&!_con!.searchCitiesList.contains(_con!.selectedCity)){
                              setState((){
                                search_locationError=true;
                                print("LOcation error");
                                //Applyfilter_error_text="Please Select Right Location";
                              });
                            }

                            else if(_con!.minexp!=null &&_con!.maxexp!=null&&(_con!.minexp!.toInt()> _con!.maxexp!.toInt())){
                             // if(_con!.minexp!.toInt()> _con!.maxexp!.toInt()){
                              setState((){
                                min_maxError=true;
                               // Applyfilter_error=false;
                              });
                            }
                          //}


                            else {
                              _con!.applyFilter(context);
                            }
                          },
                          title: 'Apply',
                        ),
                      ),
                    )
                  ],
                ),
              )),
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
