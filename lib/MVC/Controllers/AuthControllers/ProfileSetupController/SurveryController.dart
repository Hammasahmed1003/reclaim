import 'dart:io';
import 'package:dio/dio.dart' as _dio;
// import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/UserController/userController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class SurveyController extends GetxController {
  RxList<Map<String, dynamic>> questions = <Map<String, dynamic>>[].obs;
  RxList<int?> selectedAnswerIds = <int?>[].obs;
  RxBool isLoading = false.obs;
  RxString welcomeMessage = "".obs;

  // Future<void> fetchQuestions() async {
  //   isLoading.value = true;
  //   final response = await ApiService().getRequest("all-questions");

  //   if (response != null && response.data["success"] == true) {
  //     List<dynamic> raw = response.data["data"];
  //     questions.value = raw
  //         .map((q) => {
  //               "id": q["id"],
  //               "question": q["question_text"],
  //               "answers": q["answers"],
  //             })
  //         .toList();

  //     selectedAnswerIds.value = List.filled(questions.length, null);
  //   }
  //   isLoading.value = false;
  // }

  Future<void> fetchQuestions() async {
    isLoading.value = true;

    final response = await ApiService().getRequest("all-questions");

    if (response != null && response.data["error"] == false) {
      List<dynamic> raw = response.data["data"];
      questions.value = raw
          .map((q) => {
                "id": q["id"],
                "question": q["question_text"],
                "answers": q["answers"],
              })
          .toList();

      selectedAnswerIds.value = List.filled(questions.length, null);
    }

    isLoading.value = false;
  }

  void selectAnswer(int questionIndex, int answerId) {
    selectedAnswerIds[questionIndex] = answerId;
  }

  // Future<void> submitProfile({
  //   required String name,
  //   required String age,
  //   required String gender,
  //   File? avatar,
  // }) async {
  //   isLoading.value = true;

  //   final answersList = selectedAnswerIds
  //       .asMap()
  //       .entries
  //       .map((entry) {
  //         final index = entry.key;
  //         final answerId = entry.value;
  //         if (answerId != null) {
  //           return {
  //             "question_id": questions[index]['id'],
  //             "answer_id": answerId
  //           };
  //         }
  //         return null;
  //       })
  //       .where((e) => e != null)
  //       .toList();

  //   final formData = FormData.fromMap({
  //     "name": name,
  //     "age": age,
  //     "gender": gender,
  //     // if (avatar != null)
  //     //   "avatar":
  //     //       await MultipartFile.fromFile(avatar.path, filename: "avatar.jpg"),
  //     // if (avatar != null)
  //     //   "avatar": await MultipartFile.fromFile(
  //     //     avatar.path,
  //     //     filename: avatar.path.split('/').last,
  //     //   ),
  //     // "avatar": "",
  //     ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //         "answers[${entry.key}][question_id]",
  //         entry.value!["question_id"].toString()))),
  //     ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //         "answers[${entry.key}][answer_id]",
  //         entry.value!["answer_id"].toString()))),
  //   });

  //   // final response = await ApiService().postRequest("create-profile", data: formData);

  //   final response =
  //       await ApiService().postMultipartRequest("create-profile", formData);

  //   isLoading.value = false;

  //   if (response != null && response.data["success"] == true) {
  //     Get.offAllNamed(
  //         '/in-app-purchases'); // replace with actual route if different
  //   } else {
  //     Get.snackbar("Error", "Profile creation failed",
  //         backgroundColor: Reclaimcolors.Red,
  //         colorText: Get.theme.colorScheme.onError);
  //   }
  // }

  // Future<void> submitProfile({
  //   required String name,
  //   required String age,
  //   required String gender,
  //   File? avatar,
  // }) async {
  //   isLoading.value = true;

  //   final answersList = selectedAnswerIds
  //       .asMap()
  //       .entries
  //       .map((entry) {
  //         final index = entry.key;
  //         final answerId = entry.value;
  //         if (answerId != null) {
  //           return {
  //             "question_id": questions[index]['id'],
  //             "answer_id": answerId
  //           };
  //         }
  //         return null;
  //       })
  //       .where((e) => e != null)
  //       .toList();

  //   final formData = FormData.fromMap({
  //     "name": name,
  //     "age": age,
  //     "gender": gender,
  //     if (avatar != null)
  //       // "avatar": await MultipartFile.fromFile(
  //       //   avatar.path,
  //       //   filename: avatar.path.split('/').last,
  //       // ),
  //       ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //           "answers[${entry.key}][question_id]",
  //           entry.value!["question_id"].toString()))),
  //     ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //         "answers[${entry.key}][answer_id]",
  //         entry.value!["answer_id"].toString()))),
  //   });

  //   final response =
  //       await ApiService().postMultipartRequest("create-profile", formData);

  //   isLoading.value = false;

  //   if (response != null) {
  //     print("📦 Full Response from create-profile:");
  //     print(response.data);

  //     final data = response.data;

  //     if (data["error"] == false && data["data"]?["welcome_message"] != null) {
  //       welcomeMessage.value = data["data"]["welcome_message"];
  //       Get.offAllNamed('/in-app-purchases'); // Adjust route if needed
  //     } else {
  //       Get.snackbar("Error", data["message"] ?? "Profile creation failed",
  //           backgroundColor: Reclaimcolors.Red,
  //           colorText: Get.theme.colorScheme.onError);
  //     }
  //   } else {
  //     Get.snackbar("Error", "No response from server",
  //         backgroundColor: Reclaimcolors.Red,
  //         colorText: Get.theme.colorScheme.onError);
  //   }
  // }

  // my new function

  // Future<void> submitProfile({
  //   required String name,
  //   required String age,
  //   required String gender,
  //   File? avatar,
  // }) async {
  //   isLoading.value = true;

  //   final answersList = selectedAnswerIds
  //       .asMap()
  //       .entries
  //       .map((entry) {
  //         final index = entry.key;
  //         final answerId = entry.value;
  //         if (answerId != null) {
  //           return {
  //             "question_id": questions[index]['id'],
  //             "answer_id": answerId
  //           };
  //         }
  //         return null;
  //       })
  //       .where((e) => e != null)
  //       .toList();

  //   final formMap = <String, dynamic>{
  //     "name": name,
  //     "age": age,
  //     "gender": gender,
  //     ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //         "answers[${entry.key}][question_id]",
  //         entry.value!["question_id"].toString()))),
  //     ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //         "answers[${entry.key}][answer_id]",
  //         entry.value!["answer_id"].toString()))),

  //   };

  //   if (avatar != null) {
  //     formMap["avatar"] = await MultipartFile.fromFile(
  //       avatar.path,
  //       filename: avatar.path.split('/').last,
  //     );
  //   }

  //   final formData = FormData.fromMap(formMap);

  //   // 🪵 Debug log: print all key-value pairs and files
  //   print("📝 Sending FormData to create-profile:");
  //   for (var field in formData.fields) {
  //     print("➡️ ${field.key}: ${field.value}");
  //   }

  //   if (formData.files.isNotEmpty) {
  //     for (var file in formData.files) {
  //       print("📎 File Field: ${file.key}, File Name: ${file.value.filename}");
  //     }
  //   }

  //   final response =
  //       await ApiService().postMultipartRequest("create-profile", formData);

  //   isLoading.value = false;

  //   if (response != null) {
  //     print("📦 Full Response from create-profile:");
  //     print(response.data);

  //     final data = response.data;

  //     if (data["error"] == false && data["data"]?["welcome_message"] != null) {
  //       welcomeMessage.value = data["data"]["welcome_message"];
  //       // Get.offAllNamed();
  //       Get.toNamed(
  //         GetRouteNames.InAppPurchasesScreen,
  //       );
  //     } else {
  //       Get.snackbar("Error", data["message"] ?? "Profile creation failed",
  //           backgroundColor: Reclaimcolors.Red,
  //           colorText: Get.theme.colorScheme.onError);
  //     }
  //   } else {
  //     Get.snackbar("Error", "No response from server",
  //         backgroundColor: Reclaimcolors.Red,
  //         colorText: Get.theme.colorScheme.onError);
  //   }
  // }

  Future<void> submitProfile({
    required String name,
    required String age,
    required String gender,
    File? avatar,
  }) async {
    isLoading.value = true;

    final userId = Get.find<UserController>().userId.value;

    final answersList = selectedAnswerIds
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final answerId = entry.value;
          if (answerId != null) {
            return {
              "question_id": questions[index]['id'],
              "answer_id": answerId
            };
          }
          return null;
        })
        .where((e) => e != null)
        .toList();

    final formMap = <String, dynamic>{
      "name": name,
      "age": age,
      "gender": gender,
      "user_id": userId, // ✅ Add user_id from controller
      ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
          "answers[${entry.key}][question_id]",
          entry.value!["question_id"].toString()))),
      ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
          "answers[${entry.key}][answer_id]",
          entry.value!["answer_id"].toString()))),
    };

    if (avatar != null) {
      formMap["avatar"] = await _dio.MultipartFile.fromFile(
        avatar.path,
        filename: avatar.path.split('/').last,
      );
    }
    String? token = await SharedPrefService.getUserToken();

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final formData = _dio.FormData.fromMap(formMap);

    // 🪵 Debug log
    print("📝 Sending FormData to create-profile:");
    for (var field in formData.fields) {
      print("➡️ ${field.key}: ${field.value}");
    }

    if (formData.files.isNotEmpty) {
      for (var file in formData.files) {
        print("📎 File Field: ${file.key}, File Name: ${file.value.filename}");
      }
    }
    final dio = _dio.Dio();

    final response = await dio.request(
      "https://reclaim.hboxdigital.website/api/create-profile",
      options: _dio.Options(
        method: 'POST',
        headers: headers,
      ),
      data: formData,
    );
    // ApiService().postMultipartRequest("create-profile", formData);

    isLoading.value = false;

    if (response != null) {
      print("📦 Full Response from create-profile:");
      print(response.data);

      final data = response.data;

      if (data["error"] == false && data["data"]?["welcome_message"] != null) {
        welcomeMessage.value = data["data"]["welcome_message"];
        Get.toNamed(GetRouteNames.InAppPurchasesScreen);
      } else {
        Get.snackbar("Error", data["message"] ?? "Profile creation failed",
            backgroundColor: Reclaimcolors.Red,
            colorText: Get.theme.colorScheme.onError);
      }
    } else {
      Get.snackbar("Error", "No response from server",
          backgroundColor: Reclaimcolors.Red,
          colorText: Get.theme.colorScheme.onError);
    }
  }

  // Future<void> submitProfile({
  //   required String name,
  //   required String age,
  //   required String gender,
  //   File? avatar,
  // }) async {
  //   isLoading.value = true;

  //   final answersList = selectedAnswerIds
  //       .asMap()
  //       .entries
  //       .map((entry) {
  //         final index = entry.key;
  //         final answerId = entry.value;
  //         if (answerId != null) {
  //           return {
  //             "question_id": questions[index]['id'],
  //             "answer_id": answerId
  //           };
  //         }
  //         return null;
  //       })
  //       .where((e) => e != null)
  //       .toList();

  //   final formMap = <String, dynamic>{
  //     "name": name,
  //     "age": age,
  //     "gender": gender,
  //     ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //         "answers[${entry.key}][question_id]",
  //         entry.value!["question_id"].toString()))),
  //     ...Map.fromEntries(answersList.asMap().entries.map((entry) => MapEntry(
  //         "answers[${entry.key}][answer_id]",
  //         entry.value!["answer_id"].toString()))),
  //   };

  //   if (avatar != null) {
  //     formMap["avatar"] = await MultipartFile.fromFile(
  //       avatar.path,
  //       filename: avatar.path.split('/').last,
  //     );
  //   }

  //   final formData = FormData.fromMap(formMap);

  //   // 🪵 Debug log: print all key-value pairs and files
  //   print("📝 Sending FormData to create-profile:");
  //   for (var field in formData.fields) {
  //     print("➡️ ${field.key}: ${field.value}");
  //   }

  //   if (formData.files.isNotEmpty) {
  //     for (var file in formData.files) {
  //       print("📎 File Field: ${file.key}, File Name: ${file.value.filename}");
  //     }
  //   }

  //   try {
  //     final token = await SharedPrefService.getUserToken();

  //     final dio = Dio();
  //     final response = await dio.request(
  //       'https://reclaim.hboxdigital.website/api/create-profile',
  //       options: Options(
  //         method: 'POST',
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //       data: formData,
  //     );

  //     isLoading.value = false;

  //     if (response.statusCode == 200) {
  //       print("📦 Full Response from create-profile:");
  //       print(response.data);

  //       final data = response.data;

  //       if (data["error"] == false &&
  //           data["data"]?["welcome_message"] != null) {
  //         welcomeMessage.value = data["data"]["welcome_message"];
  //         Get.toNamed(GetRouteNames.InAppPurchasesScreen);
  //       } else {
  //         Get.snackbar("Error", data["message"] ?? "Profile creation failed",
  //             backgroundColor: Reclaimcolors.Red,
  //             colorText: Get.theme.colorScheme.onError);
  //       }
  //     } else {
  //       Get.snackbar("Error", "Request failed: ${response.statusMessage}",
  //           backgroundColor: Reclaimcolors.Red,
  //           colorText: Get.theme.colorScheme.onError);
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     print("❌ Error in create-profile request: $e");
  //     Get.snackbar("Error", "Something went wrong",
  //         backgroundColor: Reclaimcolors.Red,
  //         colorText: Get.theme.colorScheme.onError);
  //   }
  // }
}
