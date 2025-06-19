import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

class ReclaimButton extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final String title;
  final double titleSize;
  final String? iconPath; // Nullable icon
  final bool isLoading;
  final VoidCallback onPressed;
  final FontWeight fontWeight;
  final Color? titleColor;

  const ReclaimButton({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.title,
    this.titleColor =  Reclaimcolors.BasicBlack,
    required this.fontWeight,
    this.titleSize = 16,
    this.iconPath,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed, // Disable tap when loading
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          border: Border.all(
                    color: Reclaimcolors.BasicBlack.withOpacity(0.1),
                    style: BorderStyle.solid,
                    width: 1.0,
                ),
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 20.w,
                height: 20.h,
                child:
                //  CircularProgressIndicator(
                //   strokeWidth: 2,
                //   color: Colors.black,
                // ),
               const   SpinKitDoubleBounce(
              color:Reclaimcolors.BasicWhite,
              size: 20.0,
),
              )
            else ...[
              if (iconPath != null) ...[
                SvgPicture.asset(iconPath!, height: 20.h),
                SizedBox(width: 10.w),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize.sp,
                  fontWeight: fontWeight,
                  // FontWeight.bold,
                  color: titleColor
                  // Colors.black,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
