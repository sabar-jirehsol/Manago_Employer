import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/components/dashboard/employee_container.dart';
import 'package:manago_employer/controllers/dashboard_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/applicants.dart';
import 'package:manago_employer/views/bottom_navigation/search_candidate.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'job/applicant_details.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends StateMVC<DashBoard> {
  int flag = 0;
  dashboardController? _con;

  _DashBoardState() : super(dashboardController()) {
    _con = controller as dashboardController?;
  }

  @override
  void initState() {
    super.initState();

    _con!.getEmployeeList();
    _con!.getAllJobs(context);

    _con!.getApplicantsAgainstEmployer();

    _con!.getDashboardCount(context);
  }

  SharedPreferences? _prefs;
  String name = '';
  String profilepics='';

  getUserDetails() async {
    _prefs = await SharedPreferences.getInstance();
    name = _prefs!.getString('userName') ?? ' ';
    profilepics=_prefs!.getString('profilePic')??' ';
    if (mounted) setState(() {});
  }

  final pageController = PageController(keepPage: true);
  @override
  Widget build(BuildContext context) {
    getUserDetails();
    final pages = [
      FiguresCard(
        title: 'Jobs',
        label1: 'Posted',
        val1: '${_con!.dashbaordData?.allPostedJobs ?? '-'}',
        label2: 'This Week',
        val2: '${_con!.dashbaordData?.latestPosted ?? '-'}',
      ),
      FiguresCard(
        title: 'Employees',
        label1: 'Active',
        val1: '${_con!.dashbaordData?.activeEmployees ?? '-'}',
        label2: 'Offered',
        val2: '${_con!.dashbaordData?.offeredEmployees ?? '-'}',
      ),
      FiguresCard(
        title: 'Applicants',
        label1: 'Applicants',
        val1: '${_con!.dashbaordData?.allApplicants ?? '-'}',
        label2: 'This Week',
        val2: '${_con!.dashbaordData?.activeEmployees ?? '-'}',
      ),
    ];
    return SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi $name',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Find the best talent here',
                  style: TextStyle(color: kOrangeColor, fontSize: 14),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40)),
                      ),
                      backgroundColor: Colors.white,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.60-MediaQuery.of(context).viewInsets.bottom,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SearchCandidate(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                        color: klightGreyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search Candidate',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Container(
                          color: kPrimaryColor,
                          child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40)),
                                  ),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  isScrollControlled:true,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*0.60-MediaQuery.of(context).viewInsets.bottom,
                                       // height: MediaQuery.of(context).size.height*0.75,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: SearchCandidate(),
                                      ),
                                    );
                                  },
                                );

                              }),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Latest Figures',
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: pageController,
                    // itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages[index % pages.length];
                    },
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: SmoothPageIndicator(
                      controller: pageController,
                      count: pages.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: kPrimaryColor,
                          dotHeight: 12,
                          dotWidth: 12,
                          dotColor: kGreyColor.withOpacity(0.4))),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Applicants',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () =>
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Applicants())),


                      child: _con!.applicantsList == null ||
                              _con!.applicantsList.length == 0
                          ? Container()
                          : Text(
                              'VIEW ALL',
                              style: TextStyle(color: kOrangeColor),
                            ),
                    )
                  ],
                ),
                _con!.applicantsList == null || _con!.applicantsList.length == 0
                    ? Container(
                        child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('No Applicants',
                                style: TextStyle(fontSize: 15,color: Colors.black))
                          ],
                        ),
                      ))
                    : SizedBox(
                        height: 10,
                      ),
                _con!.applicantsList == null || _con!.applicantsList.isEmpty
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: true,
                        itemCount: _con!.applicantsList.length > 3
                            ? 3
                            : _con!.applicantsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async{
                              //     Fluttertoast.showToast(msg: _con!.applicantsList[index].employerId.mobile);
                             await  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ApplicantDetails(
                                            data: _con!.applicantsList[index],
                                        profile_id:_con!.applicantsList[index].candidateId?.id,
                                          )));
                             await _con!.getApplicantsAgainstEmployer();
                            },
                            child: Container(

                              //height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: kGreyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 7),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/avatar.png',
                                        height: 50,
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                            text: _con!
                                                        .applicantsList[index]
                                                        .candidateId!
                                                        .personalInfo!
                                                        .name ==
                                                    null
                                                ? 'Null'
                                                : _con!
                                                    .applicantsList[index]
                                                    .candidateId!
                                                    .personalInfo!
                                                    .name,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          SizedBox(height: 3),
                                          Container(
                                            width: 200,
                                            child: Text(
                                            // 'Job Title :  Restaurant Manager / Restaurant Operation Manager',
                                              'Job Title : ${_con!.applicantsList[index].jobId?.jobTitle??"jobTitle"}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.account_box,
                                                size: 14,
                                                color: Colors.grey,
                                              ),
                                              //_con!.applicantsList[index].candidateId?.professionalInfo?.jobDetails !=null?
                                              // Text(
                                              //   '₹ ${_con!.applicantsList[index].candidateId?.professionalInfo?.jobDetails?[0].salary??'salary'}',
                                              //   style: TextStyle(
                                              //       fontSize: 10,
                                              //       color: Colors.grey),
                                              // ):Text("No salary"),
                              (_con!.applicantsList[index].candidateId?.professionalInfo?.jobDetails ==null||
                                  _con!.applicantsList[index].candidateId?.professionalInfo?.jobDetails?.length==0)?Text("No salary")
                                              :Text(
                                                '₹ ${_con!.applicantsList[index].candidateId?.professionalInfo?.jobDetails?[0].salary??'salary'}',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),),
                                              SizedBox(width: 8),
                                              Icon(
                                                Icons.location_on,
                                                size: 14,
                                                color: Colors.grey,
                                              ), 
                                              Container(
                                                width: 120,
                                                child: Text(


                                                  '${_con!.applicantsList[index].candidateId!.personalInfo?.city??"city"}, ${_con!.applicantsList[index].candidateId!.personalInfo?.state??"state"}',
                                                  //' ${_con!.applicantsList[index].jobId!.city![0]}, ${_con!.applicantsList[index].jobId!.state![0]}',
                                                 maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                   // mainAxisAlignment: MainAxisAlignment.start,
                                    //mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        _con!.applicantsList[index].status??"status",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                      SizedBox(height: 35,),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: kPrimaryColor,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FiguresCard extends StatelessWidget {
  final String? title;
  final String? label1;
  final String? val1;
  final String? label2;
  final String? val2;

  const FiguresCard({
    Key? key,
    this.title,
    this.label1,
    this.val1,
    this.label2,
    this.val2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kLightPurpleAccent,
        ),
        height: 175,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/jobs.png',
                  color: kBlueGrey,
                  height: 45,
                ),
                SizedBox(height: 16),
                Text(
                  title!,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(width: 50),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label1!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    label2!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    val1!,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    val2!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ]),
          ],
        ));
  }
}
