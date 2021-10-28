class User {
  final String email;
  final String username;
  final String? imagePath;
  final bool isActive;

  User({
    required this.email,
    required this.username,
    this.imagePath,
    required this.isActive,
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
        imagePath = null,
        isActive = true;
}
