import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/ComunityControllers/CommunityController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class communityInprog extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String description;
  final bool isFulfilled;
  final String imageUrl;
  final String? postImage;
  final RxBool isLiked;
  final int likesCount;
  final VoidCallback onTap;
  final int postId;

  communityInprog({
    super.key,
    required this.username,
    required this.imageUrl,
    required this.timeAgo,
    required this.description,
    required this.likesCount,
    required this.onTap,
    required this.postId,
    this.postImage,
    this.isFulfilled = false,
  }) : isLiked = false.obs;

  final RxBool isReporting = false.obs;

  void showReportDialog(BuildContext context, String postId) {
    final TextEditingController reasonController = TextEditingController();
    final RxBool isLoading = false.obs;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text("Report Post"),
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Why are you reporting this post?",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter your reason",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (isLoading.value)
                  // const Center(child: CircularProgressIndicator()),
                  const SpinKitDoubleBounce(
                    color: Reclaimcolors.BasicWhite,
                    size: 20.0,
                  ),
              ],
            ),
            actionsPadding: const EdgeInsets.only(right: 12, bottom: 10),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  final reason = reasonController.text.trim();
                  if (reason.isEmpty) {
                    Get.snackbar("Required", "Please enter a reason");
                    return;
                  }

                  setState(() {
                    isLoading.value = true;
                  });

                  try {
                    final response = await ApiService().postRequestWithToken(
                      "report-post",
                      {
                        "post_id": postId,
                        "reason": reason,
                      },
                    );

                    if (response != null && response.data['error'] == false) {
                      Navigator.pop(context);
                      Get.snackbar("Success", response.data['message']);
                    } else {
                      Get.snackbar("Error",
                          response?.data['message'] ?? "Failed to report");
                    }
                  } catch (_) {
                    Get.snackbar("Error", "Something went wrong");
                  } finally {
                    setState(() {
                      isLoading.value = false;
                    });
                  }
                },
                child: const Text("Submit",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPostImage = postImage != null && postImage!.isNotEmpty;
    final String fullImageUrl =
        "https://reclaim.hboxdigital.website/$postImage";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Reclaimcolors.BasicWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Reclaimcolors.BasicBlue.withOpacity(0.22),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Row with 3 dots
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Reclaimcolors.BlueSecondary,
                  radius: 25,
                  child: ClipOval(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(
                          color: Reclaimcolors.BasicBlack.withOpacity(.3),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => showReportDialog(
                          context,
                          postId.toString(),
                        )),
              ],
            ),

            const SizedBox(height: 8),

            // Tappable area
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(
                    color: Reclaimcolors.BasicBlack,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                if (hasPostImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fullImageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Like and comment
            Row(
              children: [
                // SpringWidget(
                //   onTap: () => isLiked.value = !isLiked.value,
                //   child: Obx(() => Row(
                //         children: [
                //           SvgPicture.asset(
                //             ReclaimIcon.heartIcon,
                //             width: 20.w,
                //             height: 20.h,
                //             color: isLiked.value
                //                 ? Reclaimcolors.BasicBlue
                //                 : Reclaimcolors.BorderColor,
                //           ),
                //           const SizedBox(width: 5),
                //           Text(
                //             likesCount.toString(),
                //             style: TextStyle(
                //               color: Reclaimcolors.BasicBlue,
                //               fontSize: 14,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //         ],
                //       )),
                // ),

                Obx(() {
                  final controller = Get.find<CommunityController>();

                  final isLoading = controller.likeLoading[postId] ?? false;

                  final post =
                      controller.posts.firstWhere((p) => p.id == postId);

                  return InkWell(
                    onTap: () {
                      if (!isLoading) {
                        controller.toggleLike(postId);
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          ScaleTransition(scale: animation, child: child),
                      child: isLoading
                          ? const SizedBox(
                              key: ValueKey('loader'),
                              height: 20,
                              width: 20,
                              child: SpinKitDoubleBounce(
                                color: Reclaimcolors.BasicBlue,
                                size: 20.0,
                              ),
                            )
                          : Row(
                              key: ValueKey('like_icon_${post.isLiked}'),
                              children: [
                                SvgPicture.asset(
                                  ReclaimIcon.heartIcon,
                                  width: 20.w,
                                  height: 20.h,
                                  color: post.isLiked
                                      ? Reclaimcolors.BasicBlue
                                      : Reclaimcolors.BorderColor,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  post.likesCount.toString(),
                                  style: TextStyle(
                                    color: Reclaimcolors.BasicBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                }),

                SizedBox(width: 20.w),
                Row(
                  children: [
                    SvgPicture.asset(
                      ReclaimIcon.CommentsIcon,
                      width: 20.w,
                      height: 20.h,
                      color: Reclaimcolors.BasicBlue,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "Comments",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
