import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/heading.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';

class CandidateProfessionalInfo extends StatefulWidget {
  final CandidateData? data;

  const CandidateProfessionalInfo({Key? key, this.data}) : super(key: key);
  @override
  _ProfessionalInfoState createState() => _ProfessionalInfoState();
}

class _ProfessionalInfoState extends State<CandidateProfessionalInfo> {
  List<String> keySkills = [
    'Flutter',
    'dart',
    'msoffice',
    'python',
    'ui/ux',
    'team management',
    'javascript',
    'mongodb',
    'java'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Heading(
              heading: 'Professional Info',
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Experience -  ',
              ),
              Value(
                text: widget.data!.professionalInfo!.totalExperience == null
                    ? 'No value'
                    : "${widget.data!.professionalInfo!.totalExperience} years",
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0;
                    i < widget.data!.professionalInfo!.jobDetails!.length;
                    i++)
                  Card(
                    shape: RoundedRectangleBorder(),
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 250,
                      constraints: BoxConstraints(maxWidth: 200),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Job title  ",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.data!.professionalInfo!.jobDetails![i].jobTitle ==
                                      null
                                  ? 'No value'
                                  : widget.data!.professionalInfo!.jobDetails![i]
                                      .jobTitle!,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.data!.professionalInfo!.jobDetails![i]
                                              .startDate ==
                                          null
                                      ? 'No value'
                                      : widget.data!.professionalInfo!
                                          .jobDetails![i].startDate!,
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 2,
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.data!.professionalInfo!.jobDetails![i]
                                              .startDate ==
                                          null
                                      ? 'No value'
                                      : widget.data!.professionalInfo!
                                          .jobDetails![i].startDate!,
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   widget.data.professionalInfo
                            //               .jobDetails[i].salary ==
                            //           null
                            //       ? 'No value'
                            //       : "₹ ${widget.data.professionalInfo.jobDetails[i].salary} ${widget.data.candidateId.professionalInfo.jobDetails[i].salaryType} ",
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //   ),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   widget.data.personalInfo.city,
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Text(
                              widget.data!.professionalInfo!.jobDetails![i]
                                          .jobSummary ==
                                      null
                                  ? "No value"
                                  : widget.data!.professionalInfo!.jobDetails![i]
                                      .jobSummary!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Key Skills -  ',
              ),
              Expanded(
                child: Value(
                  text: widget.data!.professionalInfo!.keySkills!
                      .toString()
                      .split(']')
                      .first
                      .split('[')
                      .last,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Preffered Industry -  ',
              ),
              Value(
                text: widget.data!.professionalInfo!.preferredIndustry!,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Preffered Function -  ',
              ),
              Value(text: widget.data!.professionalInfo!.preferredIndustry),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Resume -  ',
              ),
              InkWell(
                onTap: () {},
                child: Value(
                  text: 'resume_file_name.pdf',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
