import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/internship_entity.dart';
import '../../../domain/repositories/internship_repository.dart';
import '../../../core/providers/providers.dart';

final internshipNotifierProvider =
    AsyncNotifierProvider<InternshipNotifier, List<InternshipEntity>>(
      () => InternshipNotifier(),
    );

class InternshipNotifier extends AsyncNotifier<List<InternshipEntity>> {
  InternshipRepository get _repo => ref.read(internshipRepositoryProvider);

  @override
  Future<List<InternshipEntity>> build() async => [];

  Future<void> fetchAll({
    String? search,
    String? location,
    String? type,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _repo.getAll(search: search, location: location, type: type),
    );
  }

  Future<void> fetchMyInternships() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.getMyInternships());
  }

  Future<bool> createInternship(Map<String, dynamic> data) async {
    try {
      final created = await _repo.create(data);
      final current = state.value ?? [];
      state = AsyncData([created, ...current]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteInternship(int id) async {
    try {
      await _repo.delete(id);
      final current = state.value ?? [];
      state = AsyncData(current.where((i) => i.id != id).toList());
      return true;
    } catch (e) {
      return false;
    }
  }
}
