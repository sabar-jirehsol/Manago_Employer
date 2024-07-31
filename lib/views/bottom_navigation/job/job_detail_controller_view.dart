import 'package:flutter/material.dart';
import 'package:manago_employer/components/reusable_job_highlight.dart';
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/controllers/job/job_details_controller.dart';
import 'package:manago_employer/provider/services.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/job/Update_job.dart';
import 'package:provider/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'job_applicant.dart';
import 'applicant_details.dart';
import 'job_detail.dart';

class JobdetailController extends StatefulWidget {
  final String? id;

  const JobdetailController({Key? key, this.id}) : super(key: key);
  @override
  _JobdetailControllerState createState() => _JobdetailControllerState();
}

class _JobdetailControllerState extends StateMVC<JobdetailController> with SingleTickerProviderStateMixin {

  JobDetailsController? _con;
  _JobdetailControllerState() : super(JobDetailsController()) {
    _con = controller as JobDetailsController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.getJobDetails(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con!.scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kPrimaryColor.withOpacity(0.2),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: kPrimaryColor,
                )),
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Job Detail',
          style: TextStyle(color: kPrimaryColor),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateJob(
                        jobdetails: _con!.jobDetails!,
                      ),
                    ));
                _con!.getJobDetails(widget.id!);
              },
              icon: Container(
                color: kGreenColor.withOpacity(0.1),
                padding: EdgeInsets.all(2),
                child: Icon(
                  Icons.edit,
                  color: kGreenColor,
                ),
              )),
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirm Delete'),
                    content: Text('Are you sure you want to delete?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); // User canceled delete
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async{
                        await  _con!.deleteJob(_con!.jobDetails!.data!.id!, context);
                        },
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Container(
              color: kRedColor.withOpacity(0.1),
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.delete,
                color: kRedColor,
              ),
            ),
          )

        ],
      ),
      body: _con!.jobDetails == null
          ? Container()
          : ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kGreyColor)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //SizedBox(width: 2,),
                            Container(
                              width:200,
                              child: Text(_con!.jobDetails!.data!.jobTitle!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: kBlueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: RoundedReusableButton(
                                title: 'Active',
                                fillColor: kGreenColor.withOpacity(0.1),
                                borderColor: kGreenColor,
                                textColor: kGreenColor,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: kGreyColor),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              //mainAxisSize: MainAxisSize.min,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: kBlueGrey,
                                  size: 12,
                                ),
                               // SizedBox(width: 4),
                                Container(
                                  width: 200,

                                  child: Text(
                                    "${_con!.jobDetails!.data!.city![0]},${_con!.jobDetails!.data!.state![0]},${_con!.jobDetails!.data!.country![0]}",
                                    //"${_con!.jobDetails!.data!.location![0]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: kBlueGrey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),



                              ],
                            ),
                             ),
                          Padding(
                            padding: const EdgeInsets.only(right:15.0),
                            child: Text(
                              'Vacancy: ${_con!.jobDetails!.data!.vaccancy}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kRedColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time_filled,
                              color: kBlueGrey,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Posted : ${DatePickerClass.dateFormatterMethod(_con!.jobDetails!.data!.createdAt!.toLocal())}",
                              style: TextStyle(
                                  color: kBlueGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Designation: ${_con!.jobDetails!.data!.designation}',
                          style: TextStyle(
                              fontSize: 12,
                              color: kBlueGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Work Experience: ${_con!.jobDetails!.data!.minexperience}-${_con!.jobDetails!.data!.maxexperience} years',
                          style: TextStyle(
                              fontSize: 12,
                              color: kBlueGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Offered Salary: ₹ ${_con!.jobDetails!.data!.salary}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kBlueGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                            // Text(
                            //   'Vacancy: ${_con!.jobDetails!.data!.vaccancy}',
                            //   style: TextStyle(
                            //       fontSize: 12,
                            //       color: kRedColor,
                            //       fontWeight: FontWeight.w500),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: kBlueGrey,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            border: Border.all(color: kGreyColor)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 32),
                              Text('Job Description',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 16),
                              Text(_con!.jobDetails!.data!.description!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 32),
                            ]),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Applicants',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    addAutomaticKeepAlives: true,
                    itemCount: _con!.applicantsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: GestureDetector(
                          onTap: () async{
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApplicantDetails(
                                          data: _con!.applicantsList[index],
                                      profile_id: _con!.applicantsList[index].candidateId?.id,
                                        )));
                            await _con!.getJobDetails(widget.id!);

                          },
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: kGreyColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 7),
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/images/avatar.png',
                                      height: 50,
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                          text: _con!.applicantsList[index].candidateId!.personalInfo!.name == null
                                              ? 'Null'
                                              : _con!.applicantsList[index].candidateId!.personalInfo!.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        SizedBox(height: 3),
                                        Text(_con!.applicantsList[index].candidateId!.jobPreference!.prefferedRole!??"",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time_filled,
                                              color: kGreyColor,
                                              size: 12,
                                            ),
                                            Text(
                                                DateTime.now().difference(_con!.applicantsList[index].createdAt!).inDays==0?"Applied Today":
                                              ' Applied ${DateTime.now().difference(_con!.applicantsList[index].createdAt!).inDays} days ago',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: 12,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              ' ${_con!.applicantsList[index].candidateId!.personalInfo!.city}, ${_con!.applicantsList[index].candidateId!.personalInfo!.state},',


                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,

                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: kGreenColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6),
                                      child: Center(
                                        child: Text(
                                          '${_con!.applicantsList[index].status}',
                                          style: TextStyle(
                                              fontSize: 10, color: kGreenColor),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: kPrimaryColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
    );
  }
}
