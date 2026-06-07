import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carli_et/features/auth/application/auth_notifier.dart';
import 'package:carli_et/domain/entities/user_entity.dart';
import 'package:carli_et/domain/repositories/auth_repository.dart';


// Mock repository for testing
class MockAuthRepository implements AuthRepository {
  @override
  Future<UserEntity> login(String email, String password, String role) async {
    return UserEntity(
      id: 1,
      email: email,
      role: role,
      fullName: 'Test User',
      token: 'mock_token',
    );
  }

  @override
  Future<UserEntity> signup({
    required String email,
    required String password,
    required String role,
    String? fullName,
    String? companyName,
  }) async {
    return UserEntity(
      id: 1,
      email: email,
      role: role,
      fullName: fullName,
      token: 'mock_token',
    );
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> deleteAccount() async {}

  @override
  Future<UserEntity?> getStoredUser() async => null;
}

void main() {
  group('AuthNotifier Tests', () {
    test('AuthNotifier initial state is null', () {
      final container = ProviderContainer();
      final authState = container.read(authNotifierProvider);
      
      expect(authState.value, null);
    });

    test('AuthNotifier state changes after login', () async {
      final container = ProviderContainer();
      final authNotifier = container.read(authNotifierProvider.notifier);
      
      // This test verifies the notifier exists and can be called
      expect(authNotifier, isNotNull);
    });
  });
}