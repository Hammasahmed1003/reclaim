// // class PostDetailModel {
// //   final int id;
// //   final String? title;
// //   final String? content;
// //   final String? image;
// //   final String? createdAt;
// //   final int totalLikes;
// //   final int totalComments;
// //   final bool isLiked;
// //   final String userAvatar;
// //   final List<CommentModel> comments;

// //   PostDetailModel({
// //     required this.id,
// //     this.title,
// //     this.content,
// //     this.image,
// //     this.createdAt,
// //     required this.totalLikes,
// //     required this.totalComments,
// //     required this.isLiked,
// //     required this.userAvatar,
// //     required this.comments,
// //   });

// //   factory PostDetailModel.fromJson(Map<String, dynamic> json) {
// //     return PostDetailModel(
// //       id: json['id'],
// //       title: json['title'],
// //       content: json['content'],
// //       image: json['image'],
// //       createdAt: json['created_at'],
// //       totalLikes: json['total_likes'] ?? 0,
// //       totalComments: json['total_comments'] ?? 0,
// //       isLiked: json['is_liked'] ?? false,
// //       userAvatar: json['user']?['avatar'] ?? '',
// //       comments: (json['comments'] as List)
// //           .map((e) => CommentModel.fromJson(e))
// //           .toList(),
// //     );
// //   }
// // }

// // class CommentModel {
// //   final int id;
// //   final String comment;
// //   final String createdAt;
// //   final int totalLikes;
// //   final bool isLiked;
// //   final String userAvatar;

// //   CommentModel({
// //     required this.id,
// //     required this.comment,
// //     required this.createdAt,
// //     required this.totalLikes,
// //     required this.isLiked,
// //     required this.userAvatar,
// //   });

// //   factory CommentModel.fromJson(Map<String, dynamic> json) {
// //     return CommentModel(
// //       id: json['id'],
// //       comment: json['comment'],
// //       createdAt: json['created_at'],
// //       totalLikes: json['total_likes'] ?? 0,
// //       isLiked: json['is_liked'] ?? false,
// //       userAvatar: json['user']?['avatar'] ?? '',
// //     );
// //   }
// // }

// // new

// class PostDetailModel {
//   final int id;
//   final String? title;
//   final String? content;
//   final String? image;
//   final String createdAt;
//   final int totalLikes;
//   final int totalComments;
//   final bool isLiked;
//   final UserModel user;
//   final List<CommentModel> comments;

//   PostDetailModel({
//     required this.id,
//     this.title,
//     this.content,
//     this.image,
//     required this.createdAt,
//     required this.totalLikes,
//     required this.totalComments,
//     required this.isLiked,
//     required this.user,
//     required this.comments,
//   });

//   factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
//       PostDetailModel(
//         id: json['id'],
//         title: json['title'],
//         content: json['content'],
//         image: json['image'],
//         createdAt: json['created_at'],
//         totalLikes: json['total_likes'],
//         totalComments: json['total_comments'],
//         isLiked: json['is_liked'],
//         user: UserModel.fromJson(json['user']),
//         comments: List<CommentModel>.from(
//           json['comments'].map((x) => CommentModel.fromJson(x)),
//         ),
//       );
// }

// class UserModel {
//   final int id;
//   final String avatar;

//   UserModel({required this.id, required this.avatar});

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json['id'],
//         avatar: json['avatar'],
//       );
// }

// class CommentModel {
//   final int id;
//   final String comment;
//   final String createdAt;
//   final int totalLikes;
//   final bool isLiked;
//   final UserModel user;

//   CommentModel({
//     required this.id,
//     required this.comment,
//     required this.createdAt,
//     required this.totalLikes,
//     required this.isLiked,
//     required this.user,
//   });

//   factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
//         id: json['id'],
//         comment: json['comment'],
//         createdAt: json['created_at'],
//         totalLikes: json['total_likes'],
//         isLiked: json['is_liked'],
//         user: UserModel.fromJson(json['user']),
//       );
// }
