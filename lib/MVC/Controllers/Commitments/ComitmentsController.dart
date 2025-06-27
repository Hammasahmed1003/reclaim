import 'package:get/get.dart';

class Comitmentscontroller extends GetxController{

    var selectedTabIndex = 0.obs; // Observing tab index

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }



  
}