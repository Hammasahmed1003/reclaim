import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  // final VoidCallback onFacebookTap;

  const SocialLoginButtons({
    Key? key,
    required this.onGoogleTap,
    required this.onAppleTap,
    // required this.onFacebookTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpringWidget(
          onTap: onGoogleTap,
          child: Container(
            height: 48.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Reclaimcolors.BlueSecondary,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Reclaimcolors.BasicBlue, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Reclaimimages.GoogleImage),
                const SizedBox(width: 10),
                const Text(
                  "Continue With Google",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: onAppleTap, child: Image.asset(Reclaimimages.AppleImage)
                // SvgPicture.asset(ReclaimIcon.AppleIcon, height: 30), // Replace with your Apple icon
                ),
            const SizedBox(width: 20),
            // Container(
            //   height: 30,
            //   width: 1.5,
            //   color: Colors.grey,
            // ),
            const SizedBox(width: 30),
            // GestureDetector(
            //   onTap: onFacebookTap,
            //   child: Image.asset(
            //     Reclaimimages.FaceBookIcon
            //   )

            // ),
          ],
        ),
      ],
    );
  }
}
