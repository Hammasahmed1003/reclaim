// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';

// import 'package:lottie/lottie.dart';
// import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
// import 'package:reclaim/MVC/Controllers/AuthControllers/ProfileSetupController/SurveryController.dart';
// import 'package:reclaim/appConstants/ReclaimColors.dart';
// import 'package:reclaim/appServices/getRouteNames.dart';

// class SurveyQuestions extends StatefulWidget {
//   @override
//   _SurveyQuestionsState createState() => _SurveyQuestionsState();
// }

// class _SurveyQuestionsState extends State<SurveyQuestions> {
//     final SurveyController surveyController = Get.put(SurveyController());

//   PageController _pageController = PageController();
//   int _currentIndex = 0;
//   List<int?> _answers = List.filled(11, null); // Stores selected answers
//   bool _isSurveyCompleted = false;

//   void _nextPage() {
//     if (_answers[_currentIndex] != null) {
//       if (_currentIndex < _questions.length - 1) {
//         _pageController.nextPage(
//             duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
//       } else {
//         setState(() {
//           _isSurveyCompleted = true;
//         });
//       }
//     }
//   }

//   @override
// void initState() {
//   super.initState();
//   surveyController.fetchQuestions();
// }

//   @override
//   Widget build(BuildContext context) {

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Reclaimcolors.BasicWhite,
//         body: _isSurveyCompleted ? _buildProfileCompleted() : _buildSurvey(),
//       ),
//     );
//   }

//   Widget _buildSurvey() {
//     return Column(
//       children: [
//         _buildProgressBar(),
//         Expanded(
//           child: PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) => setState(() => _currentIndex = index),
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: _questions.length,
//             itemBuilder: (context, index) => _buildQuestion(index),
//           ),
//         ),
//         _buildContinueButton(),
//         SizedBox(height: 10.h),
//       ],
//     );
//   }

//   Widget _buildProgressBar() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: LinearProgressIndicator(
//           backgroundColor: Reclaimcolors.BlueSecondary,
//           color: Reclaimcolors.BasicBlue,
//           value: (_currentIndex + 1) / _questions.length),
//     );
//   }

//   Widget _buildQuestion(int index) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10.h),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               _questions[index]['question'],
//               style: TextStyle(
//                   fontSize: 25.sp,
//                   fontWeight: FontWeight.w800,
//                   color: Reclaimcolors.BasicBlue),
//             ),
//           ),
//           SizedBox(height: 40.h),
//           ...List.generate(_questions[index]['options'].length, (optionIndex) {
//             return _buildOption(index, optionIndex);
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildOption(int questionIndex, int optionIndex) {
//     bool isSelected = _answers[questionIndex] == optionIndex;
//     return GestureDetector(
//       onTap: () => setState(() => _answers[questionIndex] = optionIndex),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: AnimatedContainer(
//           width: 380.w,
//           height: 55.h,
//           duration: Duration(milliseconds: 300),
//           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: isSelected
//                 ? Reclaimcolors.BasicBlue
//                 : Reclaimcolors.BlueSecondary,
//             borderRadius: BorderRadius.circular(33),
//           ),
//           child: Center(
//             child: Text(
//               _questions[questionIndex]['options'][optionIndex],
//               style: TextStyle(
//                   fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
//                   color: isSelected ? Colors.white : Colors.black),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContinueButton() {
//     bool isDisabled = _answers[_currentIndex] == null;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
//       child: Container(
//         width: 380.w,
//         height: 55.h,
//         child: ElevatedButton(
//           onPressed: isDisabled ? null : _nextPage,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: isDisabled
//                 ? Reclaimcolors.BasicBlue.withOpacity(0.50)
//                 : Reclaimcolors.BasicBlue,
//             minimumSize: const Size(double.infinity, 50),
//           ),
//           child: Text(
//             "Continue",
//             style: TextStyle(
//               fontSize: 20.sp,
//               color: Reclaimcolors.BasicWhite,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileCompleted() {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Reclaimcolors.BlueSecondary,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//           colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
//           stops: [0, 1],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         )),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Lottie.asset(
//               'assets/animations/ProfileDoneInimation.json', // Replace with your actual Lottie file path

//               fit: BoxFit.cover,
//             ),
//             Text(
//               "Profile Completed 🎉",
//               style: TextStyle(
//                 fontSize: 25.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 "You're in good hands. Based on your responses, we'll create a journey tailored for you. Let's start Reclaiming your freedom today",
//                 style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             // SizedBox(height: 30.h,),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: ReclaimButton(
//                   titleColor: Reclaimcolors.BasicWhite,
//                   width: 370.w,
//                   height: 48.h,
//                   backgroundColor: Reclaimcolors.BasicBlue,
//                   title: "Log In",
//                   fontWeight: FontWeight.w600,
//                   onPressed: () {
//                     Get.offAllNamed(GetRouteNames.InAppPurchasesScreen);
//                   }),
//             ),
//             SizedBox(
//               height: 40.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// List<Map<String, dynamic>> _questions = [
//   {
//     'question': "Primary Goal in Using This App?",
//     'options': [
//       "Break free from porn addiction entirely",
//       "Reduce frequency and gain more control",
//       "Strengthen spiritual life while overcoming addiction",
//       "Seek community support and accountability"
//     ]
//   },

//   {
//     'question': "Lifestyle",
//     'options': [
//       "Weak faith, unstructured time, screens for comfort",
//       "Growing faith, no routine, Regular prayer, busy life, some tempting content ",
//       "  Daily prayer, structured routine, minimal tempting media",
//     ]
//   },
//   {
//     'question': "How Often Do You Typically Relapse?",
//     'options': [
//       "Multiple times per day",
//       "Daily",
//       "A few times a week",
//       "Weekly",
//       "Less than once a week",
//     ]
//   },
//   {
//     'question': "Has Your Frequency Increased Over Time? ",
//     'options': [
//       "Yes",
//       "No",
//     ]
//   },

//   {
//     'question':
//         "Do You Use Pornography to Cope with Stress Loneliness, or Emotional Discomfort?",
//     'options': [
//       "Frequently",
//       "Occasionally",
//       "Never",
//     ]
//   },

//   {
//     'question':
//         "What Time of Day Do you Typically Experience the Most Temptation?",
//     'options': ["Night", "Evening", "Morning", "Afternoon"]
//   },

//   {
//     'question': "Most Common Triggers?",
//     'options': [
//       "1 point per trigger selected",
//       "Max: 7 points",
//     ]
//   },

//   {
//     'question': "Who Knows About Your Struggle and Supports You?",
//     'options': [
//       "No one—I’m doing this alone",
//       "A close friend or family member",
//       "A spiritual leader or mentor",
//       "Other (specify)"
//     ]
//   },

//   {
//     'question': "Has Pronography Negatively Affected Your Relationships?",
//     'options': ["Yes, significantly", "Somewhat", "Not much", "No impact"]
//   },

//   {
//     'question':
//         "How Often Do You Feel Like Pornography Is Holding You Back From Your Full Potential?",
//     'options': ["Almost always", "Often", "Sometimes", "Rarely)"]
//   },

//   {
//     'question':
//         "Have You Experienced Any Sexual Dysfunctions (e.g: ED or Difficulty with Arousal)?",
//     'options': [
//       "Yes",
//       "Not Sure",
//       "No",
//     ]
//   },

//   // Add more questions here...
// ];

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/ProfileSetupController/SurveryController.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/ProfileSetupController/profileSetupController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

class SurveyQuestions extends StatefulWidget {
  @override
  _SurveyQuestionsState createState() => _SurveyQuestionsState();
}

class _SurveyQuestionsState extends State<SurveyQuestions> {
  final SurveyController surveyController = Get.put(SurveyController());
  final Profilesetupcontroller profile = Get.find();

  PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isSurveyCompleted = false;

  @override
  void initState() {
    super.initState();
    surveyController.fetchQuestions();
  }

  void _nextPage() {
    if (surveyController.selectedAnswerIds[_currentIndex] != null) {
      if (_currentIndex < surveyController.questions.length - 1) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
        setState(() => _isSurveyCompleted = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (surveyController.isLoading.value) {
        return const Center(
            child:
             SpinKitDoubleBounce(
          color: Reclaimcolors.BasicWhite,
          size: 20.0,
        ));
      }

      return SafeArea(
        child: Scaffold(
          backgroundColor: Reclaimcolors.BasicWhite,
          body: _isSurveyCompleted ? _buildProfileCompleted() : _buildSurvey(),
        ),
      );
    });
  }

  Widget _buildSurvey() {
    return Column(
      children: [
        _buildProgressBar(),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: surveyController.questions.length,
            itemBuilder: (context, index) => _buildQuestion(index),
          ),
        ),
        _buildContinueButton(),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LinearProgressIndicator(
        backgroundColor: Reclaimcolors.BlueSecondary,
        color: Reclaimcolors.BasicBlue,
        value: (_currentIndex + 1) / surveyController.questions.length,
      ),
    );
  }

  Widget _buildQuestion(int index) {
    final question = surveyController.questions[index];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              question['question'],
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w800,
                  color: Reclaimcolors.BasicBlue),
            ),
          ),
          SizedBox(height: 40.h),
          ...List.generate(question['answers'].length, (optionIndex) {
            final answer = question['answers'][optionIndex];
            bool isSelected =
                surveyController.selectedAnswerIds[index] == answer['id'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  surveyController.selectAnswer(index, answer['id']);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: AnimatedContainer(
                  width: 380.w,
                  height: 55.h,
                  duration: Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Reclaimcolors.BasicBlue
                        : Reclaimcolors.BlueSecondary,
                    borderRadius: BorderRadius.circular(33),
                  ),
                  child: Center(
                    child: Text(
                      answer['answer_text'],
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    bool isDisabled = surveyController.selectedAnswerIds[_currentIndex] == null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      child: SizedBox(
        width: 380.w,
        height: 55.h,
        child: ElevatedButton(
          onPressed: isDisabled ? null : _nextPage,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled
                ? Reclaimcolors.BasicBlue.withOpacity(0.5)
                : Reclaimcolors.BasicBlue,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            "Continue",
            style: TextStyle(
                fontSize: 20.sp,
                color: Reclaimcolors.BasicWhite,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCompleted() {
    final SurveyController surveyController = Get.put(SurveyController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Reclaimcolors.BlueSecondary),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Reclaimcolors.BlueSecondary, Colors.white],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Lottie.asset('assets/animations/ProfileDoneInimation.json'),
            Text("Profile Completed 🎉",
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              // child: Text(
              //   "You're in good hands. Based on your responses, we'll create a journey tailored for you.",
              //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              //   textAlign: TextAlign.center,
              // ),

              child: Obx(() => Text(
                    surveyController.welcomeMessage.value.isNotEmpty
                        ? surveyController.welcomeMessage.value
                        : "You're in good hands. Based on your responses, we'll create a journey tailored for you.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  )),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(() => ReclaimButton(
                    titleColor: Reclaimcolors.BasicWhite,
                    width: 370.w,
                    height: 48.h,
                    backgroundColor: Reclaimcolors.BasicBlue,
                    title: "Log In",
                    fontWeight: FontWeight.w600,
                    isLoading: surveyController.isLoading.value,
                    onPressed: () {
                      surveyController.submitProfile(
                        name: profile.fullNameController.text.trim(),
                        age: profile.age.value.toString(),
                        gender: profile.genderController.text.trim(),
                        avatar: profile.selectedImage.value,
                      );
                    },
                  )),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
