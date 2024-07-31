import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/heading.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';
import 'package:manago_employer/models/EmployeeListDetailsModel.dart';

class ApplicantJobPreferenceData extends StatefulWidget {
  final ApplicantsDetailsData? data;

  const ApplicantJobPreferenceData({Key? key, this.data}) : super(key: key);

  @override
  _JobPreferenceState createState() => _JobPreferenceState();
}

class _JobPreferenceState extends State<ApplicantJobPreferenceData> {
  List<String> location = ['Pune', 'Banglore', 'Lucknow'];
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
                subheading: "Profile Title - ",
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
                subheading: 'Preferred Location - ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.preferedLocation
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
                subheading: 'Preferred Roles - ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.prefferedRole!.length == 0
                    ? 'No value'
                    : widget.data!.candidateId!.jobPreference!.prefferedRole.toString().split('[').last.split(']').first,
              ),
            ],
          ),
          // Subheading(
          //   subheading: 'Preferred Job Types',
          // ),
          // Value(
          //   text: widget.data.candidateId.jobPreference.prefferefJobType == null
          //       ? 'No value'
          //       : widget.data.candidateId.jobPreference.prefferefJobType,
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Shift type - ',
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
                subheading: 'Language - ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.language!.length == 0
                    ? 'No value'
                    : widget.data!.candidateId!.jobPreference!.language.toString().split('[').last.split(']').first,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EmployeeJobPreferenceDatat extends StatefulWidget {
  final EmployeeData? data;
  const EmployeeJobPreferenceDatat({Key? key, this.data}) : super(key: key);

  @override
  State<EmployeeJobPreferenceDatat> createState() =>
      _EmployeeHobPreferenceStateData();
}

class _EmployeeHobPreferenceStateData
    extends State<EmployeeJobPreferenceDatat> {
  List<String> location = ['Pune', 'Banglore', 'Lucknow'];
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
                subheading: "Profile Title - ",
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
                subheading: 'Preferred Location - ',
              ),
              Value(
                text: widget.data!.candidateId!.jobPreference!.preferedLocation.toString().split('[').last.split(']').first,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Preferred Roles - ',
              ),
              Expanded(
                child: Value(
                  text: widget.data!.candidateId!.jobPreference!.prefferedRole!.length == 0
                      ? 'No value'
                      : widget.data!.candidateId!.jobPreference!.prefferedRole!.toString()
                          .split('[')
                          .last
                          .split(']')
                          .first,
                ),
              ),
            ],
          ),
          // Subheading(
          //   subheading: 'Preferred Job Types',
          // ),
          // Value(
          //   text: widget.data.candidateId.jobPreference.prefferefJobType == null
          //       ? 'No value'
          //       : widget.data.candidateId.jobPreference.prefferefJobType,
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Shift type - ',
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
                subheading: 'Language - ',
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
