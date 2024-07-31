import 'package:flutter/material.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/slide_dot.dart';
import 'package:manago_employer/components/slide_item.dart';
import 'package:manago_employer/controllers/walkThrough_controller.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/views/intro_screen/login_screen.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class WalkThroughScreen extends StatefulWidget {
  static const String id = 'walkThrough_screen_id';
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends StateMVC<WalkThroughScreen> {
  WalkThroughController? _con;
  _WalkThroughScreenState() : super(WalkThroughController()) {
    _con = controller as WalkThroughController?;
  }

  @override
  void dispose() {
    _con!.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _con!.pageController,
            onPageChanged: _con!.onPageChange,
            itemCount: _con!.slideList.length,
            itemBuilder: (context, index) {
              return SlideItem(
                pageList: _con!.slideList,
                selectedPageIndex: index,
              );
            },
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0; i < _con!.slideList.length; i++)
                      if (i == _con!.currentPage)
                        SlideDots(
                          isActive: true,
                        )
                      else
                        SlideDots(
                          isActive: false,
                        )
                  ],
                ),
                FloatingActionButton(
                  backgroundColor: kBlueGrey,
                  onPressed: _con!.currentPage == 3
                      ? () {
                          _con!.moveToNextScreen(context);
                        }
                      : () {
                          _con!.pageController.animateToPage(
                              _con!.slideList.length - 1,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                        },
                  child: Text(_con!.currentPage == 3 ? 'Login' : 'Skip'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
