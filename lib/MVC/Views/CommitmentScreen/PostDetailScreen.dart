import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/ComunityControllers/CommunityController.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key});

  final CommunityController controller = Get.put(CommunityController());
  final RxBool _showEmoji = false.obs;
  final RxBool _isButtonEnabled = false.obs;

  @override
  Widget build(BuildContext context) {
    final CommunityPostModel post = Get.arguments as CommunityPostModel;

    controller.commentController.addListener(() {
      _isButtonEnabled.value =
          controller.commentController.text.trim().isNotEmpty;
    });

    return Scaffold(
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
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.fetchPosts();
                final updated =
                    controller.posts.firstWhereOrNull((p) => p.id == post.id);
                if (updated != null) {
                  post.comments.clear();
                  post.comments.addAll(updated.comments);
                }
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    "Post Title",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (post.image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://reclaim.hboxdigital.website/${post.image}",
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Reclaimcolors.BlueSecondary,
                        child:
                            Icon(Icons.person, color: Reclaimcolors.BasicBlue),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        post.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "2 mins ago",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    post.content ?? "No description provided.",
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
                  if (post.comments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("No comments yet.",
                          style:
                              TextStyle(color: Colors.grey, fontSize: 14.sp)),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: post.comments.length,
                      itemBuilder: (context, index) {
                        final comment = post.comments[index];
                        final profile = comment['user']['profile'];
                        final avatar = profile['avatar'] ?? '';
                        final userName = profile['name'] ?? 'Unknown';
                        final userComment = comment['comment'] ?? '';

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  "https://reclaim.hboxdigital.website$avatar",
                                ),
                                backgroundColor: Colors.grey.shade300,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Obx(() => IconButton(
                      icon: Icon(
                        Icons.emoji_emotions_outlined,
                        color: _showEmoji.value ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _showEmoji.toggle();
                      },
                    )),
                Expanded(
                  child: TextField(
                    controller: controller.commentController,
                    decoration: InputDecoration(
                      hintText: "Write a comment...",
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
                          ? Padding(
                              key: const ValueKey("loader"),
                              padding: const EdgeInsets.all(12),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Reclaimcolors.BasicBlue),
                                ),
                              ),
                            )
                          : _isButtonEnabled.value
                              ? IconButton(
                                  key: const ValueKey("enabled"),
                                  icon: const Icon(Icons.send,
                                      color: Colors.blue),
                                  onPressed: () async {
                                    await controller
                                        .sendComment(post.id.toString());

                                    // Refresh after comment
                                    await controller.fetchPosts();
                                    final updated = controller.posts
                                        .firstWhereOrNull(
                                            (p) => p.id == post.id);
                                    if (updated != null) {
                                      post.comments.clear();
                                      post.comments.addAll(updated.comments);
                                    }
                                  },
                                )
                              : IconButton(
                                  key: const ValueKey("disabled"),
                                  icon: Icon(Icons.send,
                                      color: Colors.grey.withOpacity(0.5)),
                                  onPressed: null,
                                ),
                    )),
              ],
            ),
          ),

          // EMOJI PICKER
          // Obx(() => Offstage(
          //       offstage: !_showEmoji.value,
          //       child: SizedBox(
          //         height: 250,
          //         child: EmojiPicker(
          //           onEmojiSelected: (category, emoji) {
          //             controller.commentController.text += emoji.emoji;
          //             _isButtonEnabled.value =
          //                 controller.commentController.text.trim().isNotEmpty;
          //           },
          //           config: Config(
          //             columns: 7,
          //             emojiSizeMax: 24 * (Platform.isIOS ? 1.30 : 1.0),
          //             bgColor: Colors.white,
          //             indicatorColor: Colors.blue,
          //             iconColor: Colors.grey,
          //             iconColorSelected: Colors.blue,
          //             backspaceColor: Colors.red,
          //             enableSkinTones: true,
          //           ),
          //         ),
          //       ),
          //     )),
        ],
      ),
    );
  }
}
