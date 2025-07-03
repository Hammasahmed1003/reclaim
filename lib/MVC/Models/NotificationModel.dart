// class NotificationModel {
//   final int id;
//   final String type;
//   final String title;
//   final String message;
//   final String status;
//   final String createdAt;
//   final String? imageUrl;
//   final String username;

//   NotificationModel({
//     required this.id,
//     required this.type,
//     required this.title,
//     required this.message,
//     required this.status,
//     required this.createdAt,
//     required this.username,
//     this.imageUrl,
//   });

//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       id: json['id'],
//       type: json['type'],
//       title: json['title'],
//       message: json['message'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       username: json['sender']['email'],
//       imageUrl: json['related']?['image'] != null
//           ? "https://yourdomain.com/${json['related']['image']}"
//           : null,
//     );
//   }
// }

class NotificationModel {
  final int id;
  final String userId;
  final String senderId;
  final String type;
  final String title;
  final String message;
  final String status;
  final int? relatedId;
  final String? relatedType;
  final String? data;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UsersModel? user;
  final UsersModel? sender;
  final RelatedModel? related;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.senderId,
    required this.type,
    required this.title,
    required this.message,
    required this.status,
    this.relatedId,
    this.relatedType,
    this.data,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.sender,
    this.related,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      userId: json['user_id'].toString(),
      senderId: json['sender_id'].toString(),
      type: json['type'],
      title: json['title'],
      message: json['message'],
      status: json['status'],
      relatedId: json['related_id'] != null ? int.tryParse(json['related_id'].toString()) : null,
      relatedType: json['related_type'],
      data: json['data'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: json['user'] != null ? UsersModel.fromJson(json['user']) : null,
      sender: json['sender'] != null ? UsersModel.fromJson(json['sender']) : null,
      related: json['related'] != null ? RelatedModel.fromJson(json['related']) : null,
    );
  }
}

class UsersModel {
  final int id;
  final String email;
  final String? deviceToken;

  UsersModel({
    required this.id,
    required this.email,
    this.deviceToken,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'],
      email: json['email'],
      deviceToken: json['device_token'],
    );
  }
}

class RelatedModel {
  final int id;
  final String userId;
  final String? title;
  final String? content;
  final String? image;

  RelatedModel({
    required this.id,
    required this.userId,
    this.title,
    this.content,
    this.image,
  });

  factory RelatedModel.fromJson(Map<String, dynamic> json) {
    return RelatedModel(
      id: json['id'],
      userId: json['user_id'].toString(),
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }
}
