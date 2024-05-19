class RecipeModel {
  final String id;
  final String title;
  final String userId;
  final String userName;
  final String description;
  final String imageUrl;
  final String level;
  final String type;
  final bool verified;

  RecipeModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.userName,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.type,
    required this.verified,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      title: json['title'],
      userId: json['user_id'],
      userName: json['user_name'],
      description: json['description'],
      imageUrl: json['image_url'],
      level: json['level'],
      type: json['type'],
      verified: json['verified'],
    );
  }
}
