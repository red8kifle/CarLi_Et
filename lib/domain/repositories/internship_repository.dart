import '../entities/internship_entity.dart';

abstract class InternshipRepository {
  Future<List<InternshipEntity>> getAll({
    String? search,
    String? location,
    String? type,
  });
  Future<List<InternshipEntity>> getMyInternships();
  Future<InternshipEntity> create(Map<String, dynamic> data);
  Future<void> delete(int id);
}
