import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/heading.dart';
import 'package:manago_employer/models/EmployeeListDetailsModel.dart';
import 'package:manago_employer/utils/color_constants.dart';

import 'package:manago_employer/views/bottom_navigation/applicants/job_preferrence.dart';

import 'employee_education_Info_data.dart';
import 'employee_jobpreference_data.dart';
import 'employee_professional_info_data.dart';

class EmployeeInfo extends StatefulWidget {
  final EmployeeData? data;

  const EmployeeInfo({Key? key, this.data}) : super(key: key);

  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggableScrollableSheet(
          initialChildSize: 0.9,
          builder: (BuildContext context, myscrollController) => ListView(
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Heading(
                    heading: 'Professional Info',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //personal info
                  // PersonalInfoData(),
                  ((widget.data!.candidateId!.professionalInfo!.totalExperience == 0 ||
                      widget.data!.candidateId!.professionalInfo!.totalExperience == null) &&
                      widget.data!.candidateId!.professionalInfo!.keySkills!.length == 0 &&
                      widget.data!.candidateId!.professionalInfo!.preferedFunction == null &&
                      widget.data!.candidateId!.professionalInfo!.prefferedIndustry == null &&
                      widget.data!.candidateId!.professionalInfo!.jobDetails!.length == 0)
                      ? Container(
                          child: Center(
                            child: Text(
                              'No data',
                              style:
                                  TextStyle(fontSize: 18, color: kPrimaryColor),
                            ),
                          ),
                        )
                      : EmployeeProfessionalInfoData(
                          data: widget.data,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Heading(
                    heading: 'Education Info',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (widget.data!.candidateId!.educationalInfo!
                                  .highestQualification ==
                              null &&
                      widget.data!.candidateId!.educationalInfo!
                                  .educationDetails!.length ==
                              0)
                      ? Container(
                          child: Center(
                            child: Text(
                              'No data',
                              style:
                                  TextStyle(fontSize: 18, color: kPrimaryColor),
                            ),
                          ),
                        )
                      : EmployeeEducationInfoData(
                          data: widget.data,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Heading(
                    heading: 'Job Preference',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (widget.data!.candidateId!.jobPreference!.profileTitle == null &&
                      widget.data!.candidateId!.jobPreference!.prefferefJobType == null &&
                      widget.data!.candidateId!.jobPreference!.prefferefJobType == null &&
                      widget.data!.candidateId!.jobPreference!.shiftType == null &&
                      widget.data!.candidateId!.jobPreference!.preferedLocation!.length == 0)
                      ? Container(
                          child: Center(
                            child: Text(
                              'No data',
                              style:
                                  TextStyle(fontSize: 18, color: kPrimaryColor),
                            ),
                          ),
                        )
                      : EmployeeJobPreferenceDatat(
                          data: widget.data,
                        ),
                ],
              )),
    );
  }
}
