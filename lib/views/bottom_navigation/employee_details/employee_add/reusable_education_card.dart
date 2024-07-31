import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/controllers/employee/education_info.dart';
import 'package:manago_employer/models/education.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class EducationCardView extends StatefulWidget {
  final Education? education;

  const EducationCardView({Key? key, this.education}) : super(key: key);
  @override
  _EducationCardViewState createState() => _EducationCardViewState();
}

class _EducationCardViewState extends StateMVC<EducationCardView> {
  EducationalInfoController? _con;
  _EducationCardViewState() : super(EducationalInfoController()) {
    _con = controller as EducationalInfoController?;
  }
  @override
  void initState() {
    if (widget.education!.fileNames == null) {
      widget.education!.fileNames = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO:Qualification
            ReusableDropDown(
              hintText: 'Highest Qualification',
              value: widget.education!.qualification,
              options: _con!.highestQualificationList,
              onChanged: (value) {
                setState(() {
                  widget.education!.qualification = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                //TODO: education type(dd)
                Expanded(
                  child: ReusableDropDown(
                    hintText: 'Education Type',
                    value: widget.education!.educationType,
                    options: _con!.educationTypeList,
                    onChanged: (value) {
                      setState(() {
                        widget.education!.educationType = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),

                //TODO: specialization(dd)
                Expanded(
                  child: ReusableDropDown(
                    hintText: 'Specialization',
                    value: widget.education!.specialization,
                    options: [
                      'dart',
                      'Flutter',
                      'Firebase',
                      'Api',
                    ],
                    onChanged: (value) {
                      setState(() {
                        widget.education!.specialization = value;
                      });
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //TODO: university/institute/school(tb)
            ReusableTextField(
              hintText: "University/Institution/School",
              labelText: 'University/Institution/School',
              onChanged: (value) => widget.education!.university = value,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 20,
            ),
            //TODO: passing year(date)
            // MaterialButton(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       side: BorderSide(color: kPurple)),
            //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //   color: Colors.white,
            //   child: Text(
            //     widget.education!.passingYear == null
            //         ? 'Passing Year'
            //         : '${widget.education!.passingYear}',
            //     style: TextStyle(fontSize: 12, color: Colors.black54),
            //   ),
            //   onPressed: () async {
            //     DateTime birthDate =
            //         await _con!.selectDate(context, DateTime.now());
            //     final df = new DateFormat('dd-MMM-yyyy');
            //     widget.education!.passingYear = df.format(birthDate);
            //     setState(() {});
            //   },
            // ),

            Row(
              children: [
                Expanded(
                  child: MaterialButton(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: kGreyColor)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.white,
                    child: Text(
                      widget.education!.startDate == null
                          ? 'Start Date'
                          : '${widget.education!.startDate}',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    onPressed: () async {
                      DateTime startDate =
                      await _con!.selectDate(context, DateTime.now());
                      final df = new DateFormat('dd-MMM-yyyy');
                      widget.education!.startDate = df.format(startDate);
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child:MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: kGreyColor)),
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.white,
                    child: Text(
                      widget.education!.endDate == null
                          ? 'End Date'
                          : '${widget.education!.endDate}',
                      style:
                      TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    onPressed: () async {
                      DateTime endDate =
                      await _con!.selectDate(context, DateTime.now());
                      final df = new DateFormat('dd-MMM-yyyy');
                      widget.education!.endDate = df.format(endDate);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => widget.education!.awards = value,
              maxLines: 5,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: 'Awards and achievments',
                labelText: 'Awards and achievments',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // TODO: document(ta)

            // Container(
            //     // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     decoration: BoxDecoration(
            //         border: Border.all(color: kPurple),
            //         borderRadius: BorderRadius.all(Radius.circular(10))),
            //     child: widget.education.fileNames.length == 0
            //         ? FlatButton(
            //             onPressed: () {
            //               getFilePath();
            //               setState(() {});
            //             },
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(Icons.cloud_upload_outlined),
            //                 SizedBox(
            //                   width: 20,
            //                 ),
            //                 Expanded(
            //                     child: Text(
            //                   'Upload Resume',
            //                   style: TextStyle(fontSize: 12),
            //                 ))
            //               ],
            //             ))
            //         : Row(
            //             children: [
            //               GestureDetector(
            //                   onTap: () => getFilePath(),
            //                   child: Icon(Icons.cloud_upload_outlined)),
            //               SizedBox(
            //                 width: 20,
            //               ),
            //               Expanded(
            //                 child: Container(
            //                   width: 100,
            //                   height: 50,
            //                   child: ListView.builder(
            //                     addAutomaticKeepAlives: true,
            //                     shrinkWrap: true,
            //                     itemCount: widget.education.fileNames.length,
            //                     itemBuilder: (context, index) {
            //                       return Row(
            //                         children: [
            //                           Expanded(
            //                               child: Text(
            //                             widget.education.fileNames[index],
            //                             style: TextStyle(fontSize: 12),
            //                           )),
            //                           SizedBox(
            //                             width: 10,
            //                           ),
            //                           IconButton(
            //                               icon: Icon(
            //                                 Icons.delete,
            //                                 size: 18,
            //                               ),
            //                               onPressed: () {
            //                                 widget.education.fileNames
            //                                     .removeAt(index);
            //                                 setState(() {});
            //                               })
            //                         ],
            //                       );
            //                     },
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           )),
            // Center(
            //   child: Text(
            //     '(jpg,jpeg,png,pdf- 6MB max)',
            //     style: TextStyle(color: Colors.teal, fontSize: 12),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void getFilePath() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png']);
      String filePath = result!.files.single.path!;
      if (filePath == '') {
        return;
      }

      filePath = filePath.split('/').last.toString();

      var file = filePath;

      setState(() {
        widget.education!.fileNames!.add(file);
        print(widget.education!.fileNames);
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }
}
