import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:reclaim/appConstants/ReclaimIcons.dart';
import 'package:reclaim/appServices/getRouteNames.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Reclaimcolors.BlueSecondary,
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(width: 10),
                  const Text("James", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(height: 20),
              ..._drawerItems.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child:
                     Container(
                        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(33),
                gradient: const LinearGradient(
                  colors: [
                    Reclaimcolors.BlueSecondary,
                    const Color(0xffffffff)
                  ],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                       child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        tileColor: Colors.white,
                        leading: SvgPicture.asset(item['icon']!),
                        title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        onTap: () => Get.toNamed(item['route']!),
                                           ),
                     ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> get _drawerItems => [
        // {'icon': ReclaimIcon.messages, 'title': 'Messages', 'route': GetRouteNames.MessageScreen},
        {'icon': ReclaimIcon.saveIcon, 'title': 'Saved Lessons', 'route': GetRouteNames.Savedlesson},
        {'icon': ReclaimIcon.handshake, 'title': 'My Commitments', 'route': GetRouteNames.Commitmentscreen},
        {'icon': ReclaimIcon.Settings, 'title': 'Badges', 'route': GetRouteNames.Badgescreen},
        // {'icon': ReclaimIcon.Settings, 'title': 'Settings', 'route': GetRouteNames.Settingscreen},
        // {'icon': ReclaimIcon.accounts, 'title': 'My Account', 'route': GetRouteNames.Editprofile},
        // {'icon': ReclaimIcon.help, 'title': 'Help', 'route': GetRouteNames.Helpscreen},
      ];
}
