import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/title_text.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/profile_completion.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeUpdateView extends StatefulWidget {
  @override
  _EmployeeUpdateViewState createState() => _EmployeeUpdateViewState();
}

class _EmployeeUpdateViewState extends StateMVC<EmployeeUpdateView> {
  ProfileCompletionController? _con;
  _EmployeeUpdateViewState() : super(ProfileCompletionController()) {
    _con = controller as ProfileCompletionController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.loadStates(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        appBar: AppBar(
          title: Text('Update Employee'),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                TitleText(text: 'Personal Info'),
                SizedBox(height: 30),
                MaterialButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          children: [
                            Text(
                              'Choose a Profile Photo',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () {
                                      _con!.takePhoto(ImageSource.camera);
                                    },
                                    icon: Icon(Icons.camera),
                                    label: Text('Camera')),

                                ElevatedButton.icon(
                                    onPressed: () {
                                      _con!.takePhoto(ImageSource.gallery);
                                    },
                                    icon: Icon(Icons.image),
                                    label: Text('Gallery'))
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _con!.profilePic == null
                          ? Image.asset('assets/images/add_image.png').image
                          : FileImage(File(_con!.profilePic!.path)
                      ),
                      backgroundColor: Colors.white),
                ),
                SizedBox(height: 30),
                ReusableTextField(
                  hintText: 'Full Name',
                  onChanged: (value) => _con!.name = value,
                ),
                SizedBox(height: 30),
                ReusableTextField(
                  hintText: 'Email Address',
                  onChanged: (value) => _con!.email = value,
                ),
                SizedBox(height: 30),
                TextField(
                  onChanged: (value) => _con!.address = value,
                  maxLines: 3,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Full Address',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPurple),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPurple),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    // Expanded(
                    //   child: ReusableDropDown(
                    //     hintText: 'State',
                    //     value: _con!.newState,
                    //     items: _con!.newStates,
                    //     onSelected: (value) {
                    //       _con!.newState = value;
                    //       _con!.loadCities(value);
                    //     },
                    //   ),
                    // ),
                    // SizedBox(width: 10),
                    // Expanded(
                    //   child: ReusableDropDown(
                    //     hintText: 'City',
                    //     value: _con!.city,
                    //     items: _con!.cities,
                    //     onSelected: (value) {
                    //       setState(() {
                    //         _con!.city = value;
                    //       });
                    //     },
                    //   ),
                    // )
                    Expanded(
                      child: SearchableDD(
                        hintText: 'Search State',
                        label: 'State',
                        items: _con!.newStates,
                        selectedItem: _con!.newState,
                        onChanged: (value) {
                          _con!.newState = value;
                          _con!.loadCities(_con!.newState!);
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
                        selectedItem: _con!.city,
                        onChanged: (value) {
                          _con!.city = value;
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      labelText: 'Pincode',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPurple),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPurple),
                          borderRadius: BorderRadius.circular(10)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kPurple),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10))),
                  style: TextStyle(fontSize: 18),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9+]")),
                  ],
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: (val) {
                    _con!.pincode = val;
                  },
                ),
                SizedBox(height: 20),
                TitleText(text: 'Buisness Info'),
                SizedBox(height: 30),
                ReusableTextField(
                    hintText: 'Business Name',
                    onChanged: (value) {
                      _con!.businessName = value;
                    }),
                SizedBox(height: 30),
                ReusableDropDown(
                  hintText: 'Firm Type',
                  value: _con!.firmType,
                  options: _con!.firmArray,
                  onChanged: (value) {
                    setState(() {
                      _con!.firmType = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                ReusableTextField(
                    hintText: 'GSTIN No.',
                    onChanged: (value) {
                      _con!.gstIn = value;
                    }),
                SizedBox(height: 30),
                ReusableTextField(
                    hintText: 'Total Staff',
                    onChanged: (value) {
                      _con!.totalStaff = int.parse(value);
                    }),
                SizedBox(height: 30),
                ReusableDropDown(
                  hintText: 'Annual Turnover',
                  value: _con!.turnover,
                  options: _con!.turnoverArray,
                  onChanged: (value) {
                    setState(() {
                      _con!.turnover = value;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                TitleText(text: 'Documents'),
                SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kPurple),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: _con!.adhaar == null
                        ? MaterialButton(
                            onPressed: () {
                              _con!.getAdhar();

                              _con!.adhaar.toString();
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Upload Adhar',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.cloud_upload_outlined),
                              Container(
                                constraints: BoxConstraints(maxWidth: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(
                                  _con!.adhaar!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _con!.getAdhar();

                                  setState(() {});
                                },
                                child: Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          )),
                Center(
                  child: Text(
                    '(pdf- 6MB max)',
                    style: TextStyle(color: Colors.teal, fontSize: 12),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kPurple),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: _con!.companyRegistration == null
                        ? MaterialButton(
                            onPressed: () {
                              _con!.getCompanyRegistration();

                              _con!.companyRegistration.toString();
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Upload Company Registration',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.cloud_upload_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text(_con!.companyRegistration!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _con!.getCompanyRegistration();

                                  setState(() {});
                                },
                                child: Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          )),
                Center(
                  child: Text(
                    '(pdf- 6MB max)',
                    style: TextStyle(color: Colors.teal, fontSize: 12),
                  ),
                ),
                SizedBox(height: 50),
                ReusableButton(
                  title: 'Update',
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ControllerScreen(),
                    //     ));
                    //_con!.updateEmployer(context);
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
