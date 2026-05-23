import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/application_entity.dart';
import '../../../domain/repositories/application_repository.dart';
import '../../../core/providers/providers.dart';

final applicationNotifierProvider =
    AsyncNotifierProvider<ApplicationNotifier, List<ApplicationEntity>>(
      () => ApplicationNotifier(),
    );

class ApplicationNotifier extends AsyncNotifier<List<ApplicationEntity>> {
  ApplicationRepository get _repo => ref.read(applicationRepositoryProvider);

  @override
  Future<List<ApplicationEntity>> build() async => [];

  Future<void> fetchMyApplications() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.getMyApplications());
  }

  Future<void> fetchApplicants(int internshipId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.getApplicants(internshipId));
  }

  Future<bool> apply(int internshipId, {String? coverLetter}) async {
    try {
      final app = await _repo.apply(internshipId, coverLetter: coverLetter);
      final current = state.value ?? [];
      state = AsyncData([app, ...current]);
      await fetchMyApplications();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateStatus(int applicationId, String status) async {
    try {
      final updated = await _repo.updateStatus(applicationId, status);
      final current = state.value ?? [];
      state = AsyncData(
        current.map((a) => a.id == applicationId ? updated : a).toList(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> withdraw(int applicationId) async {
    try {
      await _repo.withdraw(applicationId);
      final current = state.value ?? [];
      state = AsyncData(current.where((a) => a.id != applicationId).toList());
      return true;
    } catch (e) {
      return false;
    }
  }
}
