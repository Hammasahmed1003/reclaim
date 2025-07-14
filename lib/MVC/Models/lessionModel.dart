// // class LessonModel {
// //   final int id;
// //   final String title;
// //   final String description;
// //   final String avatar;
// //   final String status;
// //   final String createdAt;
// //   final String updatedAt;
// //   final int isSave;

// //   LessonModel({
// //     required this.id,
// //     required this.title,
// //     required this.description,
// //     required this.avatar,
// //     required this.status,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     required this.isSave,
// //   });

// //   factory LessonModel.fromJson(Map<String, dynamic> json) {
// //     return LessonModel(
// //       id: json['id'],
// //       title: json['title'],
// //       description: json['description'],
// //       avatar: json['avatar'],
// //       status: json['status'],
// //       createdAt: json['created_at'],
// //       updatedAt: json['updated_at'],
// //       isSave: json['is_save'],
// //     );
// //   }
// // }


// import 'package:get/get.dart';

// class LessonModel {
//   final int id;
//   final String title;
//   final String description;
//   final String avatar;
//   RxInt isSave; // ← make observable

//   LessonModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.avatar,
//     required int isSave,
//   }) : isSave = isSave.obs;

//   factory LessonModel.fromJson(Map<String, dynamic> json) {
//     return LessonModel(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       avatar: json['avatar'],
//       isSave: json['is_save'] ?? 0,
//     );
//   }
// }


import 'package:get/get.dart';

// class LessonModel {
//   final int id;
//   final String title;
//   final String description;
//   final String avatar;
//   RxInt isSave;

//   LessonModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.avatar,
//     required int isSave,
//   }) : isSave = isSave.obs;

//   factory LessonModel.fromJson(Map<String, dynamic> json) {
//     return LessonModel(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       avatar: json['avatar'],
//       isSave: json['is_save'] ?? 0,
//     );
//   }
// }



class LessonModel {
  final int id;
  final String title;
  final String description;
  final String avatar;
  final String video;
  RxInt isSave;

  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.avatar,
    required this.video,
    required int isSave,
  }) : isSave = isSave.obs;

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      avatar: json['avatar'],
      video: json['video'] ?? "",
      isSave: json['is_save'] ?? 0,
    );
  }
}
