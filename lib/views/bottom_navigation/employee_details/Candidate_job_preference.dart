import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/heading.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';

class CandidateJobPreference extends StatefulWidget {
  final CandidateData? data;

  const CandidateJobPreference({Key? key, this.data}) : super(key: key);

  @override
  _JobPreferenceState createState() => _JobPreferenceState();
}

class _JobPreferenceState extends State<CandidateJobPreference> {
  // List<String> location = ['Pune', 'Banglore', 'Lucknow'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Heading(
              heading: 'Job Info',
            ),
          ),
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
                text: widget.data!.jobPreference!.profileTitle == null
                    ? 'No value'
                    : widget.data!.jobPreference!.profileTitle,
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
                text: widget.data!.jobPreference!.preferredLocation
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
                text: widget.data!.jobPreference!.preferredRole!.length == 0
                    ? 'No value'
                    : widget.data!.jobPreference!.preferredRole
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
          //   text: widget.data.jobPreference.prefferefJobType == null
          //       ? 'No value'
          //       : widget.data.jobPreference.prefferefJobType,
          // ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Shift type -  ',
              ),
              Value(
                text: widget.data!.jobPreference!.shiftType == null
                    ? 'No value'
                    : widget.data!.jobPreference!.shiftType,
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
                text: widget.data!.jobPreference!.language!.length == 0
                    ? 'No value'
                    : widget.data!.jobPreference!.language
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
