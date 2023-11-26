class Profile {
  // final String caption;
  final String fullName;
  final String bio;
  final int point;
  final int friendCount;
  final List<int> activities;
  final List<int> photos;
  final List<int> videos;

  Profile({
    required this.fullName,
    required this.bio,
    required this.point,
    required this.friendCount,
    required this.activities,
    required this.photos,
    required this.videos,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        fullName: json['fullName'],
        bio: json['bio'],
        point: json['point'],
        friendCount: json['friendCount'],
        activities: json['activities'],
        photos: json['photos'],
        videos: json['videos']);
  }
}
