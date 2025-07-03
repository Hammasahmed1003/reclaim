import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/NotificationComponent/NotificationComponents.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/NotificationController/NotificationController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class Notificationscreen extends StatelessWidget {
  const Notificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.put(NotificationController());

    final List<Map<String, String>> notifications = [
      {
        "username": "James William",
        "timeAgo": "5 minutes ago",
        "notificationTime": "12:00"
      },
      {
        "username": "Alice Brown",
        "timeAgo": "10 minutes ago",
        "notificationTime": "11:50"
      },
      {
        "username": "Michael Scott",
        "timeAgo": "15 minutes ago",
        "notificationTime": "11:45"
      },
    ];
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicWhite,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              gradient: LinearGradient(
                colors: [Reclaimcolors.BlueSecondary, const Color(0xffffffff)],
                stops: const [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: SpringWidget(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(ReclaimIcon.Back)),
                        ),
                        const Spacer(),
                        Text(
                          "Notifications",
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
                SizedBox(
                  height: 10.h,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ListView.builder(

                //     shrinkWrap: true,
                //     primary: false,
                //   itemCount: notifications.length,
                //   itemBuilder: (context, index) {
                //               final item = notifications[index];
                //               return SpringWidget(
                //                 onTap: (){

                //                 },
                //                 child: NotificationComponent(
                //                   username: item["username"]!,
                //                   timeAgo: item["timeAgo"]!,
                //                   notificationTime: item["notificationTime"]!,
                //                 ),
                //               );
                //   },
                //                     ),
                // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const SpinKitDoubleBounce(
                        color: Reclaimcolors.BasicBlue,
                        size: 20.0,
                      );
                      // const Center(child: CircularProgressIndicator());
                    }

                    if (controller.notifications.isEmpty) {
                      return const Center(
                          child: Text("No notifications found :("));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = controller.notifications[index];
                        return SpringWidget(
                          onTap: () {
                            final type = notification.type.toLowerCase();
                            final relatedId = notification.relatedId;

                            if (type == "like" ||
                                type == "comment" ||
                                type == "post") {
                              if (relatedId != null) {
                                Get.toNamed(
                                  GetRouteNames.PostDetailScreen,
                                  arguments: relatedId.toString(),
                                );
                              } else {
                                print(
                                    "⚠️ related_id not available for notification ID ${notification.id}");
                              }
                            } else {
                              print(
                                  "ℹ️ No navigation implemented for type: $type");
                            }
                          },
                          child: NotificationComponent(
                              username: notification.title,
                              timeAgo: notification.createdAt.toString(),
                              //  timeAgoFromNow(notification.createdAt).toString(),
                              notificationTime:
                                  notification.createdAt.toString()),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String timeAgoFromNow(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inSeconds < 60) return '${difference.inSeconds}s ago';
  if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
  if (difference.inHours < 24) return '${difference.inHours}h ago';
  return '${difference.inDays}d ago';
}

String formatTime(DateTime dateTime) {
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}
