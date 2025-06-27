import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/MVC/Controllers/AuthControllers/InAppPurchaseController/InAppPurchaseController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class InAppPurchasesScreen extends StatelessWidget {
  final InAppPurchasesController controller =
      Get.put(InAppPurchasesController());

  final List<Map<String, String>> plans = [
    {
      'title': 'Monthly',
      'price': '\$9.99/Mo',
    },
    {
      'title': 'Yearly',
      'price': '\$49.17/Mo',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Reclaimcolors.BasicWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon:
                      const Icon(Icons.close, color: Reclaimcolors.BorderColor),
                  onPressed: () => Get.back(),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: SvgPicture.asset(ReclaimIcon.card, height: 160),
              ),
              const SizedBox(height: 30),
              const Text(
                'Lorem ipsum dolor sit amet,\nsed do eiusme tempor.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Obx(() => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      key: ValueKey(controller.selectedIndex.value),
                      children: controller
                          .features[controller.selectedIndex.value]
                          .map((item) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(ReclaimIcon.check,
                                        height: 24, width: 24),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item['title']!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                          const SizedBox(height: 4),
                                          Text(item['subtitle']!,
                                              style: TextStyle(
                                                  color: Colors.grey[700])),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )),
              const SizedBox(height: 20),
              Obx(() => Row(
                    children: List.generate(plans.length, (index) {
                      final isSelected =
                          controller.selectedIndex.value == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectPlan(index),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              key: ValueKey(
                                  index == controller.selectedIndex.value),
                              margin: const EdgeInsets.symmetric(horizontal: 6),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Reclaimcolors.BasicWhite
                                    : Reclaimcolors.BlueSecondary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? Reclaimcolors.BasicBlue
                                      : Reclaimcolors.BorderColor,
                                  width: 2,
                                ),
                                boxShadow: [
                                  if (isSelected)
                                    const BoxShadow(
                                      color: Reclaimcolors.BlueSecondary,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    )
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(plans[index]['title']!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      if (isSelected)
                                        // SvgPicture.asset(ReclaimIcon.check),
                                        const Icon(Icons.check_circle,
                                            color: Reclaimcolors.BasicBlue)
                                      else
                                        const Icon(Icons.radio_button_unchecked,
                                            color: Reclaimcolors.BorderColor),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    plans[index]['price']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
              const SizedBox(height: 30),
              // Center(
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: const Color(0xFF2874F0),
              //         padding: const EdgeInsets.symmetric(vertical: 16),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(12),
              //         ),
              //       ),
              //       onPressed: () {
              //         // Action for start
              //       },
              //       child: const Text("Let's Started", style: TextStyle(fontSize: 16)),
              //     ),
              //   ),
              // )

              Container(
                width: 380.w,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(GetRouteNames.LoginRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Reclaimcolors.BasicBlue,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Lets Started",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Reclaimcolors.BasicWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
