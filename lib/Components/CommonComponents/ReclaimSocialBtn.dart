import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';

// class SocialLoginButtons extends StatelessWidget {
//   final VoidCallback onGoogleTap;
//   final VoidCallback onAppleTap;
//   // final VoidCallback onFacebookTap;

//   const SocialLoginButtons({
//     Key? key,
//     required this.onGoogleTap,
//     required this.onAppleTap,
//     // required this.onFacebookTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SpringWidget(
//           onTap: onGoogleTap,
//           child: Container(
//             height: 40.h,
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//             decoration: BoxDecoration(
//               color: Reclaimcolors.BlueSecondary,
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Reclaimcolors.BasicBlue, width: 1),
//             ),
//             child: Container(

//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(Reclaimimages.GoogleImage),
//                   const SizedBox(width: 10),
//                   const Text(
//                     "Continue With Google",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//                 onTap: onAppleTap, child: Row(
//                    mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(Reclaimimages.AppleImage),
//                   ],
//                 )
//                 // SvgPicture.asset(ReclaimIcon.AppleIcon, height: 30), // Replace with your Apple icon
//                 ),
//             const SizedBox(width: 20),
//             // Container(
//             //   height: 30,
//             //   width: 1.5,
//             //   color: Colors.grey,
//             // ),
//             const SizedBox(width: 30),
//             // GestureDetector(
//             //   onTap: onFacebookTap,
//             //   child: Image.asset(
//             //     Reclaimimages.FaceBookIcon
//             //   )

//             // ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimImages.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;

  const SocialLoginButtons({
    Key? key,
    required this.onGoogleTap,
    required this.onAppleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Android → show only Google
    if (Platform.isAndroid) {
      return SpringWidget(
        onTap: onGoogleTap,
        child: Container(
          height: 45.h,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Reclaimcolors.BlueSecondary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Reclaimcolors.BasicBlue.withOpacity(0.2), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   Reclaimimages.GoogleImage,
              //   height: 20,
              // ),

              const SizedBox(width: 8),

              SvgPicture.asset(
                ReclaimIcon.g,
                width: 20,
              ),
              const SizedBox(width: 8),

              const Text(
                "Continue With Google",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              // const SizedBox(width: 8),
            ],
          ),
        ),
      );
    }

    // iOS → show Google and Apple side by side
    if (Platform.isIOS) {
      return Row(
        children: [
          // Google Button
          Expanded(
            child: SpringWidget(
              onTap: onGoogleTap,
              child: Container(
                height: 45.h,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Reclaimcolors.BlueSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Reclaimcolors.BasicBlue.withOpacity(0.2),
                      width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ReclaimIcon.g),
                    const SizedBox(width: 8),
                    const Text(
                      "Google",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // Apple Button
          Expanded(
            child: SpringWidget(
              onTap: onAppleTap,
              child: Container(
                height: 45.h,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Reclaimcolors.BlueSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Reclaimcolors.BasicBlue, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(ReclaimIcon.a),
                    const SizedBox(width: 8),
                    const Text(
                      "Apple",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Other platforms (Web, desktop) → show nothing or just Google
    return const SizedBox.shrink();
  }
}
