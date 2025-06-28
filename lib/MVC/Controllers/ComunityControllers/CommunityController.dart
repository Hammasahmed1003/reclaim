import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/MVC/Views/CommitmentScreen/PostDetailScreen.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class CommunityController extends GetxController {
//this is my controller which is taking care of Community posts count like, commetn and Report(
//),

// functions

  var posts = <CommunityPostModel>[].obs;
  var isLoading = false.obs;

  final TextEditingController commentController = TextEditingController();

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

  var isSendingComment = false.obs;

  Future<void> sendComment(String postId) async {
    final comment = commentController.text.trim();
    if (comment.isEmpty) return;

    isSendingComment.value = true;

    try {
      final response = await ApiService().postRequestWithToken(
        "add-comment",
        {
          "post_id": postId,
          "comment": comment,
        },
      );

      if (response != null && response.data['error'] == false) {
        commentController.clear();
        Get.snackbar("Success", response.data['message']);

        // 🔄 Refresh all posts
        await fetchPosts();

        // Find updated post from the list
        final updatedPost = posts.firstWhereOrNull(
          (post) => post.id.toString() == postId,
        );

        if (updatedPost != null) {
          // 👇 Navigate back to updated Post Detail Screen
          Get.off(() => PostDetailScreen(), arguments: updatedPost);
        } else {
          Get.snackbar("Error", "Updated post not found");
        }
      } else {
        Get.snackbar(
            "Failed", response?.data['message'] ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "Could not send comment");
    } finally {
      isSendingComment.value = false;
    }
  }

  Future<void> reportPost(String postId, String reason) async {
    isLoading.value = true;
    try {
      final response = await ApiService().postRequestWithToken(
        "report-post",
        {
          "post_id": postId,
          "reason": reason,
        },
      );

      if (response?.data['success'] == true) {
        Get.back(); // Close the dialog
        Get.snackbar("Reported", "Post reported successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar(
            "Error", response?.data['message'] ?? "Something went wrong",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to report post",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
