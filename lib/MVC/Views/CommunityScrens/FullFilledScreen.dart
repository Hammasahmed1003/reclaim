import 'package:flutter/material.dart';
import 'package:reclaim/Components/CommunityComponents/InprogressComponent.dart';

class FulfilledScreen extends StatelessWidget {
  const FulfilledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> inProgressPosts = [
      {
        "username": "Andrew",
        "timeAgo": "3 hours ago",
        "imageURl":
            "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "description": "I will not watch Porn for twenty-Days",
        "isFulfilled": true,
      },
      {
        "username": "Cristopher",
        "timeAgo": "1 day ago",
        "imageURl":
            "https://images.unsplash.com/photo-1633332755192-727a05c4013d?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "description": "Make good Eating Habbits and avoid Nudity",
        "isFulfilled": true,
      },
      {
        "username": "Izzah John",
        "timeAgo": "5 hours ago",
        "imageURl":
            "https://plus.unsplash.com/premium_photo-1689551671541-31a345ce6ae0?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "description":
            "I will meditate everyday for 2 Months - Wish me Best of luck.",
        "isFulfilled": true,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(2),
      itemCount: inProgressPosts.length,
      itemBuilder: (context, index) {
        final post = inProgressPosts[index];
        return InProgressComponent(
          username: post["username"],
          timeAgo: post["timeAgo"],
          imageUrl: post['imageURl'],
          description: post["description"],
          isFulfilled: post["isFulfilled"],
        );
      },
    );
  }
}
