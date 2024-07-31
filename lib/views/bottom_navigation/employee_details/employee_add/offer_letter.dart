// import 'package:flutter/material.dart';
// import 'package:manago_employer/components/reusable_button.dart';
// import 'package:manago_employer/components/reusable_dropDown.dart';
// import 'package:manago_employer/components/reusable_textField.dart';
// import 'package:manago_employer/controllers/applicants.dart/offer_letter_controller.dart';
// import 'package:manago_employer/utils/color_constants.dart';
// import 'package:manago_employer/utils/date_picker.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';

// class OfferLetter extends StatefulWidget {
//   final String candidateId;

//   const OfferLetter({Key key, this.candidateId}) : super(key: key);
//   @override
//   _OfferLetterState createState() => _OfferLetterState();
// }

// class _OfferLetterState extends StateMVC<OfferLetter> {
//   OfferLetterController _con;

//   _OfferLetterState() : super(OfferLetterController()) {
//     _con = controller;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _con.getEmployeeList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Add Offer Letter'),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ReusableDropDown(
//                   hintText: 'Select Employee',
//                   items: _con.employeeNamesList,
//                   onSelected: (value) {
//                     setState(() {
//                       _con.employee = value;
//                       _con.getEmployeeId(value);
//                     });
//                   },
//                   value: _con.employee,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   readOnly: true,
//                   onTap: () async {
//                     DateTime dob = await DatePickerClass.selectDate(context);
//                     if (dob != null) {
//                       _con.joiningDate =
//                           DatePickerClass.dateFormatterMethod(dob);
//                     }
//                     setState(() {});
//                   },
//                   onChanged: (value) => _con.joiningDate = value,
//                   style: TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     hintText: _con.joiningDate == null
//                         ? 'Joining Date'
//                         : _con.joiningDate,
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: kPurple,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: kPurple,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   maxLines: 3,
//                   onChanged: (value) => _con.description = value,
//                   style: TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     hintText: 'Description',
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: kPurple,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: kPurple,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ReusableTextField(
//                   hintText: 'Designation',
//                   onChanged: (value) => _con.designation,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   onChanged: (value) => _con.salary = value,
//                   style: TextStyle(fontSize: 18),
//                   decoration: InputDecoration(
//                     prefixText: '₹  ',
//                     prefixStyle:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     hintText: 'Offered Salary',
//                     contentPadding:
//                         EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: kPurple,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: kPurple,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ReusableButton(
//                   onPressed: () {
//                     _con.addOfferLetter(context);
//                   },
//                   title: 'Submit',
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
