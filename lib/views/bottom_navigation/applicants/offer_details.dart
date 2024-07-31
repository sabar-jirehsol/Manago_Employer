import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/controllers/applicants.dart/offer_letter_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/date_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:intl/intl.dart';

class OfferDetails extends StatefulWidget {
  final String? id;
  final String? candidateId;
   final String? name;
   final String? designation;

  const OfferDetails({Key? key, this.id, this.candidateId,this.name,this.designation}) : super(key: key);
  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

class _OfferDetailsState extends StateMVC<OfferDetails> {
  OfferLetterController? _con;
  _OfferDetailsState() : super(OfferLetterController()) {
    _con = controller as OfferLetterController?;

  }

  @override
  void initState() {
    super.initState();
    _con!.designation=widget.designation;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offer Letter'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                initialValue:widget.name,
                //onChanged: (value) => _con!.offeredGrossSalary = value,//value as int?,
                style: TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'name',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                readOnly: true,
                //Todo 26-04-2024 i commented below because it has  some year range that restrict user input
                // onTap: () async {
                //   DateTime? dob = await DatePickerClass.selectDate(context,
                //       firstDate: DateTime.now(),
                //       lastDate: DateTime(DateTime.now().year + 1));
                //   if (dob != null) {
                //     _con!.joiningDate = DatePickerClass.dateFormatterMethod(dob);
                //   }
                //   setState(() {});
                // },

                onTap: () async {
                  DateTime? dob = await DatePickerClass.selectDate(context);
                  if (dob != null) {
                    _con!.joiningDate = DatePickerClass.dateFormatterMethod(dob);
                  }
                  setState(() {
                    _con!.Appoffjoindate=false;
                  });
                },
                onChanged: (value) => _con!.joiningDate = value,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: _con!.joiningDate == null
                      ? 'Joining Date'
                      : _con!.joiningDate,
                  suffixIcon: IconButton(icon: Icon(Icons.calendar_today),



                    //Todo 26-04-2024 i commented below because it has  some year range that restrict user input
                    //   onPressed: () async {
                    //                DateTime? dob = await DatePickerClass.selectDate(context,
                    //              firstDate: DateTime.now(),
                    //         lastDate: DateTime(DateTime.now().year + 1));
                    //           if (dob != null) {
                    //         _con!.joiningDate = DatePickerClass.dateFormatterMethod(dob);
                    //            }
                    //         setState(() {});
                    //
                    //
                    // },


                    //todo 26-4-24 i added below
                    onPressed: () async {
                      DateTime? dob = await DatePickerClass.selectDate(context);
                      if (dob != null) {
                        _con!.joiningDate = DatePickerClass.dateFormatterMethod(dob);
                      }
                      setState(() {
                        _con!.Appoffjoindate=false;
                      });
                    },



                  ),
                  //labelText: 'Joining Date',

                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ), _con!.Appoffjoindate?errorText('Joining date is required.'):const SizedBox(),

              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: Key("od${widget.designation}"),
                controller: TextEditingController(text: widget.designation), // Set default value
                onChanged: (value) {
                  setState(() {
                    _con!.Appoffdesignation = false;
                    _con!.designation = value;
                  });
                },
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  labelText: 'Designation',
                  hintText: 'Designation',
                  contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

           //    TextFormField(
           //     // initialValue: widget.designation,
           // controller: TextEditingController(text:widget.designation ),
           //      onChanged: (value) {
           //
           //        setState(() {  _con!.Appoffdesignation=false;});
           //      _con!.designation = value;
           //
           //      },
           //      style: TextStyle(fontSize: 18),
           //      decoration: InputDecoration(
           //        labelText: 'Designation',
           //        hintText: 'Designation ',
           //        contentPadding:
           //        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
           //        enabledBorder: OutlineInputBorder(
           //            borderSide: BorderSide(
           //              color:  kGreyColor,
           //            ),
           //            borderRadius: BorderRadius.circular(10)),
           //        focusedBorder: OutlineInputBorder(
           //            borderSide: BorderSide(
           //              color:  kGreyColor,
           //            ),
           //            borderRadius: BorderRadius.circular(10)),
           //      ),
           //    ),
              _con!.Appoffdesignation?errorText("Designation is required."):const SizedBox(),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {_con!.Appoffsalary=false;});
                  _con!.offeredGrossSalary = value;},//value as int?,
                style: TextStyle(fontSize: 18),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(9)
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '₹  Offered Salary Per Anum',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ), _con!.Appoffsalary?errorText('Salary is required.and it should not be 0'):const SizedBox(),
              SizedBox(
                height: 20,
              ),
              //Salary Date
              TextField(
                maxLines: 4,
                onChanged: (value) {
                  setState(() { _con!.Appoffdescription=false;});
                  _con!.note = value;},
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Description',
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color:  kGreyColor,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              _con!.Appoffdescription?errorText("Description is Required."): const SizedBox(),
              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              ReusableButton(
                title: 'Save',
                onPressed: () {
                  setState(() { });
                  _con!.addOfferLetter(context, widget.id!, widget.candidateId!);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ApplicantDetails()));
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('$text', style: TextStyle(color: Colors.red)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

}
