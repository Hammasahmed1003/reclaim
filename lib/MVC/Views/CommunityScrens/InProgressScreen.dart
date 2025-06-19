import 'package:flutter/material.dart';
import 'package:reclaim/Components/CommunityComponents/InprogressComponent.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data (Replace with API data later)
    final List<Map<String, dynamic>> inProgressPosts = [
      {
        "username": "Alica Terry",
        "timeAgo": "3 hours ago",
        "imageURl" :  "https://plus.unsplash.com/premium_photo-1689551670902-19b441a6afde?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "description": "No more useage of Phone ",
        "isFulfilled": false,
      },
      {
        "username": "Talha ",
        "timeAgo": "1 day ago",
        "imageURl" :  "https://plus.unsplash.com/premium_photo-1689562473471-6e736b8afe15?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "description": "Make sure Not to attracts towards opposite Gender",
        "isFulfilled": false,
      },
      {
        "username": "Michael_22",
        "timeAgo": "5 hours ago",
        "imageURl" :  "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "description": "Let me Live Alone",
        "isFulfilled": false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(2),
      itemCount: inProgressPosts.length,
      itemBuilder: (context, index) {
        final post = inProgressPosts[index];
        return InProgressComponent(
          imageUrl: post['imageURl'],
          username: post["username"],
          timeAgo: post["timeAgo"],
          description: post["description"],
          isFulfilled: post["isFulfilled"],
        );
      },
    );
  }
}
