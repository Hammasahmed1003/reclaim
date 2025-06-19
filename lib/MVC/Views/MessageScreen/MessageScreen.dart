import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/Components/SpringWidget.dart';
import 'package:reclaim/Components/messageComponent/messageBubble.dart';
import 'package:reclaim/MVC/Controllers/MessageController/messageController.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';

class MessageScreen extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
         value: const SystemUiOverlayStyle(
        statusBarColor: Reclaimcolors.BasicBlue,
        systemNavigationBarColor: Reclaimcolors.BasicBlue,

      ),
      child: Scaffold(
       backgroundColor:  Reclaimcolors.BasicWhite,
        body: SafeArea(
          child: Column(
            children: [
           Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: const BoxDecoration(
                  color:  Reclaimcolors.BasicBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    
                  ),
                ),
                child: Center(
                  child:Row(
  children: [
    SpringWidget(
      onTap: (){
        Get.back();
      },
      child: SvgPicture.asset(ReclaimIcon.Back)),
  const  Spacer(),
    Text(
      "Messages",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Reclaimcolors.BasicWhite,
        fontSize: 22.sp,
      ),
    ),
  const  Spacer(), 
  ],
),

                ) ,
                ),
              
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 373),

                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                            verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Align(
                              alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
                              child: 
                              // Container(
                              //   margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), // Add some horizontal margin
                              //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              //   decoration: BoxDecoration(
                              //     color: message.isMe ? Reclaimcolors.BorderColor : Reclaimcolors.BasicBlue,
                              //     borderRadius: BorderRadius.circular(12),
                              //   ),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         message.text,
                              //         style: TextStyle(
                              //           color: message.isMe ? Colors.black : Colors.white,
                              //           fontSize: 14,
                              //         ),
                              //       ),
                              //       const SizedBox(height: 8), // More spacing between text and buttons
                              //       Row(
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: [
                                      
                            
                              //             SvgPicture.asset(ReclaimIcon.Liked ,
                              //               color: message.isMe ? Reclaimcolors.BasicBlue : Reclaimcolors.BlueSecondary
                              //               ),
                              //     const      SizedBox(width: 8),
                            
                                       
                            
                              //            SvgPicture.asset(ReclaimIcon.copy ,
                              //               color: message.isMe ? Reclaimcolors.BasicBlue : Reclaimcolors.BlueSecondary
                              //               ),
                            
                                        
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),
                          const    MessageBubble(
  username: "Jason217",
  message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor in magna aliqua.",
  timeAgo: "3 mins ago",
),

                            ),
                          ),
                        ),
                      );

                    },
                  ),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Reclaimcolors.BasicBlue,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          cursorColor: Reclaimcolors.BasicWhite,
                          controller: controller.messageController,
                          decoration: const InputDecoration(
                        
                            labelStyle: TextStyle(
                              color: Reclaimcolors.BasicWhite
                            ),
                            hintText: "Write any question here",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    // IconButton(
                    //   icon: SvgPicture.asset(ReclaimIcon.Sent),
                    //   onPressed: () => controller.sendMessage(controller.messageController.text, true),
                    // )
                    SpringWidget(
                      onTap: (){
                        controller.sendMessage(controller.messageController.text, true);
                      },
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: Reclaimcolors.BlueSecondary,
                        child: SvgPicture.asset(ReclaimIcon.Sent, 
                        color: Reclaimcolors.BasicBlue,
                        ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
