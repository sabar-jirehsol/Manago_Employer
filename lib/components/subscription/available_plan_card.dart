import 'package:flutter/material.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/models/SubscriptionModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'active_subscription_plan.dart';

class AvailablePlansCarousel extends StatelessWidget {
  final List<Plan>? planList;


  const AvailablePlansCarousel({Key? key, this.planList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController();

    return Column(
      children: [
        SizedBox(
          height: 250, // Adjust the height as needed
          child: PageView.builder(
            controller: controller,
            itemCount: planList?.length ?? 0,
            itemBuilder: (context, index) {
              final Plan? plan = planList?[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: AvailablePlanCard(plan: plan),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        AnimatedSmoothIndicator(
          activeIndex: 0,
          count: planList?.length ?? 0,
          effect: ExpandingDotsEffect(
            dotColor: Colors.grey,
            activeDotColor: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}

class AvailablePlanCard extends StatefulWidget {
  final Plan? plan;
  final List<Subscription>? subscriptions;



  const AvailablePlanCard({Key? key, this.plan,this.subscriptions}) : super(key: key);

  @override
  State<AvailablePlanCard> createState() => _AvailablePlanCardState();
}

class _AvailablePlanCardState extends State<AvailablePlanCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 21),
      decoration: BoxDecoration(
        color: kLightPurpleAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            widget.plan?.planName ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: 28),
          Text(
            widget.plan?.amountPerUnit ?? '',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: Container(
              width: 130,
              height: 38,
              decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ReusableButton(
                onPressed: () {

                  if (widget.subscriptions != null && widget.subscriptions!.isNotEmpty) {
                    int index = widget.subscriptions!.indexOf(widget.plan as Subscription);
                    if (index != -1) {

                      List<Subscription> subscriptionsToSend = List.from(widget.subscriptions!);

                      // Extract the selected subscription
                      Subscription selectedSubscription = subscriptionsToSend[index];

                      // Create a new list without the selected subscription
                      List<Subscription> updatedSubscriptionsList = List<Subscription>.from(subscriptionsToSend);
                      updatedSubscriptionsList.removeAt(index);

                      // Now 'updatedSubscriptionsList' contains all subscriptions except the selected one

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivePlanCard(
                            subscription: widget.subscriptions![index],
                            exceptsubscriptions:updatedSubscriptionsList,
                          ),
                        ),
                      );
                    }
                  }



                },
                title: 'Choose',
                fontSize: 12,
                buttonColor: Colors.white,
                textColor: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
