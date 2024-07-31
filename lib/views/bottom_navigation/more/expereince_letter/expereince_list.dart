import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/ExperienceLetterListController.dart';
import 'package:manago_employer/controllers/expereince/add_expereince_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/expereince_letter/add_expereince.dart';
import 'package:manago_employer/views/bottom_navigation/more/expereince_letter/view_experience_letter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ExperienceList extends StatefulWidget {
  @override
  _ExperienceListState createState() => _ExperienceListState();
}

class _ExperienceListState extends StateMVC<ExperienceList> {
  ExperienceLetterListController? _con;
  _ExperienceListState() : super(ExperienceLetterListController()) {
    _con = controller as ExperienceLetterListController?;
  }
  @override
  void initState() {
    super.initState();
    _con!.getExperienceLetter();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        key: _con!.scaffoldKey,
        backgroundColor: Colors.grey.shade100,
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
            'Experience Letters',
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExpereince(),
                    ));
                _con!.getExperienceLetter();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Icon(
                    Icons.add,
                    color: kBlueGrey,
                  ),
                  Text(
                    'Add',
                    style: TextStyle(color: kBlueGrey),
                  )
                ]),
              ),
            )
          ],
        ),
        body:_con!.experienceLetterList.length==0?
        Container(child:Center(child: Text("No Experience Letter Added", style: TextStyle(
          fontSize: 18,
          color: kPrimaryColor,
        )),) ,)


        :Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.separated(
            separatorBuilder: (context, int) => SizedBox(
              height: 1,
              child: Container(color: Colors.white),
            ),
            itemCount: _con!.experienceLetterList.length,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewExpereinceLetter(
                              id: _con!.experienceLetterList[index].id!,
                            )));
                _con!.getExperienceLetter();},
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kBlueGrey),
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(
                                text: _con!.experienceLetterList[index]
                                    .candidateId!.personalInfo!.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(height: 3),
                              Text(
                                '${_con!.experienceLetterList[index].designation}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    '${_con!.experienceLetterList[index].candidateId!.personalInfo!.dial_code??" "} ${_con!.experienceLetterList[index].candidateId!.personalInfo!.mobile}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: kGreyColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff1E3852)),
                            color: const Color(0xff1E3852).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child: Text(
                              '${_con!.experienceLetterList[index].relivingDate}',
                            //'todo',
                            style: TextStyle(color: kBlueGrey, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
