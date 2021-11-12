class User {
  final String username;
  final String? email;
  final String? imagePath;
  final bool isActive;

  User({
    required this.username,
    this.email,
    this.imagePath,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'imagePath': imagePath,
        'isActive': isActive,
      };

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        username = json['username'],
        imagePath = json['imagePath'],
        isActive = json['isActive'] ?? true;
}
