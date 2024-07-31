import 'package:flutter/material.dart';
import 'package:manago_employer/components/applicant_detail/subheading.dart';
import 'package:manago_employer/components/applicant_detail/value.dart';
import 'package:manago_employer/models/ApplicantDetailModel.dart';

import 'resume.dart';

class UploadedDocuments extends StatefulWidget {
  final ApplicantsDetailsData? data;
  const UploadedDocuments({Key? key, this.data}) : super(key: key);

  @override
  State<UploadedDocuments> createState() => _UploadedDocumentsState();
}

class _UploadedDocumentsState extends State<UploadedDocuments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Subheading(
            subheading: 'Resume - ',
          ),
          InkWell(
            onTap: () {},
            child: Value(
              text: 'resume_file_name.pdf',
            ),
          ),
        ],
      ),
    );
  }
}
