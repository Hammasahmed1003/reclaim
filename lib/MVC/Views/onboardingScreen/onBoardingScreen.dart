import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reclaim/MVC/Views/AuthScreen/LoginScreen.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': Reclaimimages.onboardingFirstImage, // Replace with your image path
      'title': 'Reclaim Your Life.',
      'subtitle': 'Start your journey to freedom.',
    },
    {
      'image': Reclaimimages.onboardingSecond,
      'title': 'Tools & Support.',
      'subtitle': 'Achieve more with less distractions.',
    },
    {
      'image': Reclaimimages.onboardingThird,
      'title': 'Your Plan / Privacy',
      'subtitle': 'Take the first step towards growth.',
    },
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
     
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Loginscreen()),
      // );
        Get.toNamed(GetRouteNames.LoginRoute);
    }
  }


  void previousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicWhite,
        systemNavigationBarColor: Reclaimcolors.BasicWhite
      ) ,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! < 0) {
              nextPage(); // Swipe left to go forward
            } else if (details.primaryVelocity! > 0) {
              previousPage(); // Swipe right to go back
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (widget, animation) => FadeTransition(opacity: animation, child: widget),
                  child: Image.asset(
                    onboardingData[currentIndex]['image']!,
                    key: ValueKey(currentIndex),
                  ),
                ),
              ),
      
              const    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onboardingData.length, (index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: currentIndex == index ? 24 : 15,
                          height: 8,
                          decoration: BoxDecoration(
                            color: currentIndex == index ? Reclaimcolors.BasicBlue: Reclaimcolors.BasicBlue.withOpacity(.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }),
                    ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   const SizedBox(height: 50,),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        onboardingData[currentIndex]['title']!,
                        key: ValueKey(currentIndex),
                        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, 
                        color: Reclaimcolors.BasicBlack
                        ),
                      ),
                    ),
                   const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: Text(
                        onboardingData[currentIndex]['subtitle']!,
                        key: ValueKey(currentIndex),
                       style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300, 
                        color: Reclaimcolors.BasicBlack),
                      ),
                    ),
                
                  // const  SizedBox(height: 20),
              const    Spacer(),
                   GestureDetector(
                      onTap: nextPage,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Reclaimcolors.BasicBlue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child:
                         Center(
                          child: SvgPicture.asset(ReclaimIcon.nextIcon, 
                          ),
                        ),
                      ),
                    ),
               const SizedBox(height: 20,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BlueSecondary,
      ),
      child: Scaffold(
        body:  Container(
          decoration: const    BoxDecoration(
            gradient: LinearGradient(
              colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          child: const Center(child: Text('Next Screen'))), // Replace with actual content
      ),
    );
  }
}