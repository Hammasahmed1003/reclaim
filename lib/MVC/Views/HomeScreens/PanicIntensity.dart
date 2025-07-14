import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/ReclaimButton.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/MVC/Controllers/HomeControllers/PanicIntensityController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class Panicintensity extends StatefulWidget {
  const Panicintensity({super.key});

  @override
  State<Panicintensity> createState() => _PanicintensityState();
}

class _PanicintensityState extends State<Panicintensity> {
  final controller = Get.put(PanicIntensityController());

  final List<String> categories = [
    'mental',
    'physical',
    'breathing',
    'habit',
    'random'
  ];
  final List<String> intensities = ['light', 'moderate', 'deep'];

  bool showCategoryOptions = false;
  bool showIntensityOptions = false;

  @override
  Widget build(BuildContext context) {
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
              gradient: const LinearGradient(
                colors: [Reclaimcolors.BlueSecondary, Color(0xffffffff)],
                stops: [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
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
                                child: SvgPicture.asset(ReclaimIcon.Back),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Intensity Selection",
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

                    const SizedBox(height: 40),

                    // Category Dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "TASK CATEGORY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildAnimatedDropdown(
                      title: controller.selectedCategory.value.capitalizeFirst!,
                      showOptions: showCategoryOptions,
                      onTap: () {
                        setState(() {
                          showCategoryOptions = !showCategoryOptions;
                          showIntensityOptions = false;
                        });
                      },
                      options: categories,
                      selectedOption: controller.selectedCategory.value,
                      onOptionSelected: (value) {
                        controller.setCategory(value);
                        setState(() {
                          showCategoryOptions = false;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    // Intensity Dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "TASK INTENSITY",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildAnimatedDropdown(
                      title:
                          controller.selectedIntensity.value.capitalizeFirst!,
                      showOptions: showIntensityOptions,
                      onTap: () {
                        setState(() {
                          showIntensityOptions = !showIntensityOptions;
                          showCategoryOptions = false;
                        });
                      },
                      options: intensities,
                      selectedOption: controller.selectedIntensity.value,
                      onOptionSelected: (value) {
                        controller.setIntensity(value);
                        setState(() {
                          showIntensityOptions = false;
                        });
                      },
                    ),

                    const Spacer(),

                    // Save Button
                    // Padding(
                    //   padding: const EdgeInsets.all(20),
                    //   child: controller.isLoading.value
                    //       ? const Center(child: CircularProgressIndicator())
                    //       : ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //             backgroundColor: Reclaimcolors.BasicBlue,
                    //             minimumSize: Size(double.infinity, 50),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(15),
                    //             ),
                    //           ),
                    //           onPressed: () => controller.submitTaskCategory(),
                    //           child: Text(
                    //             "Save",
                    //             style: TextStyle(
                    //               fontSize: 16.sp,
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Obx(
                        () => ReclaimButton(
                            isLoading: controller.isLoading.value,
                            width: 340.w,
                            titleColor: Reclaimcolors.BasicWhite,
                            height: 45.h,
                            backgroundColor: Reclaimcolors.BasicBlue,
                            title: "Save Changes",
                            fontWeight: FontWeight.w400,
                            onPressed: controller.submitTaskCategory),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedDropdown({
    required String title,
    required bool showOptions,
    required VoidCallback onTap,
    required List<String> options,
    required String selectedOption,
    required Function(String) onOptionSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Column(
          key: ValueKey(showOptions),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16.sp)),
                    Icon(
                      showOptions
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
            if (showOptions)
              ...options.map((opt) {
                final isSelected = opt == selectedOption;
                return GestureDetector(
                  onTap: () => onOptionSelected(opt),
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Reclaimcolors.BlueSecondary.withOpacity(0.2)
                          : Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? Reclaimcolors.BasicBlue
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(opt.capitalizeFirst!,
                            style: TextStyle(fontSize: 15.sp)),
                        if (isSelected)
                          Icon(Icons.check, color: Colors.green, size: 20),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
