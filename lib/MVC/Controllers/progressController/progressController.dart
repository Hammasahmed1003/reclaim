import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class ProgressController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentLevel = 1.obs;
  RxInt totalLevels = 5.obs; // you can update this dynamically if needed

  @override
  void onInit() {
    super.onInit();
    fetchProgress();
  }

  Future<void> fetchProgress() async {
    try {
      final response = await ApiService().getRequestwithtoken("my-progress");

      if (response != null && response.statusCode == 200) {
        final data = response.data["data"];
        currentLevel.value = int.tryParse(data["level"] ?? "1") ?? 1;
        // optionally: totalLevels.value = computeFromPoints(data["points"]);
      }
    } catch (e) {
      print("Error fetching progress: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
