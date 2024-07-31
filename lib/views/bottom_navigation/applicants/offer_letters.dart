import 'package:flutter/material.dart';
import 'package:manago_employer/controllers/OfferLetterListController.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/bottom_navigation/more/offer_letters/view_offer_letter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class OfferLetters extends StatefulWidget {
  final String? id;

  const OfferLetters({Key? key, @required this.id}) : super(key: key);
  @override
  _OfferLettersState createState() => _OfferLettersState();
}

class _OfferLettersState extends StateMVC<OfferLetters> {
  OfferLetterListController? _con;

  _OfferLettersState() : super(OfferLetterListController()) {
    _con = controller as OfferLetterListController?;
  }

  @override
  void initState() {
    super.initState();
    _con!.getApplicantOfferLetter(widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _con!.scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Offer Letters'),
          ),
          body: _con!.applicantOfferLetterlist.length == 0
              ? Container(
                  child: Center(
                    child: Text('No offer letter Added.',
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
                    ),
                    itemCount: _con!.applicantOfferLetterlist.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewOfferLetter(
                                      id: _con!.applicantOfferLetterlist[index].id!,
                                    ))),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          'assets/images/ManagoLogo.png'),
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
                                                        .applicantOfferLetterlist[
                                                            index]
                                                        ?.employerId
                                                        ?.businessName ??
                                                    " ",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          ' (${_con!.applicantOfferLetterlist[index].joiningDate})',
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                      ))
                                                ]),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.pin_drop_outlined,
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(_con!.applicantOfferLetterlist[index].employerId?.city ?? " "),
                                              ),
                                            ],
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
                                                  _con!.applicantOfferLetterlist[index].designation!,
                                                  style: TextStyle(
                                                      color: Colors.brown),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          size: 12,
                                          color: kPurple,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _con!.applicantOfferLetterlist[index]
                                                  ?.employerId?.email ??
                                              " ",
                                          style: TextStyle(color: kPurple),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          size: 12,
                                          color: kPurple,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _con!.applicantOfferLetterlist[index].employerId?.mobile ??
                                              " ",
                                          style: TextStyle(color: kPurple),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                )),
    );
  }
}
