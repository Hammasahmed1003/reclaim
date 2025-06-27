// class CommunityPostModel {
//   final int id;
//   final String? content;
//   final String? image;
//   final String userName;
//   final String avatar;
//   final int likesCount;
//   final bool isLiked;

//   CommunityPostModel({
//     required this.id,
//     required this.content,
//     required this.image,
//     required this.userName,
//     required this.avatar,
//     required this.likesCount,
//     required this.isLiked,
//   });

//   factory CommunityPostModel.fromJson(Map<String, dynamic> json) {
//     return CommunityPostModel(
//       id: json['id'],
//       content: json['content'],
//       image: json['image'],
//       userName: json['user']['profile']['name'],
//       avatar: json['user']['profile']['avatar'],
//       likesCount: json['likes_count'],
//       isLiked: json['is_liked'],
//     );
//   }
// }

class CommunityPostModel {
  final int id;
  final String? title;
  final String? content;
  final String? image;
  final int likesCount;
  final bool isLiked;
  final List<dynamic> comments;

  // Nested user/profile info
  final int userId;
  final String userName;
  final String avatar;
  final String age;
  final String gender;
  final String phone;
  final String taskCategory;
  final String taskIntensity;
  final String riskScore;

  CommunityPostModel({
    required this.id,
    this.title,
    this.content,
    this.image,
    required this.likesCount,
    required this.isLiked,
    required this.comments,
    required this.userId,
    required this.userName,
    required this.avatar,
    required this.age,
    required this.gender,
    required this.phone,
    required this.taskCategory,
    required this.taskIntensity,
    required this.riskScore,
  });

  factory CommunityPostModel.fromJson(Map<String, dynamic> json) {
    final profile = json['user']['profile'];

    return CommunityPostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      likesCount: json['likes_count'],
      isLiked: json['is_liked'],
      comments: json['comments'] ?? [],
      userId: json['user']['id'],
      userName: profile['name'],
      avatar: profile['avatar'],
      age: profile['age'],
      gender: profile['gender'],
      phone: profile['phone'],
      taskCategory: profile['task_category'],
      taskIntensity: profile['task_intensity'],
      riskScore: profile['risk_score'],
    );
  }
}
