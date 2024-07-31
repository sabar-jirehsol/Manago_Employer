import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class EmployeeContainer extends StatelessWidget {
  final String? title;
  final String? head1;
  final String? value1;
  final String? head2;
  final String? value2;

  const EmployeeContainer(
      {Key? key, this.title, this.head1, this.value1, this.head2, this.value2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.grey.shade300,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 200,
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title!,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(head1!),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    value1!,
                    style: TextStyle(fontSize: 14, color: kPrimaryColor),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(head2!),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    value2!,
                    style: TextStyle(fontSize: 14, color: kPrimaryColor),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
