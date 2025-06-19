import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';

class SettingComponents extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  const SettingComponents({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SpringWidget(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
        padding: EdgeInsets.symmetric( horizontal: 16.w),
        decoration: BoxDecoration(
          color: Reclaimcolors.BasicWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow:  [
            BoxShadow(
              color:Reclaimcolors.BasicBlue.withOpacity(0.4),
              blurRadius: 0,
              spreadRadius: 0,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            iconPath,
            width: 24.w,
            height: 24.h,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
