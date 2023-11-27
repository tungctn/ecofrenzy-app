class Challenge {
  final String id;
  final String name;
  final int point;
  final String category;
  // final String impact;
  final String description;
  final String level;
  final String status;
  // final String creativity;
  final String caption;
  // final List<Verification> verification;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final List<dynamic> implemetation;
  final List<dynamic> verification;

  Challenge({
    required this.id,
    required this.name,
    required this.point,
    required this.category,
    // required this.impact,
    required this.description,
    required this.level,
    required this.status,
    // required this.creativity,
    required this.caption,
    required this.verification,
    // required this.createdAt,
    // required this.updatedAt,
    required this.implemetation,
  });

  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['_id'],
      name: json['name'],
      point: json['point'],
      category: json['category'],
      // impact: json['impact'],
      description: json['description'],
      level: json['level'],
      status: json['status'],
      // creativity: json['creativity'],
      caption: json['caption'],
      // verification: json['verification']
      //     .map<Verification>(
      //         (dynamic verification) => Verification.fromJson(verification))
      //     .toList(),
      // createdAt: DateTime.parse(json['createdAt']),
      // updatedAt: DateTime.parse(json['updatedAt']),
      implemetation: json['implementation'],
      verification: json['verification'],
    );
  }
}

class Verification {
  final String question;
  final String desiredAnswer;

  Verification({
    required this.question,
    required this.desiredAnswer,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      question: json['question'],
      desiredAnswer: json['desiredAnswer'],
    );
  }
}
