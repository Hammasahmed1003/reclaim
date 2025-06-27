import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

// class communityInprog extends StatelessWidget {
//   final String username;
//   final String timeAgo;
//   final String description;
//   final bool isFulfilled;
//   final String imageUrl;
//   final RxBool isLiked; // Observable to toggle like button

//   communityInprog({
//     super.key,
//     required this.username,
//     required this.imageUrl,
//     required this.timeAgo,
//     required this.description,
//     this.isFulfilled = false,
//   }) : isLiked = false.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Reclaimcolors.BasicWhite,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Reclaimcolors.BasicBlue.withOpacity(0.22),
//             blurRadius: 5,
//             spreadRadius: 2,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Profile Row
//           Row(
//             children: [
//               // const CircleAvatar(
//               //   backgroundColor: Reclaimcolors.BlueSecondary,
//               //   child: Icon(
//               //     Icons.person,
//               //     color: Reclaimcolors.BasicBlue,
//               //     size: 30,
//               //   ),
//               // ),

//    CircleAvatar(
//   backgroundColor: Reclaimcolors.BlueSecondary,
//   radius: 25, // Slightly larger for better proportions
//   child: ClipOval(
//     child: Image.network(
//      imageUrl,
//       // "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", // Replace with dynamic URL
//       fit: BoxFit.cover,
//       width: 50, // Match the CircleAvatar size
//       height: 50,
//       errorBuilder: (context, error, stackTrace) {
//         return const Icon(
//           Icons.person,
//           color: Reclaimcolors.BasicBlue,
//           size: 30,
//         ); // Fallback icon on error
//       },
//     ),
//   ),
// ),

//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     username,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.sp,
//                     ),
//                   ),
//                   Text(
//                     timeAgo,
//                     style:  TextStyle(
//                       color: Reclaimcolors.BasicBlack.withOpacity(.3),
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),

//           // Description
//           Text(
//             description,
//             style:const TextStyle(color: Reclaimcolors.BasicBlack, fontSize: 15,
//             fontWeight: FontWeight.w400
//             ),
//           ),

//           const SizedBox(height: 12),

//           // Buttons Row
//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [

//               // Fulfilled Button (Static)
//             //  Like Button with GestureDetector and AnimatedSwitcher
//               SpringWidget(
//                 onTap: () {
//                   isLiked.value = !isLiked.value;
//                 },
//                 child: Obx(
//                   () => AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 300),
//                     transitionBuilder: (child, animation) => ScaleTransition(
//                       scale: animation,
//                       child: child,
//                     ),
//                     child: Row(
//                       key: ValueKey(isLiked.value),
//                       children: [
//                         SvgPicture.asset(ReclaimIcon.heartIcon,
//                         width: 20.w,
//                         height: 20.h,
//                         color: isLiked.value? Reclaimcolors.BasicBlue : Reclaimcolors.BorderColor,
//                         ),
//                         // Icon(
//                         //   Icons.thumb_up,
//                         //   color: isLiked.value ? Reclaimcolors.BasicBlue : Reclaimcolors.BorderColor,
//                         //   size: 20,
//                         // ),
//                         const SizedBox(width: 5),
//                         Text(
//                          isLiked.value ? "Liked" : "Like",
//                           // "Like",
//                           style: TextStyle(
//                             color:isLiked.value? Reclaimcolors.BasicBlue : Reclaimcolors.BorderColor,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
// SizedBox(width: 20.w,),
//               // Comments Button with GestureDetector
//               SpringWidget(
//                 onTap: () {
//                   // Handle comment action
//                 },
//                 child:  Row(
//                   children: [
//                    SvgPicture.asset(ReclaimIcon.CommentsIcon,
//                     width: 20.w,
//                         height: 20.h,
//                         color: Reclaimcolors.BasicBlue,
//                    ),
//                     // const Icon(Icons.comment, color: Colors.blue, size: 20),
//                     const SizedBox(width: 5),
//                     Text(
//                       "Comments",
//                       style: TextStyle(color: Colors.blue, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),

//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class communityInprog extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String description;
  final bool isFulfilled;
  final String imageUrl;
  final String? postImage;
  final RxBool isLiked;
  final int likesCount;

  communityInprog({
    super.key,
    required this.username,
    required this.imageUrl,
    required this.timeAgo,
    required this.description,
    required this.likesCount,
    this.postImage,
    this.isFulfilled = false,
  }) : isLiked = false.obs;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Row
          Row(
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
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        color: Reclaimcolors.BasicBlue,
                        size: 30,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
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
            ],
          ),
    
          const SizedBox(height: 8),
    
          // Description
          Text(
            description,
            style: const TextStyle(
              color: Reclaimcolors.BasicBlack,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
    
          const SizedBox(height: 10),
    
          // Post Image (if available)
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
    
          const SizedBox(height: 12),
    
          // Like and Comment Buttons
          Row(
            children: [
              SpringWidget(
                onTap: () {
                  isLiked.value = !isLiked.value;
                },
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: Row(
                      key: ValueKey(isLiked.value),
                      children: [
                        SvgPicture.asset(
                          ReclaimIcon.heartIcon,
                          width: 20.w,
                          height: 20.h,
                          color: isLiked.value
                              ? Reclaimcolors.BasicBlue
                              : Reclaimcolors.BorderColor,
                        ),
                        const SizedBox(width: 5),
                        // Text(
                        //   isLiked.value ? "Liked" : "Like",
                        //   style: TextStyle(
                        //     color: isLiked.value
                        //         ? Reclaimcolors.BasicBlue
                        //         : Reclaimcolors.BorderColor,
                        //     fontSize: 14,
                        //   ),
                        // ),
                        Text(
                          // "100 Likes",
                          likesCount.toString(),
                          style: TextStyle(
                              color:
                                  //  isLiked.value
                                  Reclaimcolors.BasicBlue,
                              // : Reclaimcolors.BorderColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              SpringWidget(
                onTap: () {
                  // Handle comment action
                },
                child: Row(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
