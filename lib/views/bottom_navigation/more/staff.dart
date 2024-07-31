import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manago_employer/utils/color_constants.dart';

class Staff extends StatefulWidget {
  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Employee'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 250,
                      child: Text(
                        '14 Oct',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John D',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '#32145',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                        Text(
                          'Pune',
                          style: TextStyle(fontSize: 14, color: kPurpleAccent),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '₹ 50,000',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
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
