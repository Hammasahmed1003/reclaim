import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/MVC/Views/CommitmentScreen/PostDetailScreen.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class CommunityController extends GetxController {
  var posts = <CommunityPostModel>[].obs;
  var isLoading = false.obs;
  final RxMap<int, bool> likeLoading = <int, bool>{}.obs;

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
        // await fetchPosts();

        // // Find updated post from the list
        // final updatedPost = posts.firstWhereOrNull(
        //   (post) => post.id.toString() == postId,
        // );

        // if (updatedPost != null) {
        //   // 👇 Navigate back to updated Post Detail Screen
        //   Get.off(() => PostDetailScreen(), arguments: updatedPost);

        final updatedPost = await fetchPostDetail(postId);

        if (updatedPost != null) {
          Get.back(); // Remove current detail screen
          Get.to(() => PostDetailScreen(),
              arguments: updatedPost); // Reopen with updated post
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

  Future<CommunityPostModel?> fetchPostDetail(String postId) async {
    try {
      final response =
          await ApiService().getRequestwithtoken("post-detail/$postId");

      if (response != null && response.data['error'] == false) {
        final json = response.data['data'];
        return CommunityPostModel.fromJson(json);
      } else {
        Get.snackbar("Error",
            response?.data['message'] ?? "Failed to fetch post detail");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong while fetching post detail");
    }
    return null;
  }

  Future<void> toggleLike(int postId) async {
    likeLoading[postId] = true;

    try {
      final response = await ApiService().postRequestWithToken(
        "like-post",
        {
          "post_id": postId.toString(),
        },
      );

      if (response != null && response.data['error'] == false) {
        // Toggle local like status and update likes count
        final index = posts.indexWhere((p) => p.id == postId);
        if (index != -1) {
          final post = posts[index];
          final updatedPost = CommunityPostModel(
            id: post.id,
            title: post.title,
            content: post.content,
            image: post.image,
            likesCount:
                post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
            isLiked: !post.isLiked,
            comments: post.comments,
            userId: post.userId,
            userName: post.userName,
            avatar: post.avatar,
            age: post.age,
            gender: post.gender,
            phone: post.phone,
            taskCategory: post.taskCategory,
            taskIntensity: post.taskIntensity,
            riskScore: post.riskScore,
          );
          posts[index] = updatedPost;
        }
      } else {
        Get.snackbar("Error", response?.data['message'] ?? "Action failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong while liking post");
    } finally {
      likeLoading[postId] = false;
    }
  }


  
}
