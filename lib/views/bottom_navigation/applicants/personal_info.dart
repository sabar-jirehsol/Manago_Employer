import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/heading.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';

class PersonalInfoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Heading(
            heading: 'Personal Info',
          ),
          Subheading(
            subheading: 'Address',
          ),
          Value(
            text:
                'Qui elit voluptate labore cupidatat adipisicing amet ullamco magna incididunt duis velit. (Pincode)',
          ),
          Subheading(
            subheading: 'Date of birth',
          ),
          Value(
            text: '7 Jan 2020',
          ),
          Subheading(
            subheading: 'Marital Status',
          ),
          Value(),
          Subheading(
            subheading: 'Gender',
          ),
          Value(
            text: 'Male',
          ),
        ],
      ),
    );
  }
}
