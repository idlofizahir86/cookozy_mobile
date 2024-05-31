class UserModel {
  final String id;
  final String email;
  final String nama;
  final String imageUrl;
  final String role;

  UserModel({
    required this.id,
    required this.imageUrl,
    required this.nama,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      role: json['role'],
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      nama: '',
      email: '',
      imageUrl: '',
      role: '',
    );
  }
}
