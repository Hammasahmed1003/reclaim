import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class NotificationComponent extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String notificationTime;

  const NotificationComponent({
    Key? key,
    required this.username,
    required this.timeAgo,
    required this.notificationTime,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
              border:  Border.all(color: Reclaimcolors.BasicBlue),

        color: Reclaimcolors.BasicBlue.withOpacity(0.15), // Light blue background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Icon
          Container(
            width: 30,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Reclaimcolors.BasicWhite, // White circle background
            ),
            child: SvgPicture.asset(
             ReclaimIcon.userIcon, // Update with your actual icon path
              height: 20,
              width: 20,
            ),
          ),
          const SizedBox(width: 10),

          // Notification Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeAgo,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),

          // Time
          Text(
            notificationTime,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Reclaimcolors.BasicBlue,
            ),
          ),
        ],
      ),
    );
  }
}
