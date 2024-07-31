import 'package:flutter/material.dart';
import 'package:manago_employer/provider/profile.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:provider/provider.dart';

class NotificationContainer extends StatefulWidget {
  final String? title;
  final String? date;
  final Color? color;
  final Function? ontap;

  const NotificationContainer({
    Key? key,
    this.title,
    this.date,
    this.color,
    this.ontap,
  }) : super(key: key);
  @override
  _NotificationContainerState createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap!(),
      child: Consumer<ProfileImage>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border.fromBorderSide(BorderSide(color: Colors.grey.shade200)),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/images/avatar.png',
              height: 50,
            ),
            title: Text(
              widget.title!,
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                widget.date!,
                style: TextStyle(fontSize: 12, color: Colors.orangeAccent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
