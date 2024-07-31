import 'package:flutter/material.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/models/SubscriptionModel.dart';
import 'package:manago_employer/utils/color_constants.dart';

class ActivePlanCard extends StatelessWidget {
  final Subscription? subscription;
  final List<Subscription>? exceptsubscriptions;

  const ActivePlanCard({Key? key, this.subscription, this.exceptsubscriptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 225,
            margin: const EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(
                  'Active Plan',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 18.0),
                ),
                SizedBox(height: 10),
                Text("subname",
                  //subscription!.planname!,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "sub-amount",
                    //subscription!.amount!,
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                SizedBox(height: 30),
                Text('Next Billing Date',
                    style: new TextStyle(
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        color: Colors.white)),
                SizedBox(height: 14),
                Text('todo sub end date',
                    style: new TextStyle(fontSize: 16.0, color: Colors.white)),
                SizedBox(height: 24),
                Center(
                  child: Container(
                    width: 130,
                    height: 38,
                    child: ReusableButton(
                      onPressed: () {},
                      title: 'Cancel',
                      fontSize: 16,
                      buttonColor: Colors.white,
                      textColor: kPrimaryColor,
                    ),
                  ),
                ),
              ],
            )),


        //TODO   i added  below 22.01.2024 by me


        SizedBox(height: 20), // Adjust this value as needed
        // Horizontal view of exceptsubscriptions
        exceptsubscriptions != null
            ? Container(
                height: 100, // Adjust this value as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: exceptsubscriptions!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(exceptsubscriptions![index].planName!),
                        ),
                        SizedBox(height: 20), // Adjust this value as needed
                        // Upgrade Button
                        Container(
                          width: 130,
                          height: 38,
                          child: ReusableButton(
                            onPressed: () {},
                            title: 'Upgrade',
                            fontSize: 16,
                            buttonColor: Colors.white,
                            textColor: kPrimaryColor,
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            : SizedBox.shrink(),

      ],
    );
  }
}
