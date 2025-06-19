import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class LevelProgressTracker extends StatelessWidget {
  final int totalLevels;
  final int currentLevel;

  const LevelProgressTracker({
    super.key,
    required this.totalLevels,
    required this.currentLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        // Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Colors.blue.shade50, Colors.white],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),
        // ),

        // Main Content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Castle at the Top
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  ReclaimIcon.castle,
                  // height: 80,
                ),
              ),

            

              // Level Steps
              Expanded(
                child: Column(
                  children: List.generate(totalLevels, (index) {
                    bool isCompleted = index < currentLevel;
                    bool isCurrent = index == currentLevel;

                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: EdgeInsets.only(left: index * 25.0, 
                            top: index * 1,
                            bottom: index * 1,
                            ), // Staggered Effect
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Current Level Icon
                                if (isCurrent)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0, 
                                    
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child:
                                      SvgPicture.asset(ReclaimIcon.RLogo)
                                      //  Icon(
                                      //   Icons.check_circle,
                                      //   color: Colors.blue.shade900,
                                      //   size: 24,
                                      // ),
                                    ),
                                  ),

                                // Level Box
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isCompleted
                                          ?Reclaimcolors.BasicBlue
                                          : Reclaimcolors.BasicBlue.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Level ${index + 1} ",
                                        style: TextStyle(
                                          color: isCompleted
                                              ? Colors.white
                                              : Colors.blue.shade900,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).reversed.toList(), // Reverse to start from bottom
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
