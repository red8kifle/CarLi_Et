import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password, String role);
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String role,
    String? fullName,
    String? companyName,
  });
  Future<void> logout();
  Future<void> deleteAccount();
  Future<UserEntity?> getStoredUser();
}
