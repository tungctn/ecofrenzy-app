class Post {
  final String id;
  final String image;
  final String userId;
  final String challenge;
  final String impact;

  Post(
      {required this.id,
      required this.image,
      required this.userId,
      required this.challenge,
      required this.impact});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      // caption: json['caption'],
      id: json['id'],
      image: json['image'],
      userId: json['userId'],
      challenge: json['challenge'],
      impact: json['impact'],
    );
  }
}
