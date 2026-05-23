import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../core/network/api_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final ApiClient client;
  AuthRepositoryImpl(this.remote, this.client);

  @override
  Future<UserEntity> login(String email, String password, String role) async {
    final data = await remote.login(email, password, role);
    final user = UserEntity(
      id: data['user']['id'],
      email: data['user']['email'],
      role: data['user']['role'],
      fullName: data['user']['full_name'],
      token: data['token'],
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token);
    await prefs.setInt('userId', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('role', user.role);
    await prefs.setString('name', user.fullName ?? '');
    client.setAuthToken(user.token);
    return user;
  }

  @override
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String role,
    String? fullName,
    String? companyName,
  }) async {
    final data = await remote.signup(
      email: email,
      password: password,
      role: role,
      fullName: fullName,
      companyName: companyName,
    );
    final user = UserEntity(
      id: data['user']['id'],
      email: data['user']['email'],
      role: data['user']['role'],
      fullName: data['user']['full_name'],
      token: data['token'],
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', user.token);
    await prefs.setInt('userId', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('role', user.role);
    await prefs.setString('name', user.fullName ?? '');
    client.setAuthToken(user.token);
    return user;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    client.clearAuthToken();
  }

  @override
  Future<void> deleteAccount() async {
    await remote.deleteAccount();
    await logout();
  }

  @override
  Future<UserEntity?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return null;
    return UserEntity(
      id: prefs.getInt('userId') ?? 0,
      email: prefs.getString('email') ?? '',
      role: prefs.getString('role') ?? '',
      fullName: prefs.getString('name'),
      token: token,
    );
  }
}
