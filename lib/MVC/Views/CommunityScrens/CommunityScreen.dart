import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommunityComponents/comunityInprof.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/ComunityControllers/CommunityController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommunityController());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
      ),
      child: Scaffold(
        backgroundColor: Reclaimcolors.BasicWhite,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(GetRouteNames.Createcommunityscreen);
          },
          backgroundColor: Reclaimcolors.BasicWhite,
          child: const Icon(
            Icons.add,
            color: Reclaimcolors.BasicBlue,
            size: 25,
          ),
        ),
        body: SafeArea(
          child: Obx(
            () => controller.isLoading.value
                ? Center(
                    child: SpinKitDoubleBounce(
                      color: Reclaimcolors.BasicBlue,
                      size: 20.0,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: controller.fetchPosts,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Reclaimcolors.BlueSecondary,
                              Color(0xffffffff)
                            ],
                            stops: [0, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Header
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              decoration: const BoxDecoration(
                                color: Reclaimcolors.BasicBlue,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Text(
                                      "Community",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Reclaimcolors.BasicWhite,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Check if there are no posts
                            if (controller.posts.isEmpty)
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "No posts available.",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Reclaimcolors.BasicBlue,
                                    ),
                                  ),
                                ),
                              )
                            else
                              // Posts List
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.posts.length,
                                itemBuilder: (context, index) {
                                  final post = controller.posts[index];
                                  return communityInprog(
                                    username: post.userName,
                                    timeAgo: "Just now",
                                    imageUrl:
                                        "https://reclaim.hboxdigital.website/${post.avatar}",
                                    description: post.content ?? '',
                                    postImage: post.image,
                                    likesCount: post.likesCount,
                                    postId: post.id,
                                    onTap: () {
                                      Get.toNamed(
                                        GetRouteNames.PostDetailScreen,
                                        arguments: post.id.toString(),
                                      );
                                    },
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
