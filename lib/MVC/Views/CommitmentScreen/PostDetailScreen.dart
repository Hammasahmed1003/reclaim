import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/ComunityControllers/CommunityController.dart';
import 'package:reclaim/MVC/Controllers/ComunityControllers/postdetailController.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/MVC/Models/postDetailModel.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

class PostDetailScreen extends StatefulWidget {
  PostDetailScreen({super.key});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final PostDetailController controller = Get.put(PostDetailController());
  final RxBool _showEmoji = false.obs;
  final RxBool _isButtonEnabled = false.obs;

  @override
  void initState() {
    super.initState();
    final postId = Get.arguments as String;
    controller.fetchPostDetail(postId); // Fetch post details
    controller.commentController.addListener(() {
      _isButtonEnabled.value =
          controller.commentController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Reclaimcolors.BorderColor.withOpacity(0.7),
      ),
      child: Scaffold(
        backgroundColor: Reclaimcolors.BasicWhite,
        appBar: AppBar(
          backgroundColor: Reclaimcolors.BasicBlue,
          title: const Text(
            'Post Detail',
            style: TextStyle(
                color: Reclaimcolors.BasicWhite, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Obx(() {
          final postDetail = controller.postDetail.value;

          if (postDetail == null) {
            return const Center(
              child: SpinKitDoubleBounce(
                color: Reclaimcolors.BasicBlue,
                size: 20.0,
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchPostDetail(postDetail.id.toString());
                  },
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Text(
                      //   postDetail.title ?? 'No Title',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 20.sp,
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                      if (postDetail.image != null)
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(12),
                        //   child: Image.network(
                        //     "https://reclaim.hboxdigital.website/${postDetail.user.avatar}",
                        //     height: 200,
                        //     width: double.infinity,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                            onTap: () {
                              _showFullScreenImage(context,
                                  "https://reclaim.hboxdigital.website/${postDetail.image}");
                            },
                            child: Image.network(
                              "https://reclaim.hboxdigital.website/${postDetail.image}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          //  CircleAvatar(
                          //   backgroundColor: Reclaimcolors.BlueSecondary,
                          //   child:
                          //   Image.network(
                          //     "https://reclaim.hboxdigital.website/${postDetail.user.avatar}",
                          //     height: 200,
                          //     width: double.infinity,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Image.network(
                              "https://reclaim.hboxdigital.website/${postDetail.user.avatar}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            postDetail.user.name.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Text(
                          //   "2 mins ago",
                          //   style: TextStyle(
                          //     color: Colors.grey,
                          //     fontSize: 12.sp,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        postDetail.content ?? "No description provided.",
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      const Divider(height: 30),
                      Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (postDetail.comments.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("No comments yet.",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14.sp)),
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: postDetail.comments.length,
                          itemBuilder: (context, index) {
                            final comment = postDetail.comments[index];
                            final userName = comment.user.name;
                            final userComment = comment.comment;

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      "https://reclaim.hboxdigital.website${comment.user.avatar}",
                                    ),
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          userComment,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Obx(() {
                                          final isLoading =
                                              controller.commentLikeLoading[
                                                      comment.id] ??
                                                  false;

                                          return InkWell(
                                            // onTap: () {
                                            //   if (!isLoading) {
                                            //     controller
                                            //         .toggleCommentLike(comment);
                                            //   }
                                            // },
                                            onDoubleTap: () {
                                              if (!isLoading) {
                                                controller
                                                    .toggleCommentLike(comment);
                                              }
                                            },
                                            child: AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              transitionBuilder:
                                                  (child, animation) =>
                                                      ScaleTransition(
                                                          scale: animation,
                                                          child: child),
                                              child: isLoading
                                                  ? const SizedBox(
                                                      key: ValueKey(
                                                          'comment-loader'),
                                                      height: 18,
                                                      width: 18,
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Reclaimcolors
                                                            .BasicBlue,
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .thumb_up_alt_rounded,
                                                      key: ValueKey(
                                                          'comment-like-icon-${comment.isLiked.value}'),
                                                      color:
                                                          comment.isLiked.value
                                                              ? Reclaimcolors
                                                                  .BasicBlue
                                                              : Colors.grey
                                                                  .shade400,
                                                      size: 18,
                                                    ),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              // COMMENT FIELD
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                color: Reclaimcolors.BorderColor.withOpacity(0.7),
                child: Row(
                  children: [
                    // Obx(() => IconButton(
                    //       icon: Icon(
                    //         Icons.emoji_emotions_outlined,
                    //         color: _showEmoji.value ? Colors.blue : Colors.grey,
                    //       ),
                    //       onPressed: () {
                    //         FocusScope.of(context).unfocus();
                    //         _showEmoji.toggle();
                    //       },
                    //     )),
                    Expanded(
                      child: TextField(
                        controller: controller.commentController,
                        decoration: InputDecoration(
                          hintText: "Write a comment...",
                          hintStyle: TextStyle(
                              fontSize: 13.sp,
                              color: Reclaimcolors.DisableText),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Obx(() => AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: controller.isSendingComment.value
                              ? const Padding(
                                  key: const ValueKey("loader"),
                                  padding: const EdgeInsets.all(12),
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SpinKitDoubleBounce(
                                      color: Reclaimcolors.BasicBlue,
                                      size: 20.0,
                                    ),
                                  ),
                                )
                              : _isButtonEnabled.value
                                  ? IconButton(
                                      key: const ValueKey("enabled"),
                                      icon: const Icon(Icons.send,
                                          color: Reclaimcolors.BasicBlue),
                                      onPressed: () async {
                                        await controller.sendComment(
                                            postDetail.id.toString());

                                        // Refresh after comment
                                        await controller.fetchPostDetail(
                                            postDetail.id.toString());
                                      },
                                    )
                                  : IconButton(
                                      key: const ValueKey("disabled"),
                                      icon: Icon(Icons.send,
                                          color: Reclaimcolors.BasicBlue
                                              .withOpacity(0.2)),
                                      onPressed: null,
                                    ),
                        )),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

void _showFullScreenImage(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog when tapped
          },
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit
                    .contain, // Ensures image scales properly in the dialog
                height: MediaQuery.of(context).size.height *
                    0.8, // 80% of screen height
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
              ),
            ),
          ),
        ),
      );
    },
  );
}
