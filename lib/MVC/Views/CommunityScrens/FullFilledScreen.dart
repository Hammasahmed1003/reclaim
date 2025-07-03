import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommunityComponents/InprogressComponent.dart';
import 'package:reclaim/MVC/Controllers/Commitments/InprogressController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

class FulfilledScreen extends StatelessWidget {
  const FulfilledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InProgressController controller = Get.find();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: SpinKitDoubleBounce(
            color: Reclaimcolors.BasicWhite,
            size: 20.0,
          ),
        );
      }

      if (controller.fulfilledCommitments.isEmpty) {
        return const Center(child: Text("No fulfilled commitments yet"));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(2),
        itemCount: controller.fulfilledCommitments.length,
        itemBuilder: (context, index) {
          final post = controller.fulfilledCommitments[index];
          return InProgressComponent(
            imageUrl: post['imageUrl'],
            username: post["username"],
            timeAgo: post["timeAgo"],
            description: post["description"],
            isFulfilled: post["isFulfilled"],
          );
        },
      );
    });
  }
}
