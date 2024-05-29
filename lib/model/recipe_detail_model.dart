class RecipeDetailModel {
  final String id;
  final String title;
  final String userId;
  final String userName;
  final String userImage;
  final String timeStamp;
  final String description;
  final String imageUrl;
  final String ingredients;
  final String steps;
  final bool verified;

  RecipeDetailModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.timeStamp,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.verified,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailModel(
      id: json['id'],
      title: json['title'],
      userId: json['user_id'],
      userName: json['user_name'],
      userImage: json['user_image'],
      timeStamp: json['timestamp'],
      description: json['description'],
      imageUrl: json['image_url'],
      ingredients: json['ingredients'],
      steps: json['steps'],
      verified: json['verified'],
    );
  }
}
