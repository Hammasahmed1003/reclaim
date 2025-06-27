import 'package:get/get.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:flutter/material.dart';

enum QuestionType { yesNo, slider, multiChoice, multiSelect, finalText }

class EveningRecollectController extends GetxController {
  var currentQuestionIndex = 0.obs;
  var selectedAnswer = ''.obs;
  var sliderValue = 0.0.obs;
  var multiSelectAnswers = <String>[].obs;
  var isLoading = false.obs;

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

  // void submitFinalAnswers() async {
  //   isLoading.value = true;
  //   responses['temptation_label'] = getTemptationLabel();

  //   final body = {
  //     "is_victory": responses['is_victory'],
  //     "temptation_level": responses['temptation_level'],
  //     "temptation_label": responses['temptation_label'],
  //     "time_of_day": responses['time_of_day'],
  //     "triggers": responses['triggers']
  //   };

  //   final res = await apiService.postRequestWithToken("evening-recollect", body);
  //   isLoading.value = false;

  //   if (res != null && res.statusCode == 200) {
  //     Get.snackbar("Success", "Recollection submitted successfully.");
  //   } else {
  //     Get.snackbar("Error", "Submission failed. Please try again.");
  //   }
  // }

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

    if (res != null && res.statusCode == 200) {
      Get.back();
      Get.snackbar("✅ Success", "Recollection submitted successfully.");
    } else {
      print("❌ API Error Response: ${res?.statusCode}, ${res?.data}");
      Get.snackbar("❌ Error", "Submission failed. Please try again.");
    }
  }

  String getTemptationLabel() {
    final val = sliderValue.value;
    if (val <= 3) return "low";
    if (val <= 7) return "medium";
    return "high";
  }
}
