// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class InAppPurchasesController extends GetxController {
//   RxInt selectedIndex = 0.obs;

//   void selectPlan(int index) {
//     selectedIndex.value = index;
//   }
// }



import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InAppPurchasesController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void selectPlan(int index) {
    selectedIndex.value = index;
  }

  List<List<Map<String, String>>> features = [
    [
      {
        'title': 'Monthly feature 1',
        'subtitle': 'Lorem ipsum dolor sit amet, consectetur adipiscing.'
      },
      {
        'title': 'Monthly feature 2',
        'subtitle': 'Lorem ipsum dolor sit amet sed do eiusmod tempor.'
      },
      {
        'title': 'Monthly feature 3',
        'subtitle': 'Lorem ipsum dolor sit amet sed do eiusmod tempor.'
      },
    ],
    [
      {
        'title': 'Yearly feature 1',
        'subtitle': 'Sed do eiusmod tempor incididunt ut labore.'
      },
      {
        'title': 'Yearly feature 2',
        'subtitle': 'Ut enim ad minim veniam, quis nostrud exercitation.'
      },
      {
        'title': 'Yearly feature 3',
        'subtitle': 'Duis aute irure dolor in reprehenderit in voluptate.'
      },
    ],
  ];
}