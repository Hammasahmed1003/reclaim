import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:reclaim/MVC/Models/NotificationModel.dart';
import 'package:reclaim/appServices/ApiServices.dart';

class NotificationController extends GetxController {
  final apiService = ApiService();

  var notifications = <NotificationModel>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final response = await apiService.getRequestwithtoken("notifications");
      if (response != null && response.statusCode == 200) {
        final data = response.data['data'] as List;
        notifications.value = data
            .map((json) => NotificationModel.fromJson(json))
            .toList();
      } else {
        hasError.value = true;
      }
    } catch (e) {
      hasError.value = true;
      print("Error fetching notifications: \$e");
    } finally {
      isLoading.value = false;
    }
  }
}
