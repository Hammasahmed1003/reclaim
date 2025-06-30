import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:reclaim/MVC/Models/lessionModel.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class SavedLessonController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isLoading = true.obs;
  // final RxList<dynamic> savedLessons = <dynamic>[].obs;
  var savedLessons = <LessonModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSavedLessons();
  }

  // Future<void> fetchSavedLessons() async {
  //   try {
  //     isLoading.value = true;
  //     Response response = await _apiService.getRequestwithtoken("save-lesson-list");

  //     if (response != null && response.statusCode == 200 && response.data['error'] == false) {
  //       savedLessons.value = response.data['data'];
  //     } else {
  //       Get.snackbar("Error", response?.data['message'] ?? "Failed to load saved lessons");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Something went wrong");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> fetchSavedLessons() async {
    isLoading.value = true;
    final response = await ApiService().getRequestwithtoken("save-lesson-list");

    if (response != null &&
        response.statusCode == 200 &&
        response.data["error"] == false) {
      final List<dynamic> data = response.data["data"];
      savedLessons.value =
          data.map((item) => LessonModel.fromJson(item['lesson'])).toList();
    }

    isLoading.value = false;
  }
}
