import 'package:flutter/material.dart';
import 'package:manago_employer/models/search_job_model.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/job/job_detail_controller_view.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class FilterJobListView extends StatefulWidget {
  final String? appbarTitle;
  final List<Datum>? filteredUsers;

  const FilterJobListView({Key? key, this.filteredUsers, this.appbarTitle})
      : super(key: key);
  @override
  _FilterJobListViewState createState() => _FilterJobListViewState();
}

class _FilterJobListViewState extends StateMVC<FilterJobListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Jobs',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: widget.filteredUsers!.length == 0
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              border: Border.all(
                                color: Colors.orangeAccent,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            widget.filteredUsers!.length.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Jobs',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Expanded(
                        //   child: Container(
                        //     padding:
                        //         EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        //     child: SearchableDD(
                        //       validate: (city) {
                        //         if (city == null) {
                        //           return 'City is required';
                        //         }
                        //       },
                        //       hintText: 'Search for location',
                        //       label: 'Search for \nlocation',
                        //       items: ['Delhi', 'Agra', 'Gwalior'],
                        //       selectedItem: city,
                        //       onChanged: (value) {
                        //         city = value;
                        //       },
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    // SizedBox(
                    //   height: 10,
                    // ),

                    // TODO: Prefered Locations(chips(tags) , autocomplete)
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: AutoCompleteTextField(
                    //     key: null,
                    //     textChanged: (value) {
                    //       if (value.endsWith(',')) {
                    //         value = value.split(',').first;
                    //         setState(() {
                    //           chipList.add(value);
                    //           textController.clear();
                    //         });
                    //         value = null;
                    //       }
                    //     },
                    //     controller: textController,
                    //     style: TextStyle(fontSize: 18, color: Colors.black),
                    //     decoration: InputDecoration(
                    //         contentPadding:
                    //             EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                    //         hintText: ' Select Job Category,',
                    //         enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.all(Radius.circular(10)),
                    //             borderSide: BorderSide(color: kOrange)),
                    //         focusedBorder: OutlineInputBorder(
                    //             borderSide: BorderSide(color: kOrange),
                    //             borderRadius: BorderRadius.circular(10))),
                    //     itemSubmitted: (item) {
                    //       setState(() {
                    //         chipList.add(item);
                    //       });
                    //     },
                    //     suggestions: ['flutter', 'firebase'],
                    //     itemBuilder: (context, item) {
                    //       return Container(
                    //         padding: EdgeInsets.all(10),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               item,
                    //               style: TextStyle(fontSize: 12),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //     itemSorter: (a, b) {
                    //       return a.compareTo(b);
                    //     },
                    //     itemFilter: (item, query) {
                    //       return item.toLowerCase().startsWith(query.toLowerCase());
                    //     },
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: chipList.isEmpty
                    //       ? Container()
                    //       : Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 10),
                    //           child: Wrap(
                    //             runSpacing: 6,
                    //             spacing: 6,
                    //             children:
                    //                 List<Widget>.generate(chipList.length, (index) {
                    //               return Chip(
                    //                 shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(20),
                    //                     side: BorderSide(color: Colors.black)),
                    //                 padding: EdgeInsets.all(8),
                    //                 // deleteIconColor: Colors.white,
                    //                 backgroundColor: Colors.grey.shade500,
                    //                 label: Text(
                    //                   chipList[index],
                    //                   style: TextStyle(
                    //                       color: Colors.white, fontSize: 12),
                    //                 ),
                    //                 onDeleted: () {
                    //                   setState(() {
                    //                     chipList.removeAt(index);
                    //                   });
                    //                 },
                    //               );
                    //             }),
                    //           ),
                    //         ),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    widget.filteredUsers!.length == 0
                        ? SizedBox(
                            height: 300,
                            child: Center(
                              child: Text(
                                'No Jobs',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            addAutomaticKeepAlives: true,
                            itemCount: widget.filteredUsers!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            JobdetailController(
                                          id: widget.filteredUsers![index].id!,
                                        ),
                                      ));
                                },
                                child: Card(
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text(
                                          widget.filteredUsers![index].jobTitle!,
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        height: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //first row
                                            Container(
                                              constraints:
                                                  BoxConstraints.expand(
                                                      width: 200),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  //TODO:Job category
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                maxWidth: 100),
                                                        child: Text(
                                                          'Job Category: ',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 3),
                                                        child: Icon(
                                                          Icons
                                                              .category_outlined,
                                                          size: 10,
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          widget.filteredUsers![index].designation!,
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  //TODO: work exp
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Work Exp: ',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 3),
                                                        child: Icon(
                                                          Icons.work,
                                                          size: 10,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${widget.filteredUsers![index].experience} yrs.',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  //TODO: salary
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Salary Offering: ',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '₹ ${widget.filteredUsers![index].salary}',
                                                          style: TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  )
                                                ],
                                              ),
                                            ),
                                            //last row
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              // constraints: BoxConstraints.expand(width: 100),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                        text: "Posted on: ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                            text: DatePickerClass.dateFormatterMethod(widget.filteredUsers![index].createdAt!),
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )
                                                        ]),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 3),
                                                    color: Colors.grey,
                                                    child: Text(
                                                      '${widget.filteredUsers![index].vaccancy} Apply',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                  ],
                ),
              ),
      ),
    );
  }
}
