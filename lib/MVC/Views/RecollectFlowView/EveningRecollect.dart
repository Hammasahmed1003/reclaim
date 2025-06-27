import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/MVC/Controllers/EveningRecollectControllers/EveningRecollectController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';

class EveningRecollectScreen extends StatelessWidget {
  final controller = Get.put(EveningRecollectController());

  @override
  Widget build(BuildContext context) {
    Obx(() => controller.isLoading.value
        ? const Center(
            child: SpinKitDoubleBounce(
              color: Reclaimcolors.BasicWhite,
              size: 20.0,
            ),
          )
        : const SizedBox.shrink());
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Evening Recollect",
            style: TextStyle(color: Reclaimcolors.BasicWhite),
          ),
          leading: const BackButton(
            color: Reclaimcolors.BasicWhite,
          ),
          backgroundColor: Reclaimcolors.BasicBlue),
      body: Column(
        children: [
          Image.asset(
            Reclaimimages.alertImage,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 24),
          Obx(() => Text(
                controller.currentQuestion,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(height: 24),
          Obx(() => _buildQuestionTypeWidget(controller.currentType)),
          const Spacer(),
          Obx(() {
            if (controller.currentType == QuestionType.finalText)
              return const SizedBox.shrink();
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: const Size(300, 50),
              ),
              onPressed: _canContinue() ? controller.goToNextQuestion : null,
              child: const Text("Continue"),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  bool _canContinue() {
    final type = controller.currentType;
    if (type == QuestionType.slider) return true;
    if (type == QuestionType.multiSelect)
      return controller.multiSelectAnswers.isNotEmpty;
    return controller.selectedAnswer.value.isNotEmpty;
  }

  Widget _buildQuestionTypeWidget(QuestionType type) {
    switch (type) {
      case QuestionType.yesNo:
        return Column(
          children: [
            _buildAnswerButton(
              text: 'Yes',
              isSelected: controller.selectedAnswer.value == 'Yes',
              onPressed: () => controller.selectAnswer('Yes'),
            ),
            const SizedBox(height: 16),
            _buildAnswerButton(
              text: 'No',
              isSelected: controller.selectedAnswer.value == 'No',
              onPressed: () => controller.selectAnswer('No'),
            ),
          ],
        );
      case QuestionType.slider:
        return _buildSliderArea();
      case QuestionType.multiChoice:
        return Column(
          children: controller.currentOptions
              .map((opt) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _buildAnswerButton(
                      text: opt,
                      isSelected: controller.selectedAnswer.value == opt,
                      onPressed: () => controller.selectAnswer(opt),
                    ),
                  ))
              .toList(),
        );
      case QuestionType.multiSelect:
        return Column(
          children: controller.currentOptions
              .map((opt) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Obx(() => _buildAnswerButton(
                          text: opt,
                          isSelected: controller.isMultiSelected(opt),
                          onPressed: () => controller.toggleMultiSelect(opt),
                        )),
                  ))
              .toList(),
        );
      case QuestionType.finalText:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Evening Recollect',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
              ),
              const SizedBox(height: 16),
              const Text(
                'Consent',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'By continuing, you agree to share your recollection data...',
              ),
              const SizedBox(height: 24),
              Center(
                child:
                    //  ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue,
                    //     minimumSize: const Size(200, 50),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(24),
                    //     ),
                    //   ),
                    //   onPressed: controller.submitFinalAnswers,
                    //   child: const Text("Submit"),
                    // ),
                    ReclaimButton(
                        isLoading: controller.isLoading.value,
                        titleColor: Reclaimcolors.BasicWhite,
                        width: 370.w,
                        height: 48.h,
                        backgroundColor: Reclaimcolors.BasicBlue,
                        title: "Submit",
                        fontWeight: FontWeight.w600,
                        onPressed: () {
                          controller.submitFinalAnswers();
                          // Get.toNamed(GetRouteNames.BottomnavbarView);

                          // logincontroller.login();
                        }),
              )
            ],
          ),
        );
    }
  }

  Widget _buildAnswerButton({
    required String text,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Reclaimcolors.BasicBlue : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.grey,
        minimumSize: const Size(300, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(text),
    );
  }

  Widget _buildSliderArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Slide To Select',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Slider(
                value: controller.sliderValue.value,
                min: 0,
                max: 10,
                divisions: 10,
                label: controller.sliderValue.value.round().toString(),
                onChanged: (value) => controller.sliderValue.value = value,
              ),
              const Center(child: Text('Or')),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['Low', 'Medium', 'High']
                    .map((label) =>
                        // ReclaimButton(
                        //           width: 100.sp,
                        //           height: 45.sp,
                        //           backgroundColor: Reclaimcolors.BasicBlue,
                        //           title: label,
                        //           fontWeight: FontWeight.w600,
                        //           onPressed: () {
                        //             switch (label) {
                        //               case 'Low':
                        //                 controller.sliderValue.value = 2;
                        //                 break;
                        //               case 'Medium':
                        //                 controller.sliderValue.value = 5;
                        //                 break;
                        //               case 'High':
                        //                 controller.sliderValue.value = 8;
                        //                 break;
                        //             }
                        //             controller.goToNextQuestion();
                        //           },
                        //         )
                        ElevatedButton(
                          onPressed: () {
                            switch (label) {
                              case 'Low':
                                controller.sliderValue.value = 2;
                                break;
                              case 'Medium':
                                controller.sliderValue.value = 5;
                                break;
                              case 'High':
                                controller.sliderValue.value = 8;
                                break;
                            }
                            controller.goToNextQuestion();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(label),
                        ))
                    .toList(),
              )
            ],
          )),
    );
  }
}
