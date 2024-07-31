import 'package:flutter/material.dart';
import 'package:manago_employer/components/unordered_list.dart';
import 'package:manago_employer/controllers/job/job_details_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class JobDetail extends StatefulWidget {
  final String? description;

  const JobDetail({Key? key, this.description}) : super(key: key);
  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends StateMVC<JobDetail> {
  JobDetailsController? _con;
  _JobDetailState() : super(JobDetailsController()) {
    _con = controller as JobDetailsController?;
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
              onPressed: () {},
              icon: Icon(
                Icons.edit,
                color: kGreenColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete,
                color: kRedColor,
              )),
        ],
      ),
      body: widget.description == null
          ? Container()
          : ListView(children: [
            
          ],)
          
          // DraggableScrollableSheet(
          //     initialChildSize: 0.9,
          //     builder: (BuildContext context, myscrollController) => Stack(
          //       children: [
          //         Column(
          //           children: [
          //             //job highlights
          //             // Card(
          //             //   margin: EdgeInsets.symmetric(
          //             //     horizontal: 10,
          //             //   ),
          //             //   elevation: 5,
          //             //   child: Container(
          //             //     margin: EdgeInsets.only(
          //             //       top: 10,
          //             //     ),
          //             //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //             //     child: Column(
          //             //       crossAxisAlignment: CrossAxisAlignment.start,
          //             //       children: [
          //             //         Padding(
          //             //           padding: const EdgeInsets.only(left: 10),
          //             //           child: Text(
          //             //             'Designation',
          //             //             style: TextStyle(
          //             //                 fontSize: 16, fontWeight: FontWeight.bold),
          //             //           ),
          //             //         ),
          //             //         SizedBox(
          //             //           height: 10,
          //             //         ),
          //             //         ReusableJobHighlight(
          //             //           text: '0 - 4 Years',
          //             //           icon: Icons.work_outline_sharp,
          //             //         ),
          //             //         ReusableJobHighlight(
          //             //           text: '1 Vacancy',
          //             //           icon: Icons.person_add_outlined,
          //             //         ),
          //             //         ReusableJobHighlight(
          //             //           text: 'Pune',
          //             //           icon: Icons.location_on_outlined,
          //             //         ),
          //             //         ReusableJobHighlight(
          //             //           text: 'Not disclosed',
          //             //           icon: Icons.account_balance_wallet_outlined,
          //             //         ),
          //             //         ReusableJobHighlight(
          //             //           text: 'Automatic testing, Javascript',
          //             //           icon: Icons.power_input_sharp,
          //             //         )
          //             //       ],
          //             //     ),
          //             //   ),
          //             // ),
          //             //Job description
          //             Card(
          //               margin:
          //                   EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //               elevation: 5,
          //               child: Container(
          //                 margin: EdgeInsets.only(top: 10),
          //                 padding: EdgeInsets.symmetric(
          //                     horizontal: 10, vertical: 10),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.only(left: 10),
          //                       child: Text(
          //                         'Job Description',
          //                         style: TextStyle(
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       height: 10,
          //                     ),
          //                     UnorderedList([
          //                       // 'Design, build and maintain efficient, reusable and relliable Vue.js code',
          //                       // 'Writting Clean, maintainable and efficient code',
          //                       // 'Help maintain code quality, organization and automatization',
          //                       // 'Developing user-facing applications using Vue.js.',
          //                       // 'Building modular and reusable components'
          //                       widget.description
          //                     ]),
          //                     SizedBox(
          //                       height: 20,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
    
    );
  }
}
