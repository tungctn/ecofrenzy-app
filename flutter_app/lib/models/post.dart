class Post {
  // final String caption;
  final String image;
  final String userId;
  final String challenge;
  final String impact;

  Post(
      {required this.image,
      required this.userId,
      required this.challenge,
      required this.impact});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      // caption: json['caption'],
      image: json['image'],
      userId: json['userId'],
      challenge: json['challenge'],
      impact: json['impact'],
    );
  }
}
