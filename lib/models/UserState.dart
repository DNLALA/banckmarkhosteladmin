class User {
  final String id;
  final String username;
  final String regNo;
  final String email;
  final bool isStudent;
  final bool isWarden;
  final bool isActive;
  final bool hasHotel;
  final DateTime createdAt;
  final DateTime? lastLogin; // Make lastLogin nullable
  final String tokens;

  User({
    required this.id,
    required this.username,
    required this.regNo,
    required this.email,
    required this.isStudent,
    required this.isWarden,
    required this.isActive,
    required this.hasHotel,
    required this.createdAt,
    this.lastLogin,
    required this.tokens,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      regNo: json['reg_no'] ?? '',
      email: json['email'] ?? '',
      isStudent: json['is_student'] ?? false,
      isWarden: json['is_warden'] ?? false,
      isActive: json['is_active'] ?? false,
      hasHotel: json['has_hostel'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
      tokens: json['tokens'] ?? '',
    );
  }
}
