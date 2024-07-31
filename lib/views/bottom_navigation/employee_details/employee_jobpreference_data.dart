import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';
import 'package:manago_employer/models/EmployeeListDetailsModel.dart';

class EmployeeJobPreferenceData extends StatefulWidget {
  final EmployeeData? data;

  const EmployeeJobPreferenceData({Key? key, this.data}) : super(key: key);

  @override
  _EmployeeJobPreferenceState createState() => _EmployeeJobPreferenceState();
}

class _EmployeeJobPreferenceState extends State<EmployeeJobPreferenceData> {
  // List<String> location = ['Pune', 'Banglore', 'Lucknow'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: "Profile Title -  ",
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.profileTitle == null
                    ? 'No value'
                    : widget.data!.candidateId!.jobPreference!.profileTitle,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Preferred Location -  ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.preferedLocation!
                    .toString()
                    .split('[')
                    .last
                    .split(']')
                    .first,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Preferred Roles -  ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.prefferedRole!
                            .length ==
                        0
                    ? 'No value'
                    : widget.data!.candidateId!.jobPreference!.prefferedRole!
                        .toString()
                        .split('[')
                        .last
                        .split(']')
                        .first,
              ),
            ],
          ),

          // Subheading(
          //   subheading: 'Preferred Job Types',
          // ),
          // Value(
          //   text:
          //       widget.data.candidateId.jobPreference.prefferefJobType.length ==
          //               0
          //           ? 'No value'
          //           : widget.data.candidateId.jobPreference.prefferefJobType
          //               .toString()
          //               .split('[')
          //               .last
          //               .split(']')
          //               .first,
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Shift type -  ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.shiftType == null
                    ? 'No value'
                    : widget.data!.candidateId!.jobPreference!.shiftType,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Language -  ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.language!.length == 0
                    ? 'No value'
                    : widget.data!.candidateId!.jobPreference!.language
                        .toString()
                        .split('[')
                        .last
                        .split(']')
                        .first,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
