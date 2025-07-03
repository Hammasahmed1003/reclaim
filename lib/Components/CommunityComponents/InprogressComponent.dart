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

          if (!isFulfilled)
            isFulfilled
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Reclaimcolors.BasicBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.green.withOpacity(0.3), width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          ReclaimIcon.tic,
                          color: Colors.green,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Fulfilled",
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: onFulfill,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Reclaimcolors.BasicBlue,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Reclaimcolors.BlueSecondary.withOpacity(0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Reclaimcolors.BlueSecondary.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            ReclaimIcon.time,
                            color: Colors.white,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Mark Fulfilled",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
        ],
      ),
    );
  }
}
