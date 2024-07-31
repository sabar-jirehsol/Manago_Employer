import 'package:flutter/material.dart';
import 'package:manago_employer/components/rounded_reusable_button.dart';
import 'package:manago_employer/controllers/job/jobs_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/job/add_job.dart';
import 'package:manago_employer/views/bottom_navigation/job/job_detail_controller_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Jobs extends StatefulWidget {
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends StateMVC<Jobs> {
  JobsController? _con;
  bool isSearching = false;

  _JobsState() : super(JobsController()) {
    _con = controller as JobsController?;
  }


  @override
  void initState() {
    super.initState();
    _con!.getAllJobs(context);
    print("INIT __>JOBS");
    print('fliteredUsersLIst ${_con!.filteredUsers}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              height: 42,
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        keyboardType:TextInputType.visiblePassword,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.blueGrey,
                            ),
                            filled: true,
                            fillColor: kPrimaryColor.withOpacity(0.2),

                            hintText: 'Search by job title',
                            hintStyle: TextStyle(color: Colors.blueGrey),
                            contentPadding: EdgeInsets.only(top: 5),
                        ),

                        onChanged: (value) {
                          setState(() {
                            _con!.filteredUsers = _con!.jobList
                                .where((element) => (element.jobTitle!
                                        .toLowerCase()
                                        .contains(value) ||
                                    element.designation!
                                        .toLowerCase()
                                        .contains(value)))
                                .toList();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddJob()));
                      _con!.getAllJobs(context);
                    },
                    child: Container(
                      height: 32,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(children: [Icon(Icons.add), Text('New Job')]),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: _con!.filteredUsers.length == 0
                  ? Center(
                      child: Text(
                        'No Jobs',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kPurple),
                      ),
                    )
                  :  ListView.builder(
                      shrinkWrap: true,

                       physics:BouncingScrollPhysics() ,
                       //physics: NeverScrollableScrollPhysics(),
                      addAutomaticKeepAlives: true,
                      itemCount: _con!.filteredUsers.length,
                  itemBuilder: (context, index) {
                    if(_con!.filteredUsers != null && _con!.filteredUsers.isNotEmpty && index < _con!.filteredUsers.length)   {
                    return InkWell(
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => JobdetailController(
                            id: _con!.filteredUsers[index].id,
                          ),
                        ));
                        _con!.getAllJobs(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kGreyColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:200,

                                  child: Text(_con!.filteredUsers[index].jobTitle!,
                                      softWrap: false,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: kBlueGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: RoundedReusableButton(
                                      title:
                                      _con!.filteredUsers[index].isActive!
                                          ? 'Active'
                                          : 'InActive',
                                      fillColor:
                                      _con!.filteredUsers[index].isActive!
                                          ? kGreenColor.withOpacity(0.1)
                                          : kRedColor.withOpacity(0.1),
                                      borderColor:
                                      _con!.filteredUsers[index].isActive!
                                          ? kGreenColor
                                          : kRedColor,
                                      textColor:
                                      _con!.filteredUsers[index].isActive!
                                          ? kGreenColor
                                          : kRedColor,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: kBlueGrey,
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Container(
                                  width: 200,
                                  child: Text(
                                     // "${_con!.filteredUsers[index].state!.isNotEmpty ? _con!.filteredUsers[index].state![0] : 'Unknown'},${_con!.filteredUsers[index].city!.isNotEmpty ? _con!.filteredUsers[index].city![0] : 'Unknown'}",

                                       "${_con!.filteredUsers[index].city![0]},${_con!.filteredUsers[index].state![0]},${_con!.filteredUsers[index].country?[0]??"N/A"}",
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
                            SizedBox(height: 4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.access_time_filled,
                                  color: kBlueGrey,
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Posted : ${DatePickerClass.dateFormatterMethod(_con!.filteredUsers[index].createdAt!.toLocal())}",
                                  style: TextStyle(
                                      color: kBlueGrey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Divider(color: kGreyColor),
                            Text(
                              'Designation: ${_con!.filteredUsers[index].designation}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kBlueGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Work Experience: ${_con!.filteredUsers[index].experience}-${_con!.filteredUsers[index].maxexperience} Years',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: kBlueGrey,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,

                              children: [
                                Text(
                                  'Offered Salary: ₹ ${_con!.filteredUsers[index].salary}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: kBlueGrey,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right:15.0),
                                  child: Text(
                                    'Vacancy: ${_con!.filteredUsers[index].vaccancy}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: kRedColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    );} else{SizedBox();}
                  }


              ),
            )
          ],
        ),
      ),
    );
  }
}
