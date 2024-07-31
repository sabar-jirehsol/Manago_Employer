import 'package:flutter/material.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/utils/color_constants.dart';

class Services with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  TextEditingController jobApplicantController = TextEditingController();

// show search textfield
  showSearchTextfield(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          labelText: 'Search for jobs...',
                          labelStyle: TextStyle(
                              color: kPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: kPurpleAccent,
                    onPressed: () {},
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  // show search textfield
  showEmployeeTextfield(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          labelText: 'Search for employee...',
                          labelStyle: TextStyle(
                              color: kPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: kPurpleAccent,
                    onPressed: () {},
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  showJobapplicantTextfield(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextField(
                      controller: jobApplicantController,
                      decoration: InputDecoration(
                          labelText: 'Search for job applicant...',
                          labelStyle: TextStyle(
                              color: kPurpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                      style: TextStyle(
                          color: Colors.black,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  FloatingActionButton(
                    backgroundColor: kPurpleAccent,
                    onPressed: () {


                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
