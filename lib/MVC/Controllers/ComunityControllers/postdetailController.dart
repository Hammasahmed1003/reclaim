import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:reclaim/MVC/Models/postDetailModel.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class PostDetailController extends GetxController {
  var isLoading = false.obs;
  var isSendingComment = false.obs;
  Rx<PostDetailModel?> postDetail = Rxn<PostDetailModel>();

  final TextEditingController commentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  // Fetch post details by ID
  Future<void> fetchPostDetail(String postId) async {
    try {
      isLoading.value = true;
      final response = await ApiService().getRequestwithtoken("post/$postId");

      if (response != null && response.data['error'] == false) {
        postDetail.value = PostDetailModel.fromJson(response.data['data']);
      } else {
        Get.snackbar("Error",
            response?.data['message'] ?? "Failed to fetch post details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong while fetching post details");
    } finally {
      isLoading.value = false;
    }
  }

  // Send comment for the post
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
        // Get.snackbar("Success", response.data['message']);
        await fetchPostDetail(postId); // Refresh the post details after comment
      } else {
        Get.snackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Reclaimcolors.DisableText,
            colorText: Reclaimcolors.BasicWhite,
            "Failed",
            response?.data['message'] ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", "Could not send comment");
    } finally {
      isSendingComment.value = false;
    }
  }
}
