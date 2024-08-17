
import 'package:fluuslyadmin/Main%20Page/addprofile_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Authentication Page/Login_Page.dart';
import '../Authentication Page/OTPVerification_Screen.dart';
import '../Authentication Page/Otp_Screen.dart';
import '../Authentication Page/Signup_Page.dart';
import '../Authentication Page/Splash_Screen.dart';
import '../Authentication Page/welcomeback_Page.dart';
import '../BottomBar/Bottom_bar.dart';
import '../Main Page/Addnewtoilet_Page.dart';
import '../Main Page/BusinessDetails_Page.dart';
import '../Main Page/Message_page.dart';
import '../Main Page/Support_Page.dart';

class AppRoutes {
  static const String initial = '/';
  static const String WelcomebackPage = '/Welcomeback_Page';
  static const String signinpage = '/SigninPage_Screen';
  static const String signuppage = '/SignupPage_Screen';
  static const String otpscreen = '/otp_screen';
  static const String Otpverification_Screen = '/Otpverification_Screen';
  static const String BottomBarPage = '/BottomBar_Page';
  static const String AddprofilePage = '/Addprofile_Page';
  static const String SupportPage = '/Support_Page';
  static const String BusinessdetailsPage = '/Businessdetails_Page';
  static const String AddnewtoiletPage = '/Addnewtoilet_Page';
  static const String MessagePage = '/Message_Page';


  static final routes = [
    GetPage(
      name: initial,
      page: () => SplashScreen(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: WelcomebackPage,
      page: () => Welcomeback_Page(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: signinpage,
      page: () => LoginPage_Screen(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: signuppage,
      page: () => SignupPage_Screen(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: otpscreen,
      page: () => Otp_Screen(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: BottomBarPage,
      page: () => BottomBar_Page(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AddprofilePage,
      page: () => Addprofile_Page(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: BusinessdetailsPage,
      page: () => Businessdetails_Page(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: AddnewtoiletPage,
      page: () => Addnewtoilet_Page(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: Otpverification_Screen,
      page: () => OtpverificationScreen(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: SupportPage,
      page: () => Support_Page(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: MessagePage,
      page: () => Message_Page(),
      transitionDuration: Duration(milliseconds: 50),
      transition: Transition.leftToRightWithFade,
    ),
    // GetPage(
    //   name: SettingsPage,
    //   page: () => Settings_Page(),
    //   transitionDuration: Duration(milliseconds: 50),
    //   transition: Transition.leftToRightWithFade,
    // ),
    // GetPage(
    //   name: AccountSettings,
    //   page: () => Account_Settings(),
    //   transitionDuration: Duration(milliseconds: 50),
    //   transition: Transition.leftToRightWithFade,
    // ),
    // GetPage(
    //   name: ChangeResetPasswordScreen,
    //   page: () => ChangeResetPassword_Screen(),
    //   transitionDuration: Duration(milliseconds: 50),
    //   transition: Transition.leftToRightWithFade,
    // ),
    // GetPage(
    //   name: UpdateexistingScreen,
    //   page: () => Updateexisting_Screen(),
    //   transitionDuration: Duration(milliseconds: 50),
    //   transition: Transition.leftToRightWithFade,
    // ),
    // GetPage(
    //   name: LinkedaccountsScreen,
    //   page: () => Linkedaccounts_Screen(),
    //   transitionDuration: Duration(milliseconds: 50),
    //   transition: Transition.leftToRightWithFade,
    // ),
    // GetPage(
    //   name: NotificationScreen,
    //   page: () => Notification_Screen(),
    //   transitionDuration: Duration(milliseconds: 50),
    //   transition: Transition.leftToRightWithFade,
    // ),
    // GetPage(
    //   name: ToiletsdetalisScreen,
    //   page: () => ToiletsDetails_Screen(),
    //   transitionDuration: Duration(milliseconds: 50),
    //   transition: Transition.leftToRightWithFade,
    // ),

  ];
}
