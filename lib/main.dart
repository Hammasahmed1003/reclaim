// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
// import 'package:reclaim/appServices/fcmtoken.dart';
// import 'package:reclaim/appServices/getRouteNames.dart';
// import 'package:reclaim/appServices/getRoutes.dart';
// import 'package:reclaim/firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//  await FirebaseDB.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     Get.put(UserController());

//     return ScreenUtilInit(
//         designSize: const Size(360, 690),
//         minTextAdapt: true,
//         splitScreenMode: true,
//         builder: (_, child) {
//           return GetMaterialApp(
//             title: 'Flutter Demo',
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               fontFamily: "Poppins",
//               useMaterial3: true,
//             ),
//             // home: OnboardingScreen()
//             getPages: AppPages.pages,
//             initialRoute:
//                 // GetRouteNames.BottomnavbarView

//                 GetRouteNames.SplashScreen,
//             //  const MyHomePage(title: 'Flutter Demo Home Page'),
//           );
//         });
//   }
// }

// new file

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
import 'package:reclaim/appServices/NotificationServices.dart';
import 'package:reclaim/appServices/getRouteNames.dart';
import 'package:reclaim/appServices/getRoutes.dart';
import 'package:reclaim/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.put(NotificationService()).init(); // Initialize NotificationService
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: "Poppins",
              useMaterial3: true,
            ),
            getPages: AppPages.pages,
            initialRoute: GetRouteNames.SplashScreen,
          );
        });
  }
}
