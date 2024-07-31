import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/models/SearchhCandidateModel.dart';
import 'package:manago_employer/services/SearchCandidateServices.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/CandidateDetails.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../views/bottom_navigation/search_candidate.dart';
import 'Search_Candidate_Controller.dart';

class SearchCandidateResults extends StatefulWidget {
  const SearchCandidateResults(
      {Key? key,
      this.name,
      this.mobile,
      this.aadhar,
      this.designation,
        this.cities,
      //this.cities,
      this.keySkills,
      this.minExp,
      this.maxExp})
      : super(key: key);

  final String? name;
  final String? mobile;
  final String? aadhar;
  //final String? designation;
 final List<String>?designation;
  final List<String>? cities;
  final List<String>? keySkills;
  final int? maxExp;
  final int? minExp;

  @override
  _SearchCandidateResultsState createState() => _SearchCandidateResultsState();
}

class _SearchCandidateResultsState extends StateMVC<SearchCandidateResults> {
  SearchCandidateController? _con;
  _SearchCandidateResultsState() : super(SearchCandidateController()) {
    _con = controller as SearchCandidateController?;
  }

  List<SeachCandidateModelDatum> searchCandidateData = [];

  ScrollController? _scrollController;

  bool? _isLastPage;
  int? _pageNumber;

  @override
  void initState() {
    super.initState();
    _pageNumber = 0;
    _isLastPage = false;
    _scrollController = ScrollController();
    fetchData();
  }

  Future<void> fetchData() async {
    _con!.searchCandidateV2(
        context,
        widget.name!,
        widget.mobile!,
        widget.aadhar!,
        widget.designation!,
        widget.cities!,
        widget.keySkills!,
        widget.maxExp!,
        widget.minExp!,
        page: _pageNumber!);
    _pageNumber = _pageNumber! + 1;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listenToScroll();
    return SafeArea(
        child: Scaffold(
            key: _con!.scaffoldKey,
            backgroundColor: Colors.white,
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
                'Searched Candidate',
                style: TextStyle(color: kPrimaryColor),
              ),
              actions: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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

                    child: Icon(Icons.search,size: 30,color: Colors.black54,)),
                // IconButton(icon: Icon(
                //   Icons.search,
                //   size: 30,
                //   color: Colors.black54,
                // ),
                //   onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SearchCandidate())) ; },),
                //
                SizedBox(width: 10,),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: _con!.searchCandidateData == null ||
                      _con!.searchCandidateData.isEmpty
                  ? Container(
                      child: Center(
                        child: Text('No Records Found'),
                      ),
                    )
                  : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _openDialog,
                            child: Container(
                              height: 32,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(children: [
                                Icon(
                                  Icons.flip_camera_android_rounded,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'Sort',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: kBlueGrey,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: buildSearchResults()),
                    ],
                  ),
            )));
  }

  void listenToScroll() {
    _scrollController!.addListener(() {
      // nextPageTrigger will have a value equivalent to 80% of the list size.
      var nextPageTrigger = 0.8 * _scrollController!.position.maxScrollExtent;

      // _scrollController fetches the next paginated data when the current postion of the user on the screen has surpassed
      if ((_scrollController!.position.pixels > nextPageTrigger) &&
          _con!.stopLoading == false &&
          (_con!.pagenatedData != null || _con!.pagenatedData.isNotEmpty)) {
        fetchData();
      }
    });
  }

  Widget buildSearchResults() {
    if (_con!.searchCandidateData.isNotEmpty) {
      searchCandidateData.clear();
      searchCandidateData.addAll(_con!.searchCandidateData);
    }
    // setState(() {});
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: searchCandidateData.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateDetails(
                    candidateData: searchCandidateData[index].id!,
                  ),
                ));
          },
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: kGreyColor),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 7),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                          text: searchCandidateData[index].personalInfo?.name ==
                                  null
                              ? 'Null'
                              : searchCandidateData[index].personalInfo!.name,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(height: 3),
                        Text(
                          searchCandidateData[index]
                                  .professionalInfo!
                                  .preferredFunction ??
                              '-',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            Text(
                              ' ${searchCandidateData[index].personalInfo?.city??"No city "}, ${searchCandidateData[index].personalInfo?.state??"No State"}',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
      },
    );
  }

  void _sortList(bool _ascending) {
    setState(() {
      if (_ascending) {
        _con!.searchCandidateData.sort((a, b) => a.personalInfo!.name!
            .compareTo(b.personalInfo!.name!));
      } else {
        _con!.searchCandidateData.sort((a, b) => b.personalInfo!.name!
            .compareTo(a.personalInfo!.name!));
      }
    });
  }

  bool _ascending = true;

  void _openDialog() {
    showDialog(
        context: context,
        builder: (_) => SortDialog(
          sortVal: _ascending,
          sort: (val) {
            _ascending = val;
            _sortList(val);
            setState(() {});
          },
        ));
  }


}
class SortDialog extends StatefulWidget {
  const SortDialog({Key? key, this.sort, this.sortVal = true}) : super(key: key);
  final bool? sortVal;
  final Function? sort;

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  bool _ascending = true;

  @override
  void initState() {
    _ascending = widget.sortVal!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sort by"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _ascending = !_ascending;
              });
            },
            title: Text("Ascending"),
            leading: Radio(
              value: true,
              activeColor: kBlueGrey,
              groupValue: _ascending,
              onChanged: (value) {
                setState(() {
                  _ascending = value!;
                });
              },
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                _ascending = !_ascending;
              });
            },
            title: Text("Descending"),
            leading: Radio(
              activeColor: kBlueGrey,
              value: false,
              groupValue: _ascending,
              onChanged: (value) {
                setState(() {
                  _ascending = value!;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.sort!(_ascending);
            Navigator.of(context).pop();
          },
          child: Text("Sort"),
        ),
      ],
    );
  }
}