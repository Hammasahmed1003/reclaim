// class AffirmationModel {
//   final int id;
//   final String title;
//   final String description;
//   final String showDate;

//   AffirmationModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.showDate,
//   });

//   factory AffirmationModel.fromJson(Map<String, dynamic> json) {
//     return AffirmationModel(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       showDate: json['show_date'],
//     );
//   }
// }


class Affirmation {
  final String title;
  final String description;

  Affirmation({required this.title, required this.description});

  factory Affirmation.fromJson(Map<String, dynamic> json) {
    return Affirmation(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
