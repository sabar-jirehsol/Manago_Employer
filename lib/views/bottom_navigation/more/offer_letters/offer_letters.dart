//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/OfferLetterListController.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/AddOfferLetter.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/view_offer_letter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OfferLetters extends StatefulWidget {
  @override
  _OfferLettersState createState() => _OfferLettersState();
}

class _OfferLettersState extends StateMVC<OfferLetters> {
  OfferLetterListController? _con;
  _OfferLettersState() : super(OfferLetterListController()) {
    _con = controller as OfferLetterListController?;

  }
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _con!.getOfferLetter(context);



  }







  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
            'Offer Letters',
            style: TextStyle(color: kPrimaryColor),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddOfferLetter(),
                    ));
                _con!.getOfferLetter(context);
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
        body: _con!.offerLetterlist.length == 0
            ? Container(
                child: Center(
                  child: Text(
                    'No offer letter added',
                    style: TextStyle(fontSize: 18, color: kPrimaryColor),
                  ),
                ),
              )
            : RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh:() async {
            await   _con!.getOfferLetter(context);
            // Replace this delay with the code to be executed during refresh
            // and return a Future when code finishes execution.
            return Future<void>.delayed(const Duration(seconds: 1));
          },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView.separated(
                    separatorBuilder: (context, int) => SizedBox(
                      height: 1,
                      child: Container(color: Colors.white),
                    ),
                    itemCount: _con!.offerLetterlist.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: ()async{
                          await  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewOfferLetter(
                                      id: _con!.offerLetterlist[index].id!,
                                    )));
                          await _con!.getOfferLetter(context);
                          _refreshIndicatorKey.currentState?.show();
                          },
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
                                        text: _con!.offerLetterlist[index]
                                            .candidateId!.personalInfo!.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(height: 3),
                                      Text(
                                        '${_con!.offerLetterlist[index].designation}',
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
                                            '${_con!.offerLetterlist[index].candidateId!.personalInfo!.dial_code??" "} ${_con!.offerLetterlist[index].candidateId!.personalInfo!.mobile}',
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
                                                            '${_con!.offerLetterlist[index].joiningDate}',
                                   // 'todo',
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
      ),
    );
  }
}
