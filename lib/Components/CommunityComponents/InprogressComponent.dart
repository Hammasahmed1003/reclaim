import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class InProgressComponent extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String description;
  final bool isFulfilled;
  final VoidCallback? onFulfill;

  final String imageUrl;
  final RxBool isLiked; // Observable to toggle like button

  InProgressComponent({
    super.key,
    required this.username,
    required this.imageUrl,
    required this.timeAgo,
    required this.description,
    this.isFulfilled = false,
      this.onFulfill,
  }) : isLiked = false.obs;

  @override
  Widget build(BuildContext context) {
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
              // const CircleAvatar(
              //   backgroundColor: Reclaimcolors.BlueSecondary,
              //   child: Icon(
              //     Icons.person,
              //     color: Reclaimcolors.BasicBlue,
              //     size: 30,
              //   ),
              // ),

              CircleAvatar(
                backgroundColor: Reclaimcolors.BlueSecondary,
                radius: 25, // Slightly larger for better proportions
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    // "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", // Replace with dynamic URL
                    fit: BoxFit.cover,
                    width: 50, // Match the CircleAvatar size
                    height: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        color: Reclaimcolors.BasicBlue,
                        size: 30,
                      ); // Fallback icon on error
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
                        fontWeight: FontWeight.bold),
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
                fontWeight: FontWeight.w400),
          ),

        

          const SizedBox(height: 12),

          // Buttons Row
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     // Fulfilled Button (Static)
          //     Container(
          //       padding:
          //           const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          //       decoration: BoxDecoration(
          //         color: isFulfilled
          //             ? Reclaimcolors.BasicBlue.withOpacity(0.15)
          //             : Reclaimcolors.BasicBlue, // Background color
          //         borderRadius:
          //             BorderRadius.circular(20), // More rounded corners
          //         border: Border.all(
          //             color: isFulfilled
          //                 ? Colors.white
          //                 : Reclaimcolors.BlueSecondary,
          //             width: 2), // Blue border
          //         boxShadow: [
          //           BoxShadow(
          //             color: isFulfilled
          //                 ? Colors.white
          //                 : Reclaimcolors.BlueSecondary, // Glowing effect
          //             blurRadius: 2, // Soft glow
          //             spreadRadius: 0,
          //             offset: const Offset(0, 1), // Slight bottom shadow
          //           ),
          //         ],
          //       ),
          //       child: Row(
          //         children: [
          //           SvgPicture.asset(
          //             isFulfilled ? ReclaimIcon.tic : ReclaimIcon.time,
          //             color: isFulfilled
          //                 ? Colors.green
          //                 : Reclaimcolors.BlueSecondary,
          //             width: 15,
          //             height: 10,
          //           ),
          //           SizedBox(
          //             width: 16,
          //           ),
          //           Text(
          //             isFulfilled ? "Fulfilled" : "InProgress",
          //             style: TextStyle(
          //               color: isFulfilled
          //                   ? Reclaimcolors.BasicBlack
          //                   : Reclaimcolors
          //                       .BasicWhite, // Blue text when unselected
          //               fontWeight: FontWeight.bold,
          //               fontSize: 18,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          if (!isFulfilled)
  GestureDetector(
    onTap: onFulfill,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Reclaimcolors.BasicBlue,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Reclaimcolors.BlueSecondary, width: 2),
        boxShadow: [
          BoxShadow(
            color: Reclaimcolors.BlueSecondary,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(ReclaimIcon.time,
              color: Reclaimcolors.BasicWhite, width: 15, height: 10),
          const SizedBox(width: 16),
          const Text(
            "Mark Fulfilled",
            style: TextStyle(
              color: Reclaimcolors.BasicWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  )
else
  Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    decoration: BoxDecoration(
      color: Reclaimcolors.BasicBlue.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: Row(
      children: [
        SvgPicture.asset(ReclaimIcon.tic, color: Colors.green, width: 15, height: 10),
        const SizedBox(width: 16),
        const Text(
          "Fulfilled",
          style: TextStyle(
            color: Reclaimcolors.BasicBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    ),
  ),
        ],
      ),
    );
  }
}
