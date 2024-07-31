import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/job/job_applicants_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/job/applicant_details.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class JobApplicant extends StatefulWidget {
  final String? id;

  const JobApplicant({Key? key, this.id}) : super(key: key);
  @override
  _JobApplicantState createState() => _JobApplicantState();
}

class _JobApplicantState extends StateMVC<JobApplicant> {
  JobApplicantsController? _con;

  _JobApplicantState() : super(JobApplicantsController()) {
    _con = controller as JobApplicantsController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.getApplicantsAgainstJob(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _con!.applicantsList.length == 0
          ? SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'No Applicants',
                  style: TextStyle(fontSize: 18, color:Colors.black),
                ),
              ),
            )
          : DraggableScrollableSheet(
              initialChildSize: 0.9,
              builder: (BuildContext context, myScrollController) =>
                  ListView.builder(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      itemCount: _con!.applicantsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplicantDetails(
                                            data: _con!.applicantsList[index],
                                          )));
                            },
                            child: Card(
                              color: Colors.grey.shade100,
                              margin: EdgeInsets.symmetric(vertical: 7),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      width: 50,
                                      height: 300,
                                      child: Text(
                                        DatePickerClass.dateFormatterMonths(_con!.applicantsList[index].createdAt!),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    ),
                                    title: RichText(
                                        text: TextSpan(
                                      text: _con!.applicantsList[index].candidateId!.personalInfo!.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          _con!.applicantsList[index].candidateId!.personalInfo!.city!,
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(_con!.applicantsList[index].candidateId!.educationalInfo!.highestQualification ??
                                              'No data',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(_con!.applicantsList[index].jobId!.designation!,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Text(
                                        //   '#123456',
                                        //   style:
                                        //       TextStyle(color: Colors.red, fontSize: 12),
                                        // ),
                                        Text(
                                          _con!.applicantsList[index].status!,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 12),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: kPrimaryColor),
                                          child: Text(
                                            'Resume',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
            ),
    );
  }
}
