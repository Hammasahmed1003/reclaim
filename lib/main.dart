import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
import 'package:reclaim/appServices/getRouteNames.dart';
import 'package:reclaim/appServices/getRoutes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            // home: OnboardingScreen()
            getPages: AppPages.pages,
            initialRoute:
                // GetRouteNames.BottomnavbarView

                GetRouteNames.SplashScreen,
            //  const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}
