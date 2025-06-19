import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CommunityController extends GetxController {
  var selectedTabIndex = 0.obs; // Observing tab index

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
