import 'package:get/get.dart';
import 'package:reclaim/Components/CommonComponents/PanicDailog.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';

class Bottomnavcontroller extends GetxController {
  // Initial index for Home
  var currentIndex = 0.obs;

  // Update the selected index
  void changeIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> fetchPanicTask(context) async {
    final body = {""};

    try {
      final token = await SharedPrefService.getUserToken();
      final response = await ApiService()
          .postRequestWithToken("generate", body as Map<String, dynamic>);

      if (response != null &&
          response.statusCode == 200 &&
          response.data['error'] == false) {
        final task = response.data['data'];
        panicDialog(context, task);
      } else {
        Get.snackbar("Error", "Failed to start panic task");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print("❌ Panic Task Error: $e");
    }
  }
}
