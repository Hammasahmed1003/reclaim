// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:reclaim/Components/CommunityComponents/InprogressComponent.dart';
// import 'package:reclaim/Components/CommunityComponents/comunityInprof.dart';
// import 'package:reclaim/MVC/Controllers/ComunityControllers/CommunityController.dart';
// import 'package:reclaim/MVC/Views/CommunityScrens/FullFilledScreen.dart';
// import 'package:reclaim/MVC/Views/CommunityScrens/InProgressScreen.dart';
// import 'package:reclaim/appConstants/ReclaimColors.dart';
// import 'package:reclaim/appServices/getRouteNames.dart';

// class CommunityScreen extends StatelessWidget {
//   const CommunityScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CommunityController controller = Get.put(CommunityController());

//         final List<Map<String, dynamic>> inProgressPosts = [
//       {
//         "username": "Andrew",
//         "timeAgo": "3 hours ago",
//         "imageURl" :  "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",

//         "description": "I will not watch Porn for twenty-Days",
//         "isFulfilled": true,
//       },
//       {
//         "username": "Cristopher",
//         "timeAgo": "1 day ago",
//         "imageURl" :  "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",

//         "description": "Make good Eating Habbits and avoid Nudity",
//         "isFulfilled": true,
//       },
//       {
//         "username": "Izzah John",
//         "timeAgo": "5 hours ago",
//         "imageURl" :  "https://plus.unsplash.com/premium_photo-1689551671541-31a345ce6ae0?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
//         "description": "I will meditate everyday for 2 Months - Wish me Best of luck.",
//         "isFulfilled": true,
//       },
//     ];

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Reclaimcolors.BasicBlue,
//       ),
//       child: Scaffold(
//           backgroundColor: Reclaimcolors.BasicWhite,

//          floatingActionButton:  FloatingActionButton(
//           child:   Icon(Icons.add,
//           color: Reclaimcolors.BasicBlue,
//           size: 25,
//           ),
//           backgroundColor: Reclaimcolors.BasicWhite,

//           onPressed: (){
//             Get.toNamed(GetRouteNames.Createcommunityscreen);

//         }),
//         body:  SafeArea(
//           child: SingleChildScrollView(
//             child: Container(
//                decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
//                 stops: [0, 1],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//               child: Column(
//                 children: [
//                   // Header
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                     decoration: const BoxDecoration(
//                       color: Reclaimcolors.BasicBlue,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20),
//                       ),
//                     ),
//                     child: Center(
//                       child: Row(
//                         children: [
//                           const Spacer(),
//                           Text(
//                             "Community",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Reclaimcolors.BasicWhite,
//                               fontSize: 22.sp,
//                             ),
//                           ),
//                           const Spacer(),
//                         ],
//                       ),
//                     ),
//                   ),

//                  ListView.builder(
//                   shrinkWrap: true,
//                   primary: false,
//                       padding: const EdgeInsets.all(2),
//                       itemCount: inProgressPosts.length,
//                       itemBuilder: (context, index) {
//               final post = inProgressPosts[index];
//               return communityInprog(
//                 username: post["username"],
//                 timeAgo: post["timeAgo"],
//                 imageUrl: post['imageURl'],
//                 description: post["description"],
//                 isFulfilled: post["isFulfilled"],
//               );
//                       },
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// new

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
    final CommunityController controller = Get.put(CommunityController());

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
          child: Icon(
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

                            // Posts List
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.posts.length,
                              itemBuilder: (context, index) {
                                final post = controller.posts[index];
                                return SpringWidget(
                                  onTap: () {
                                    Get.toNamed(
                                      GetRouteNames.PostDetailScreen,
                                      arguments: post, // ✅ pass the full object
                                    );
                                  },
                                  child: communityInprog(
                                    username: post.userName,
                                    // post.user?.profile?.name ?? "Anonymous",
                                    timeAgo:
                                        // post.
                                        "Just now", // Add real-time conversion if needed
                                    // imageUrl: post.user?.profile?.avatarFullUrl ?? '',
                                    // imageUrl: post.avatar,
                                    // imageUrl:
                                    //     "https://reclaim.hboxdigital.website/${post.avatar}",
                                    imageUrl:
                                        "https://reclaim.hboxdigital.website/${post.avatar}",
                                    description: post.content ?? '',
                                    // postImage:
                                    //     "https://reclaim.hboxdigital.website/${post.image}",
                                    postImage: post.image,
                                    likesCount: post.likesCount,
                                    // isFulfilled: false, // update if needed
                                  ),
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
