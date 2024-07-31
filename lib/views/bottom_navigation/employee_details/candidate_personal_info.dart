import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/heading.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';
import 'package:manago_employer/models/CandidateDetailsModel.dart';

class CandidatePersonalInfo extends StatelessWidget {
  final CandidateData? candidateData;

  const CandidatePersonalInfo({Key? key, this.candidateData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Heading(
              heading: 'Personal Info',
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Name -  ',
              ),
              Value(
                text: candidateData!.personalInfo!.name,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Email -  ',
              ),
              Value(
                text: candidateData!.personalInfo!.email,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Mobile No. -  ',
              ),
              Value(
                text: candidateData!.personalInfo!.mobile,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Address -  ',
              ),
              Expanded(
                child: Value(
                  text:
                      "${candidateData!.personalInfo!.address}, ${candidateData!.personalInfo!.city}, ${candidateData!.personalInfo!.state}",
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Date of birth -  ',
              ),
              Value(
                text: candidateData!.personalInfo!.dob,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Marital Status -  ',
              ),
              Value(
                text: candidateData!.personalInfo!.maritalStatus,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Subheading(
                subheading: 'Gender -  ',
              ),
              Value(
                text: candidateData!.personalInfo!.gender,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
