import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manago_employer/provider/profile.dart';
import 'package:manago_employer/provider/services.dart';
import 'package:manago_employer/services/notificationService/NotificationHelper.dart';
import 'package:manago_employer/utils/color_constants.dart';
import 'package:manago_employer/utils/loader.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/filter_applicants.dart';
import 'package:manago_employer/views/bottom_navigation/applicants/profile_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/CandidateDetails.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/education_info_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/job_preference_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/personal_info_view.dart';
import 'package:manago_employer/views/bottom_navigation/employee_details/employee_add/professional_info_view.dart';
import 'package:manago_employer/views/controller_screen.dart';
import 'package:manago_employer/views/intro_screen/profile_completion.dart';
import 'package:manago_employer/views/intro_screen/profile_one_screen.dart';
import 'package:manago_employer/views/intro_screen/profile_two_screen.dart';
import 'package:manago_employer/views/intro_screen/login_screen.dart';
import 'package:manago_employer/views/intro_screen/verification_screen.dart';
import 'package:manago_employer/views/intro_screen/walkThrough_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/subscription/cancel_subscription.dart';
import 'services/notificationService/local_notification_service.dart';
import 'views/bottom_navigation/applicants/new_resume.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
    statusBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

  LocalNotificationService.inititalize();

  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
  bool isWalkThrough = _prefs.getBool('isWalkThrough') ?? false;
  bool isProfileSet = _prefs.getBool('isProfileSet') ?? false;

  runApp(Manago(
    isLoggedIn: isLoggedIn,
    isWalkThrough: isWalkThrough,
    isProfileSet: isProfileSet,
  ));
  Loader.configLoading();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

class Manago extends StatefulWidget {
  // This widget is the root of your application.
  final bool? isLoggedIn;
  final bool? isWalkThrough;
  final bool? isProfileSet;

  const Manago(
      {Key? key, this.isLoggedIn, this.isWalkThrough, this.isProfileSet})
      : super(key: key);
  @override
  _ProfileOneScreenState createState() => _ProfileOneScreenState();
}

class _ProfileOneScreenState extends State<Manago> {
  @override
  void initState() {
    super.initState();
    FirebaseAnalytics.instance.logEvent(name: 'app_start');
   NotificationService.getNotification();
    // NotificationService.addFCMtoken();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: MaterialApp(
        title: 'Manago Employer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         useMaterial3: false,
          primarySwatch: kPrimaryColor,
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: Colors.transparent,
          ),


          fontFamily: 'Jost',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        home: widget.isWalkThrough == false
            ? WalkThroughScreen()
            : widget.isLoggedIn == false
                ? LoginScreen()
                : widget.isProfileSet == false
                    ? ProfileCompletion()
                    : ControllerScreen(),
        builder: EasyLoading.init(),
        routes: {
          WalkThroughScreen.id: (_) => WalkThroughScreen(),
          LoginScreen.id: (_) => LoginScreen(),
          VerificationScreen.id: (_) => VerificationScreen(),
          ProfileOneScreen.id: (_) => ProfileOneScreen(),
          ProfileTwoScreen.id: (_) => ProfileTwoScreen(),
          PersonalInfoScreen.id: (_) => PersonalInfoScreen(),
          ProfessionalInfoScreen.id: (_) => ProfessionalInfoScreen(),
          EducationalInfoScreen.id: (_) => EducationalInfoScreen(),
          JobPreferenceScreen.id: (_) => JobPreferenceScreen(),
        },
      ),),
      providers: [
        ChangeNotifierProvider(create: (_) => Services(),),
        ChangeNotifierProvider<ProfileImage>(create: (context) => ProfileImage()),
      ],
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
}

  //
  // void gettoken(FirebaseMessaging message)async
  // {
  //
  //   String fcmtoken=await message.getToken();
  //   print("token:$fcmtoken");
  //
  //
  // }




