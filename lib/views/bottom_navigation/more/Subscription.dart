import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:flutter_multi_carousel/carousel.dart';
import 'package:manago_employer/api/ApiClient.dart';
import 'package:manago_employer/api/Resource.dart';
import 'package:manago_employer/api/api.dart';
import 'package:manago_employer/components/reusable_button.dart';
import 'package:manago_employer/components/subscription/active_subscription_plan.dart';
import 'package:manago_employer/components/subscription/available_plan_card.dart';
import 'package:manago_employer/models/LoginModel.dart';
import 'package:manago_employer/models/SubscriptionModel.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:ui' as ui;
import '../../controller_screen.dart';
import 'SubscriptionController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Webviewsubscribe.dart';
import 'notification.dart';

class MySubscription extends StatefulWidget {
  @override
  _MySubscriptionstate createState() => _MySubscriptionstate();
}

class _MySubscriptionstate extends StateMVC<MySubscription> {
  Mysubscriptioncontroller? _con;
  Data? data;

  _MySubscriptionstate() : super(Mysubscriptioncontroller()) {
    _con = controller as Mysubscriptioncontroller?;
  }

  List<String> planname = [
    'Plan1',
    'Plan2',
    'Plan3',

  ];
  String linkvalue = "";
  TextEditingController control = new TextEditingController();
  int k = 0;

  @override
  void initState() {
    super.initState();
    RenderErrorBox.backgroundColor = Colors.transparent;
    RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
    _con!.getsubscriptiondetails();

    // Timer(Duration(seconds: 3), () async{
    //   if(_con!.subscriptiondet.sub.isNotEmpty)
    //   {
    //     setState(() {
    //       Fluttertoast.showToast(msg: "Toast"+_con!.subscriptiondet.planlist[0].planid);
    //     });
    //   }
    //
    // });
    print("Yeah, this line is printed after 3 seconds");

    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }
  }

  List<String> imageUrls = [
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/10/23/20/40/landscape-4572804_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/10/23/20/40/landscape-4572804_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/10/23/20/40/landscape-4572804_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
  ];

  int _currentindex = 2;

  @override
  Widget build(BuildContext context) {
    // List<Widget> widgets = List.generate(
    //   10,
    //   (index) => Container(
    //     decoration: BoxDecoration(
    //         border: Border.all(
    //             color: _currentindex != index ? kPrimaryColor : Colors.white),
    //         borderRadius: const BorderRadius.all(
    //           Radius.circular(5.0),
    //         ),
    //         color: _currentindex == index ? kPrimaryColor : Colors.white),
    //     width: 350,
    //     // child: Image.network(
    //     //   imageUrls[index], //Images stored in assets folder
    //     //   fit: BoxFit.fill,
    //     // ),
    //   ),
    // );

    return WillPopScope(
        child: Scaffold(
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
                'Subscription Plan',
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(),
                          ));
                    },
                    icon: Image.asset(
                      'assets/images/bell.png',
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/add_image.png'),
                  ),
                ),
              ],
            ),
            body: _con!.subscriptiondet != null
                ? Container()
                :
             SingleChildScrollView(
                    child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        _con!.subscriptiondet![0].subscriptions!.isEmpty
                            ? "Choose Your Plan"
                            : 'You are a Member!',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                      _con!.subscriptiondet![0].subscriptions!.isEmpty ?
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 52),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: kSubtitleText),
                              ),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "Available Plans",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                )),

                            _con!.subscriptiondet![0].plans!.length > 0
                                ? Container(
                                child: Column(
                                  children: [
                                    for (int m = 0;
                                    m < _con!.subscriptiondet![0].plans!
                                            .length;
                                    m++)
                                      AvailablePlanCard(
                                        plan: _con!.subscriptiondet![0].plans![m],
                                        subscriptions:_con!.subscriptiondet![0].subscriptions!,
                                        // plan: _con!.subscriptiondet![0].planlist![m],
                                        // subscriptions:_con!.subscriptiondet![0].sub!,
                                      )
                                  ],
                                ))
                                : Container(
                              child: Text("No plans available right now"),
                            ),
                          ],)

                          :Container(),
                    //TODO i commented below  lines on 8.1.2024 by me
                    //     Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 52),
                    //   child: Text(
                    //     'Congratulations! Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum.',
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //         color: kSubtitleText),
                    //   ),
                    // ),
                    //     Padding(
                    //       padding: EdgeInsets.all(20),
                    //         child: Container(
                    //         child: Column(children: [
                    //       for (int k = 0;
                    //           k < _con!.subscriptiondet!.sub!.length;
                    //           k++)
                    //         ActivePlanCard(
                    //             subscription: _con!.subscriptiondet!.sub![k],
                    //                                       ),
                    //       // ALL PLAN SECTION
                    //       SizedBox(
                    //         height: 20,
                    //       ),
                    //
                    //     ]),
                    //   ),
                    // )







                  ]))),
        onWillPop: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ControllerScreen()));
          return Future.value(true);
        });
  }

  void subscriptioncancel(String url, String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    final body = jsonEncode({"subscriptionId": id});
    Resource? _response = await ApiClient.buttonstatus(
        url: API.url + url, token: _token, requestData: body);

    Map<String, dynamic> mod = jsonDecode(_response!.data);

    String msg = mod['message'];

    Fluttertoast.showToast(msg: msg);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => super.widget));

    //    // Map<String, dynamic> map = json.decode(_response.data);
    //
    // ApiClient.buttonstatus(   url: API.url+url,token: _token  , requestData: body).then((value) async{
    //   if (value != null) {
    //
    //     setState(() {
    //       control.text =value.data.link;
    //
    //     });
    //   }
  }

  void createsubscription(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _token = _prefs.getString('token');
    final body = jsonEncode({"id": id});
    EasyLoading.show(status: 'Please wait ...');

    ApiClient.postgroupdata(
            url: API.createsubscription, token: _token, requestData: body)
        .then((value) async {
      if (value != null) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Webviewsubs(
                        id: value.data!.link!,
                      )));
        });
      }
    });
  }
}
