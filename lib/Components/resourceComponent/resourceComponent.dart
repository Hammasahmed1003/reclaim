import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class ResourcesComponent extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const ResourcesComponent({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      margin: EdgeInsets.only(left: 16.w, right: 8.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Reclaimcolors.BasicWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Reclaimcolors.BasicBlue.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with fallback
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 130.h,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return SizedBox(
                  height: 130.h,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Reclaimcolors.BasicBlue,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  height: 130.h,
                  child: Center(
                    child: Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 8.h),

          // Title
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 4.h),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black54,
            ),
          ),

          SizedBox(height: 6.h),

          // Bookmark & Share Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _iconButton( Colors.blue),
              SizedBox(width: 10.w),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconButton(Color color) {
    return SpringWidget(
      onTap: () {
        // Add action here
      },
      child: SvgPicture.asset(ReclaimIcon.BookMarked, 
      color: Reclaimcolors.BasicBlue,
      ),
    );
  }
}
