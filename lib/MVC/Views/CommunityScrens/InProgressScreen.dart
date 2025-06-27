import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommunityComponents/InprogressComponent.dart';
import 'package:reclaim/MVC/Controllers/Commitments/InprogressController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart'; // Your custom widget

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InProgressController controller = Get.put(InProgressController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: SpinKitDoubleBounce(
            color: Reclaimcolors.BasicWhite,
            size: 20.0,
          ),
        );
      }

      if (controller.commitments.isEmpty) {
        return const Center(child: Text("No commitments found :("));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(2),
        itemCount: controller.commitments.length,
        itemBuilder: (context, index) {
          final post = controller.commitments[index];
          // return InProgressComponent(
          //   imageUrl: post['imageUrl'],
          //   username: post["username"],
          //   timeAgo: post["timeAgo"],
          //   description: post["description"],
          //   isFulfilled: post["isFulfilled"],
          // );
          return InProgressComponent(
            imageUrl: post['imageUrl'],
            username: post["username"],
            timeAgo: post["timeAgo"],
            description: post["description"],
            isFulfilled: post["isFulfilled"],
            onFulfill: () async {
              print("Not pressing the button");
              print(post["id"]);

              await controller.markCommitmentFulfilled(post["id"]);
            },
          );
        },
      );
    });
  }
}
