import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/experience_letters_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/expereince_letter/view_experience_letter.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/view_offer_letter.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class ExperienceLetters extends StatefulWidget {
  final String? id;
  const ExperienceLetters({Key? key, @required this.id}) : super(key: key);

  @override
  _ExperienceLettersState createState() => _ExperienceLettersState();
}

class _ExperienceLettersState extends StateMVC<ExperienceLetters> {
  ExperienceLettersController? _con;

  _ExperienceLettersState() : super(ExperienceLettersController()) {
    _con = controller as ExperienceLettersController?;
  }
  @override
  void initState() {
    super.initState();
    // _con.getExperienceLetter(widget.id);
    _con!.getAllExperienceLetter(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _con!.scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Experience Letters'),
          ),
          body: _con!.experienceLetterList.length == 0
              ? Container(
                  child: Center(
                    child: Text('No experience letter.',
                        style: TextStyle(
                          fontSize: 18,
                          color: kPrimaryColor,
                        )),
                  ),
                )
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView.separated(
                    separatorBuilder: (context, int) => SizedBox(
                      height: 10,
                      child: Container(
                        color: Colors.grey.shade100,
                      ),
                    ),
                    itemCount: _con!.experienceLetterList.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewExpereinceLetter(
                                      id: _con!.experienceLetterList[index].id!,
                                    ))),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/add_image.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                                text: _con!
                                                    .experienceLetterList[index]
                                                    .candidateId!
                                                    .personalInfo!
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          ' (${_con!.experienceLetterList[index].joiningDate})',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 14))
                                                ]),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.work,
                                                size: 14,
                                                color: Colors.brown,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  _con!
                                                      .experienceLetterList[
                                                          index]
                                                      .designation!,
                                                  style: TextStyle(
                                                      color: Colors.brown),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                size: 12,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(_con!
                                                    .experienceLetterList[index]
                                                    .candidateId!
                                                    .personalInfo!
                                                    .mobile!),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Icon(
                                //           Icons.email,
                                //           size: 12,
                                //           color: kPurple,
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Text(
                                //           'prakaship78@gmail.com',
                                //           style: TextStyle(color: kPurple),
                                //         ),
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         Icon(
                                //           Icons.call,
                                //           size: 12,
                                //           color: kPurple,
                                //         ),
                                //         SizedBox(
                                //           width: 5,
                                //         ),
                                //         Text(
                                //           '9112131231231',
                                //           style: TextStyle(color: kPurple),
                                //         )
                                //       ],
                                //     )
                                //   ],
                                // ),
                              ],
                            )),
                      );
                    },
                  ),
                  // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // child: ListView.separated(
                  //   separatorBuilder: (context, int) => SizedBox(
                  //     height: 10,
                  //   ),
                  //   itemCount: _con!.offerLetterlist.length,
                  //   itemBuilder: (BuildContext context, index) {
                  //     return GestureDetector(
                  //       onTap: () => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ViewOfferLetter(
                  //                     id: _con!.offerLetterlist[index].id,
                  //                   ))),
                  //       child: Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Colors.grey.shade100),
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 10, vertical: 10),
                  //           child: Column(
                  //             children: [
                  //               Row(
                  //                 children: [
                  //                   CircleAvatar(
                  //                     radius: 30,
                  //                     backgroundColor: Colors.transparent,
                  //                     child: Image.asset(
                  //                         'assets/images/ManagoLogo.png'),
                  //                   ),
                  //                   SizedBox(
                  //                     width: 20,
                  //                   ),
                  //                   Expanded(
                  //                     child: Column(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                       children: [
                  //                         RichText(
                  //                           text: TextSpan(
                  //                               text:
                  //                                   "${_con!.offerLetterlist[index].employerId?.businessName}",
                  //                               style: TextStyle(
                  //                                   fontSize: 18,
                  //                                   fontWeight: FontWeight.bold,
                  //                                   color: Colors.black),
                  //                               children: [
                  //                                 TextSpan(
                  //                                     text:
                  //                                         ' (${_con!.offerLetterlist[index].joiningDate})',
                  //                                     style: TextStyle(
                  //                                       color: Colors.black54,
                  //                                     ))
                  //                               ]),
                  //                         ),
                  //                         Row(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.center,
                  //                           children: [
                  //                             Icon(
                  //                               Icons.pin_drop_outlined,
                  //                               size: 14,
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Expanded(
                  //                               child: Text(
                  //                                   "${_con!.offerLetterlist[index].employerId?.city}"),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         Row(
                  //                           children: [
                  //                             Icon(
                  //                               Icons.work,
                  //                               size: 14,
                  //                               color: Colors.brown,
                  //                             ),
                  //                             SizedBox(
                  //                               width: 5,
                  //                             ),
                  //                             Expanded(
                  //                               child: Text(
                  //                                 _con!.offerLetterlist[index]
                  //                                     .designation,
                  //                                 style: TextStyle(
                  //                                     color: Colors.brown),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.email,
                  //                         size: 12,
                  //                         color: kPurple,
                  //                       ),
                  //                       SizedBox(
                  //                         width: 5,
                  //                       ),
                  //                       Text(
                  //                         "${_con!.offerLetterlist[index].employerId?.email}",
                  //                         style: TextStyle(color: kPurple),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Row(
                  //                     children: [
                  //                       Icon(
                  //                         Icons.call,
                  //                         size: 12,
                  //                         color: kPurple,
                  //                       ),
                  //                       SizedBox(
                  //                         width: 5,
                  //                       ),
                  //                       Text(
                  //                         "${_con!.offerLetterlist[index].employerId?.mobile}",
                  //                         style: TextStyle(color: kPurple),
                  //                       )
                  //                     ],
                  //                   )
                  //                 ],
                  //               ),
                  //             ],
                  //           )),
                  //     );
                  //   },
                  // ),
                )),
    );
  }
}
