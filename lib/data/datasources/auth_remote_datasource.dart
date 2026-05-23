import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient client;
  AuthRemoteDataSource(this.client);

  Future<Map<String, dynamic>> login(
    String email,
    String password,
    String role,
  ) async {
    final res = await client.dio.post(
      '/auth/login',
      data: {'email': email, 'password': password, 'role': role},
    );
    return res.data;
  }

  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String role,
    String? fullName,
    String? companyName,
  }) async {
    final res = await client.dio.post(
      '/auth/signup',
      data: {
        'email': email,
        'password': password,
        'role': role,
        if (fullName != null) 'full_name': fullName,
        if (companyName != null) 'company_name': companyName,
      },
    );
    return res.data;
  }

  Future<void> deleteAccount() async =>
      await client.dio.delete('/auth/account');
}
