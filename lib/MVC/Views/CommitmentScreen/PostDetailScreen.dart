import 'package:flutter/material.dart';
import 'package:reclaim/MVC/Models/CommunityPostModel.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final CommunityPostModel post = Get.arguments as CommunityPostModel;
     final CommunityPostModel post = Get.arguments as CommunityPostModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Reclaimcolors.BasicBlue,
        title: const Text('Post Detail'),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                  child: Icon(Icons.person, color: Reclaimcolors.BasicBlue),
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
                  "2 mins ago", // Optional: use DateTime if you have it
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
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

