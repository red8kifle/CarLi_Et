class UserEntity {
  final int id;
  final String email;
  final String role;
  final String? fullName;
  final String token;
  const UserEntity({
    required this.id,
    required this.email,
    required this.role,
    this.fullName,
    required this.token,
  });
  bool get isStudent => role == 'student';
  bool get isCompany => role == 'company';
}
