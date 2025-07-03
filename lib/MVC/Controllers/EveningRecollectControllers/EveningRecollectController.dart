import 'package:get/get.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';

enum QuestionType { yesNo, slider, multiChoice, multiSelect, finalText }

class EveningRecollectController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var showEveningButton = false.obs;
  var selectedAnswer = ''.obs;
  var sliderValue = 0.0.obs;
  var multiSelectAnswers = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkRecollectAvailability();
  }

  void checkRecollectAvailability() async {
    final now = DateTime.now();
    final currentHour = now.hour;
    final todayStr = "${now.year}-${now.month}-${now.day}";

    print("🕒 Current Device Time: $now");
    print("📆 Today: $todayStr");

    final lastDateStr = await SharedPrefService.getLastRecollectDate();
    print("📝 Last Submitted Recollect Date: $lastDateStr");

    if (currentHour < 19) {
      print("⏳ It's before 7 PM. Button should remain HIDDEN.");
      showEveningButton.value = false;
      return;
    }

    if (lastDateStr == todayStr) {
      print("🚫 Already submitted recollect today. Button should be HIDDEN.");
      showEveningButton.value = false;
    } else {
      print("✅ Eligible to show recollect button. Showing the button.");
      showEveningButton.value = true;
    }
  }

  final ApiService apiService = ApiService();

  final RxList<Map<String, dynamic>> questions = [
    {
      'question': 'Victory',
      'type': QuestionType.yesNo,
    },
    {
      'question': 'What Was Your Level Of Temptation Overcome?',
      'type': QuestionType.slider,
    },
    {
      'question': 'Setback',
      'type': QuestionType.yesNo,
    },
    {
      'question': 'What Time Of Day?',
      'type': QuestionType.multiChoice,
      'options': ['morning', 'afternoon', 'evening', 'night'],
    },
    {
      'question': 'Triggers?',
      'type': QuestionType.multiSelect,
      'options': [
        'stress / anxiety',
        'Loneliness',
        'Boredom',
        'Social Media',
        'Movies / TV Shows'
      ],
    },
    {
      'question': '',
      'type': QuestionType.finalText,
    }
  ].obs;

  final RxMap<String, dynamic> responses = <String, dynamic>{}.obs;

  QuestionType get currentType => questions[currentQuestionIndex.value]['type'];
  String get currentQuestion =>
      questions[currentQuestionIndex.value]['question'];
  List<String> get currentOptions =>
      questions[currentQuestionIndex.value]['options'] ?? [];

  void selectAnswer(String answer) {
    selectedAnswer.value = answer;
  }

  void toggleMultiSelect(String answer) {
    if (multiSelectAnswers.contains(answer)) {
      multiSelectAnswers.remove(answer);
    } else {
      multiSelectAnswers.add(answer);
    }
  }

  bool isMultiSelected(String answer) => multiSelectAnswers.contains(answer);

  void goToNextQuestion() {
    final index = currentQuestionIndex.value;
    final type = currentType;

    switch (type) {
      case QuestionType.slider:
        responses['temptation_level'] = sliderValue.value.round();
        break;
      case QuestionType.multiSelect:
        responses['triggers'] = List.from(multiSelectAnswers);
        break;
      case QuestionType.yesNo:
        if (currentQuestion == 'Victory') {
          responses['is_victory'] = selectedAnswer.value == 'Yes' ? 1 : 0;
        } else {
          responses[currentQuestion] = selectedAnswer.value;
        }
        break;
      case QuestionType.multiChoice:
        responses['time_of_day'] = selectedAnswer.value;
        break;
      default:
        break;
    }

    selectedAnswer.value = '';
    sliderValue.value = 0;
    multiSelectAnswers.clear();

    if (index < questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void submitFinalAnswers() async {
    isLoading.value = true;

    if (!responses.containsKey('temptation_label')) {
      responses['temptation_label'] = getTemptationLabel();
    }

    final body = {
      "is_victory": responses['is_victory'] ?? 0,
      "temptation_level": responses['temptation_level'] as int ?? 0,
      "temptation_label": responses['temptation_label'] ?? '',
      "time_of_day": responses['time_of_day'] ?? '',
      "triggers": (responses['triggers'] as List?)?.join(', ') ?? '',
    };

    print('🧾 Final Payload: $body');

    final res =
        await apiService.postRequestWithToken("evening-recollect", body);
    isLoading.value = false;

    // if (res != null && res.statusCode == 200) {
    //   Get.back();
    //   Get.snackbar("✅ Success", "Recollection submitted successfully.");
    // } else {
    //   print("❌ API Error Response: ${res?.statusCode}, ${res?.data}");
    //   Get.snackbar("❌ Error", "Submission failed. Please try again.");
    // }

    if (res != null && res.statusCode == 200) {
      final todayStr =
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      await SharedPrefService.saveLastRecollectDate(todayStr);

      // Refresh UI button state
      // Get.find<HomeController>().checkRecollectAvailability();
      checkRecollectAvailability();
      Get.back();
      Get.snackbar("✅ Success", "Recollection submitted successfully.");
    }
  }

  String getTemptationLabel() {
    final val = sliderValue.value;
    if (val <= 3) return "low";
    if (val <= 7) return "medium";
    return "high";
  }
}
