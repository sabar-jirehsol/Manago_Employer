import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:manago_employer/components/reusable_dropDown.dart';
import 'package:manago_employer/components/reusable_textField.dart';
import 'package:manago_employer/components/searchable_dropDown.dart';
import 'package:manago_employer/controllers/employee/professional_info_controller.dart';
import 'package:manago_employer/models/user.dart';
import 'package:manago_employer/utils/city_constant.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

// ignore: must_be_immutable
class CardView extends StatefulWidget {
  final User? user;

  CardView({
    Key? key,
    this.user,
  }) : super(key: key);
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends StateMVC<CardView> {
  final form = GlobalKey<FormState>();
  ProfessionalInfoController? _con;
  _CardViewState() : super(ProfessionalInfoController()) {
    _con = controller as ProfessionalInfoController?;
  }
  String? snackbar;

  @override
  void initState() {
    super.initState();
    _con!.getCitiesList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //TODO:jobtitle and employer
            ReusableTextField(
              hintText: 'Job Title',
              labelText: 'Job title',
              onChanged: (value) => widget.user!.jobTitle = value,
            ),

            SizedBox(
              height: 20,
            ),

            ReusableTextField(
              hintText: 'Company Name',
              labelText: 'Employer',
              onChanged: (value) => widget.user!.employerController = value,
            ),
            SizedBox(
              height: 20,
            ),
            //TODO: start and end date
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: kPurple)),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.white,
                    child: Text(
                      widget.user!.startDate == null
                          ? 'Start Date'
                          : '${widget.user!.startDate}',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    onPressed: () async {
                      DateTime startDate =
                          await _con!.selectDate(context, DateTime.now());
                      final df = new DateFormat('dd-MMM-yyyy');
                      widget.user!.startDate = df.format(startDate);
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: widget.user!.checkBoxValue!
                      ? Container()
                      : MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: kPurple)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          color: Colors.white,
                          child: Text(
                            widget.user!.endDate == null
                                ? 'End Date'
                                : '${widget.user!.endDate}',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          onPressed: () async {
                            DateTime endDate =
                                await _con!.selectDate(context, DateTime.now());
                            final df = new DateFormat('dd-MMM-yyyy');
                            widget.user!.endDate = df.format(endDate);
                            setState(() {});
                          },
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: widget.user!.checkBoxValue,
                  onChanged: (value) {
                    setState(() {
                      widget.user!.checkBoxValue = value;
                    });
                  },
                  activeColor: kPurpleAccent,
                  // checkColor: kOrangeAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'I currently work here',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //TODO:salary
            Row(
              children: [
                Expanded(
                  child: ReusableDropDown(
                    hintText: 'Salary type',
                    value: widget.user!.salaryPer,
                    options: ['Per Anum', 'Per Month'],
                    onChanged: (value) {
                      setState(() {
                        widget.user!.salaryPer = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ReusableTextField(
                    hintText: 'Salary',
                    labelText: 'Salary',
                    keyboardType: TextInputType.number,
                    onChanged: (value) => widget.user!.salaryController=value,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            // States and city
            SearchableDD(
              hintText: 'City',
              label: 'City',
              items: _con!.citesList,
              selectedItem: _con!.city,
              onChanged: (value) {
                setState(() {
                  _con!.city = value;
                  widget.user!.city = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),

            // TODO notice period
            widget.user!.checkBoxValue == false
                ? Container()
                : TextFormField(
                    style: TextStyle(fontSize: 12),
                    onChanged: (value) => widget.user!.noticePeriod = value,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        hintText: 'Notice Period',
                        labelText: 'Notice Period',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: kPurple)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kPurple),
                            borderRadius: BorderRadius.circular(10))),
                  ),

            SizedBox(
              height: 20,
            ),

            //TODO: jobsumary
            TextFormField(
              onChanged: (value) => widget.user!.jobSummary = value,
              maxLines: 5,
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: 'Job Summary....',
                labelText: 'Job Summary',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPurple,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPurple,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
