import 'package:get/get.dart';
import 'package:reclaim/CommonScreens/BottomNavBarView.dart';
import 'package:reclaim/MVC/Controllers/EveningRecollectControllers/EveningRecollectController.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/MVC/Views/AuthScreen/InAppPurchaseScreen.dart';
import 'package:reclaim/MVC/Views/AuthScreen/LoginScreen.dart';
import 'package:reclaim/MVC/Views/AuthScreen/OtpScreen.dart';
import 'package:reclaim/MVC/Views/AuthScreen/ProfileSetup.dart';
import 'package:reclaim/MVC/Views/AuthScreen/SignUpScreen.dart';
import 'package:reclaim/MVC/Views/AuthScreen/SurveyQuestions.dart';
import 'package:reclaim/MVC/Views/AuthScreen/WelcomeScreen.dart';
import 'package:reclaim/MVC/Views/Badges/BadgeScreen.dart';
import 'package:reclaim/MVC/Views/CommitmentScreen/AddCommitments.dart';
import 'package:reclaim/MVC/Views/CommitmentScreen/CommitmentScreen.dart';
import 'package:reclaim/MVC/Views/CommitmentScreen/CreateCommunityScreen.dart';
import 'package:reclaim/MVC/Views/CommitmentScreen/PostDetailScreen.dart';
import 'package:reclaim/MVC/Views/EditProfile/EditProfile.dart';
import 'package:reclaim/MVC/Views/HomeScreens/DetailLessonScreen.dart';
import 'package:reclaim/MVC/Views/MessageScreen/MessageScreen.dart';
import 'package:reclaim/MVC/Views/Notifications/NotificationScreen.dart';
import 'package:reclaim/MVC/Views/ProgressScreens/progresScreen.dart';
import 'package:reclaim/MVC/Views/RecollectFlowView/EveningRecollect.dart';
import 'package:reclaim/MVC/Views/SavedLesson/savedLesson.dart';
import 'package:reclaim/MVC/Views/SettingScreens/SettingScreen.dart';
import 'package:reclaim/MVC/Views/SplashScreen/SplashScreen.dart';
import 'package:reclaim/MVC/Views/helpScreen/HelpScreen.dart';
import 'package:reclaim/MVC/Views/onboardingScreen/onBoardingScreen.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: GetRouteNames.onBoardingScreen,
      transition: Transition.rightToLeft,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: GetRouteNames.LoginRoute,
      transition: Transition.rightToLeft,
      page: () => const Loginscreen(),
    ),
    GetPage(
      name: GetRouteNames.Signupscreen,
      transition: Transition.rightToLeft,
      page: () => const Signupscreen(),
    ),
    GetPage(
      name: GetRouteNames.Otpscreen,
      transition: Transition.rightToLeft,
      page: () => const Otpscreen(),
    ),
    GetPage(
      name: GetRouteNames.Profilesetup,
      transition: Transition.rightToLeft,
      page: () => const Profilesetup(),
    ),
    GetPage(
      name: GetRouteNames.BottomnavbarView,
      transition: Transition.rightToLeft,
      page: () => BottomnavbarView(),
    ),
    GetPage(
      name: GetRouteNames.SurveyQuestions,
      transition: Transition.rightToLeft,
      page: () => SurveyQuestions(),
    ),
    GetPage(
      name: GetRouteNames.MessageScreen,
      transition: Transition.rightToLeft,
      page: () => MessageScreen(),
    ),
    GetPage(
      name: GetRouteNames.SplashScreen,
      transition: Transition.rightToLeft,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: GetRouteNames.Settingscreen,
      transition: Transition.rightToLeft,
      page: () => const Settingscreen(),
    ),
    GetPage(
      name: GetRouteNames.Editprofile,
      transition: Transition.rightToLeft,
      page: () => const EditProfile(),
    ),
    GetPage(
      name: GetRouteNames.Commitmentscreen,
      transition: Transition.rightToLeft,
      page: () => const Commitmentscreen(),
    ),
    GetPage(
      name: GetRouteNames.Notificationscreen,
      transition: Transition.rightToLeft,
      page: () => const Notificationscreen(),
    ),
    GetPage(
      name: GetRouteNames.Detaillessonscreen,
      transition: Transition.rightToLeft,
      page: () => const Detaillessonscreen(),
    ),
    GetPage(
      name: GetRouteNames.Helpscreen,
      transition: Transition.rightToLeft,
      page: () => const Helpscreen(),
    ),
    GetPage(
      name: GetRouteNames.Badgescreen,
      transition: Transition.rightToLeft,
      page: () => const Badgescreen(),
    ),
    GetPage(
      name: GetRouteNames.Createcommunityscreen,
      transition: Transition.rightToLeft,
      page: () => const Createcommunityscreen(),
    ),
    GetPage(
      name: GetRouteNames.Savedlesson,
      transition: Transition.rightToLeft,
      page: () => Savedlesson(),
    ),
    GetPage(
      name: GetRouteNames.Addcommitments,
      transition: Transition.rightToLeft,
      page: () => Addcommitments(),
    ),
    GetPage(
      name: GetRouteNames.InAppPurchasesScreen,
      transition: Transition.rightToLeft,
      page: () => InAppPurchasesScreen(),
    ),
    GetPage(
      name: GetRouteNames.WelcomeScreen,
      transition: Transition.rightToLeft,
      page: () => WelcomeScreen(),
    ),
    // GetPage(
    //   name: GetRouteNames.Eveningrecollect,
    //   transition: Transition.rightToLeft,
    //   page: () => EveningRecollectScreen(),
    // ),
    GetPage(
      name: GetRouteNames.Eveningrecollect,
      page: () => EveningRecollectScreen(),
    ),
    // GetPage(
    //   name: GetRouteNames.PostDetailScreen,
    //   page: () => PostDetailScreen(post: CommunityPostModel(),),
    // ),

    GetPage(
      name: GetRouteNames.PostDetailScreen,
      transition: Transition.rightToLeft,

      page: () => PostDetailScreen(), // No need to pass model here
    ),
  ];
}
//
