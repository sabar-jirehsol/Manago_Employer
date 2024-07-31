import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/job/filter_job_controller.dart';
import 'package:manago_employer/utils/city_constant.dart';
import 'package:manago_employer/utils/color_constants.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';

class FilterJobView extends StatefulWidget {
  final String? title;
  const FilterJobView({Key? key, this.title}) : super(key: key);

  @override
  _FilterJobViewState createState() => _FilterJobViewState();
}

class _FilterJobViewState extends StateMVC<FilterJobView> {
  FilterJobController? _con;

  _FilterJobViewState() : super(FilterJobController()) {
    _con = controller as FilterJobController?;
  }

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  @override
  void initState() {
    _con!.getCitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        appBar: AppBar(
          title: Text('${widget.title} Job'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          color: Colors.grey.shade100,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ReusableTextField(
                    hintText: 'Designation',
                    onChanged: (value) => _con!.designation = value,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ReusableTextField(
                          hintText: 'Minimum Salary',
                          labelText: 'Minimum Salary',
                          onChanged: (value) => _con!.minSalary = value,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ReusableTextField(
                          labelText: 'Maximum Salary',
                          hintText: 'Maximum Salary',
                          onChanged: (value) => _con!.maxSalary = value,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ReusableTextField(
                          hintText: 'in years',
                          labelText: 'Minimum Experience',
                          onChanged: (value) => _con!.minSalary = value,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ReusableTextField(
                          labelText: 'Maximum Experience',
                          hintText: 'in years',
                          onChanged: (value) => _con!.maxSalary = value,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //TODO: key skils(chips(tags) , autocomplete)
                  AutoCompleteTextField(
                    key: key,
                    textChanged: (value) {
                      if (value.endsWith(',')) {
                        value = value.split(',').first;
                        setState(() {
                          _con!.keySkills.add(value);
                          _con!.textController.clear();
                        });
                        value = '';
                      }
                    },
                    controller: _con!.textController,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 14),
                        labelStyle: TextStyle(fontSize: 14),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        hintText: ' Type like flutter,',
                        labelText: 'Key Skills',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: kPurple)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPurple),
                            borderRadius: BorderRadius.circular(10))),
                    itemSubmitted: (item) {
                      setState(() {
                        _con!.keySkills.add(item.toString());
                      });
                    },
                    suggestions: _con!.keySkillsSuggestions,
                    itemBuilder: (context, item) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item,
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    },
                    itemSorter: (a, b) {
                      return a.compareTo(b);
                    },
                    itemFilter: (item, query) {
                      return item
                          // .toString()
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  _con!.keySkills.isEmpty
                      ? Container()
                      : Container(
                          child: Wrap(
                            runSpacing: 6,
                            spacing: 6,
                            children: List<Widget>.generate(
                                _con!.keySkills.length, (index) {
                              return Chip(
                                padding: EdgeInsets.all(8),
                                deleteIconColor: Colors.white,
                                backgroundColor: kPurpleAccent,
                                label: Text(
                                  _con!.keySkills[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                onDeleted: () {
                                  setState(() {
                                    _con!.keySkills.removeAt(index);
                                  });
                                },
                              );
                            }),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),

                  // SearchableDD(
                  //   hintText: 'City',
                  //   label: 'City',
                  //   items: _con!.citesList,
                  //   onChanged: (String value) {
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //
                  //     setState(() {
                  //       _con!.city.add(value);
                  //     });
                  //   },
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  _con!.city.isEmpty
                      ? Container()
                      : Container(
                          child: Wrap(
                            runSpacing: 6,
                            spacing: 6,
                            children: List<Widget>.generate(_con!.city.length,
                                (index) {
                              return Chip(
                                padding: EdgeInsets.all(8),
                                deleteIconColor: Colors.white,
                                backgroundColor: kPurpleAccent,
                                label: Text(
                                  _con!.city[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                onDeleted: () {
                                  setState(() {
                                    _con!.city.removeAt(index);
                                  });
                                },
                              );
                            }),
                          ),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                  ReusableButton(
                    onPressed: () {
                      _con!.searchJob(context);
                    },
                    title: '${widget.title} Job',
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
