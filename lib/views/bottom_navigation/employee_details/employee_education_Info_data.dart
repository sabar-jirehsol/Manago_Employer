import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';
import 'package:manago_employer/models/EmployeeListDetailsModel.dart';

class EmployeeEducationInfoData extends StatefulWidget {
  final EmployeeData? data;

  const EmployeeEducationInfoData({Key? key, this.data}) : super(key: key);

  @override
  _EmployeeEducationInfoState createState() => _EmployeeEducationInfoState();
}

class _EmployeeEducationInfoState extends State<EmployeeEducationInfoData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Highest Qualification -  ',
              ),
              Value(
                text: widget.data!.candidateId!.educationalInfo!.highestQualification == null
                    ? 'No value'
                    : widget.data!.candidateId!.educationalInfo!.highestQualification,
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < widget.data!.candidateId!.educationalInfo!.educationDetails!.length; i++)
                  Card(
                    shape: RoundedRectangleBorder(),
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 150,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                widget.data!.candidateId!.educationalInfo!.educationDetails![i].qualification == null
                                    ? 'No Value'
                                    : widget.data!.candidateId!.educationalInfo!.educationDetails![i].qualification!,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.data!.candidateId!.educationalInfo!.educationDetails![i].educationType ==
                                      null
                                  ? 'No Value'
                                  : widget.data!.candidateId!.educationalInfo!.educationDetails![i].educationType!,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.data!.candidateId!.educationalInfo!.educationDetails![i].specialization == null
                                  ? 'No value'
                                  : widget.data!.candidateId!.educationalInfo!.educationDetails![i].specialization!,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.data!.candidateId!.educationalInfo!.educationDetails![i].university == null
                                  ? 'No value'
                                  : widget.data!.candidateId!.educationalInfo!.educationDetails![i].university!,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.data!.candidateId!.educationalInfo!.educationDetails![i].passingYear == null
                                  ? "No value"
                                  : widget.data!.candidateId!.educationalInfo!.educationDetails![i].passingYear!,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.data!.candidateId!.educationalInfo!.educationDetails![i].awardsAndAchivement == null
                                  ? "No value"
                                  : widget.data!.candidateId!.educationalInfo!.educationDetails![i].awardsAndAchivement!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children: [
                                for (var i = 1; i < 1; i++)
                                  Text(
                                    'documents',
                                    style: TextStyle(fontSize: 12),
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
