import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reclaim/appServices/ApiServices.dart';
import 'package:reclaim/appServices/SharedPrefService.dart';

// class InProgressController extends GetxController {
//   final apiService = ApiService();

//   var isLoading = false.obs;
//   var commitments = [].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchInProgressCommitments();
//   }

//   Future<void> fetchInProgressCommitments() async {
//     isLoading.value = true;

//     final response = await apiService.getRequestwithtoken("my-commitments");

//     if (response != null && response.statusCode == 200) {
//       final dataList = response.data['data'] as List;
//       commitments.value = dataList.map((item) {
//         return {
//           "username": "User_${item['user_id']}",
//           "timeAgo": "Just now", // You can add time calculation later
//           "imageUrl":
//               "https://placehold.co/600x400", // Placeholder or use avatar if available
//           "description": item["description"],
//           "id": item["id"],
//           "isFulfilled": item["status"] != "inprogress",
//         };
//       }).toList();
//     }

//     isLoading.value = false;
//   }

//   Future<void> markCommitmentFulfilled(int id) async {
//     isLoading.value = true;

//     final body = {"status": "fulfilled", "id": id};

//     try {
//       // final token = await SharedPrefService.getUserToken(); // if needed
//       final response = await apiService.postRequestWithToken(
//         "commitments-update-status",
//         body,
//         // headers: token
//       );

//       if (response != null && response.data["error"] == false) {
//         // Refresh data
//         await fetchInProgressCommitments(); // your function to reload list
//       } else {
//         Get.snackbar("Error", response?.data["message"] ?? "Update failed",
//             backgroundColor: Colors.red, colorText: Colors.white);
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Something went wrong",
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }


class InProgressController extends GetxController {
  final apiService = ApiService();

  var isLoading = false.obs;
  var inProgressCommitments = [].obs;
  var fulfilledCommitments = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCommitments();
  }

  Future<void> fetchCommitments() async {
    isLoading.value = true;

    final response = await apiService.getRequestwithtoken("my-commitments");

    if (response != null && response.statusCode == 200) {
      final dataList = response.data['data'] as List;

      // Split commitments based on status
      inProgressCommitments.value = dataList
          .where((item) => item['status'] == 'inprogress')
          .map((item) => {
                "username": "User_${item['user_id']}",
                "timeAgo": "Just now", // TODO: add time logic later
                "imageUrl": "https://placehold.co/600x400",
                "description": item["description"],
                "id": item["id"],
                "isFulfilled": false,
              })
          .toList();

      fulfilledCommitments.value = dataList
          .where((item) => item['status'] == 'fulfilled')
          .map((item) => {
                "username": "User_${item['user_id']}",
                "timeAgo": "Just now", // TODO: add time logic later
                "imageUrl": "https://placehold.co/600x400",
                "description": item["description"],
                "id": item["id"],
                "isFulfilled": true,
              })
          .toList();
    }

    isLoading.value = false;
  }

  Future<void> markCommitmentFulfilled(int id) async {
    isLoading.value = true;

    final body = {"status": "fulfilled", "id": id};

    try {
      final response = await apiService.postRequestWithToken(
        "commitments-update-status",
        body,
      );

      if (response != null && response.data["error"] == false) {
        await fetchCommitments();
      } else {
        Get.snackbar("Error", response?.data["message"] ?? "Update failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
