// user_controller.dart
import 'package:get/get.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var userImage = ''.obs;
  var userGender = ''.obs;

  var userId = "".obs;

  void setUserId(String id) {
    userId.value = id;
  }

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  Future<void> loadUserData() async {
    userName.value = await SharedPrefService.getUserName() ?? '';
    userImage.value = await SharedPrefService.getUserImage() ?? '';
    userGender.value = await SharedPrefService.getUserGender() ?? '';
  }

  void updateUserProfile({String? name, String? image, String? gender}) {
    if (name != null) userName.value = name;
    if (image != null) userImage.value = image;
    if (gender != null) userGender.value = gender;
  }
}
