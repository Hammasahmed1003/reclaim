import 'package:get/get.dart';

class Bottomnavcontroller extends GetxController {
    // Initial index for Home
  var currentIndex = 0.obs;

  // Update the selected index
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}