import 'package:get/get_rx/src/rx_types/rx_types.dart';

class PostDetailModel {
  final int id;
  final String? title;
  final String? content;
  final String? image;
  final int totalLikes;
  final int totalComments;
  final bool isLiked;
  final UserModel user;
  final List<CommentModel> comments;

  PostDetailModel({
    required this.id,
    this.title,
    this.content,
    this.image,
    required this.totalLikes,
    required this.totalComments,
    required this.isLiked,
    required this.user,
    required this.comments,
  });

  factory PostDetailModel.fromJson(Map<String, dynamic> json) {
    return PostDetailModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      totalLikes: json['total_likes'],
      totalComments: json['total_comments'],
      isLiked: json['is_liked'],
      user: UserModel.fromJson(json['user']),
      comments: (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList(),
    );
  }
}

class UserModel {
  final int id;
  final String avatar;
  final String name;

  UserModel({
    required this.id,
    required this.avatar,
    required this.name
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json["name"],
      avatar: json['avatar'],
    );
  }
}

// class CommentModel {
//   final String comment;
//   final UserModel user;

//   CommentModel({
//     required this.comment,
//     required this.user,
//   });

//   factory CommentModel.fromJson(Map<String, dynamic> json) {
//     return CommentModel(
//       comment: json['comment'],
//       user: UserModel.fromJson(json['user']),
//     );
//   }
// class CommentModel {
//   final int id;
//   final String comment;
//   final UserModel user;
//   // final int likesCount;
//   final bool isLiked;

//   CommentModel({
//     required this.id,
//     required this.comment,
//     required this.user,
//     // required this.likesCount,
//     required this.isLiked,
//   });

//   factory CommentModel.fromJson(Map<String, dynamic> json) {
//     return CommentModel(
//       id: json['id'],
//       comment: json['comment'],
//       user: UserModel.fromJson(json['user']),
//       // likesCount: json['likes_count'] ?? 0,
//       isLiked: json['is_liked'] ?? false,
//     );
//   }
// }
class CommentModel {
  final int id;
  final String comment;
  final UserModel user;
  final RxBool isLiked;

  CommentModel({
    required this.id,
    required this.comment,
    required this.user,
    required bool isLiked,
  }) : isLiked = isLiked.obs;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      comment: json['comment'],
      user: UserModel.fromJson(json['user']),
      isLiked: json['is_liked'] ?? false,
    );
  }
}



