import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class CommunityController extends GetxController {
//this is my controller which is taking care of Community posts count like, commetn and Report(
//),

// functions

  var posts = <CommunityPostModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      final response = await ApiService().getRequestwithtoken("posts");

      if (response != null && response.data['error'] == false) {
        final List<dynamic> data = response.data['data'];
        posts.value =
            data.map((json) => CommunityPostModel.fromJson(json)).toList();
      } else {
        Get.snackbar(
            "Error", response?.data['message'] ?? "Failed to fetch posts");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
