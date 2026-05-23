import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../core/providers/providers.dart';
import '../../company/application/company_profile_provider.dart';
import '../../student/application/student_profile_provider.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, UserEntity?>(
  () => AuthNotifier(),
);

class AuthNotifier extends AsyncNotifier<UserEntity?> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  Future<UserEntity?> build() async {
    final user = await _repo.getStoredUser();
    if (user != null) {
      await _loadProfile(user);
    }
    return user;
  }

  Future<void> _loadProfile(UserEntity user) async {
    try {
      final apiClient = ref.read(apiClientProvider);
      apiClient.setAuthToken(user.token);

      final response = await apiClient.dio.get('/auth/profile/me');
      if (response.data != null) {
        if (user.isStudent) {
          ref
              .read(studentProfileProvider.notifier)
              .update(
                (state) => {
                  ...state,
                  'university': response.data['university'],
                  'skills': response.data['skills'],
                  'year': response.data['year'],
                  'gpa': response.data['gpa'],
                },
              );
        } else if (user.isCompany) {
          ref
              .read(companyProfileProvider.notifier)
              .update(
                (state) => {
                  ...state,
                  'company_name': response.data['company_name'],
                  'industry': response.data['industry'],
                  'location': response.data['location'],
                  'description': response.data['description'],
                  'logo_url': response.data['logo_url'],
                },
              );
        }
      }
    } catch (e) {
      print('Error loading profile: $e');
    }
  }

  Future<void> login(String email, String password, String role) async {
    state = const AsyncLoading();
    try {
      final user = await _repo.login(email, password, role);
      await _loadProfile(user);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String role,
    String? fullName,
    String? companyName,
  }) async {
    state = const AsyncLoading();
    try {
      final user = await _repo.signup(
        email: email,
        password: password,
        role: role,
        fullName: fullName,
        companyName: companyName,
      );
      await _loadProfile(user);
      state = AsyncData(user);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    // Clear profile data
    ref.read(companyProfileProvider.notifier).update((state) => {});
    ref.read(studentProfileProvider.notifier).update((state) => {});
    state = const AsyncData(null);
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    try {
      await _repo.deleteAccount();
      ref.read(companyProfileProvider.notifier).update((state) => {});
      ref.read(studentProfileProvider.notifier).update((state) => {});
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
