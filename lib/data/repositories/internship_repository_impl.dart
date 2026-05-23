import '../../domain/entities/internship_entity.dart';
import '../../domain/repositories/internship_repository.dart';
import '../datasources/internship_remote_datasource.dart';
import '../datasources/internship_local_datasource.dart';
import 'package:flutter/foundation.dart';

class InternshipRepositoryImpl implements InternshipRepository {
  final InternshipRemoteDataSource remote;
  final InternshipLocalDataSource local;

  InternshipRepositoryImpl(this.remote, this.local);

  @override
  Future<List<InternshipEntity>> getAll({
    String? search,
    String? location,
    String? type,
  }) async {
   
    if (kIsWeb) {
      final fresh = await remote.getAll(
        search: search,
        location: location,
        type: type,
      );
      return fresh
          .map(
            (m) => InternshipEntity(
              id: m['id'],
              companyId: m['company_id'],
              title: m['title'],
              companyName: m['company_name'],
              location: m['location'],
              type: m['type'],
              description: m['description'],
              requirements: m['requirements'],
              skills: m['skills'],
              deadline: m['deadline'],
              isActive: m['is_active'] == 1,
              createdAt: m['created_at'] ?? '',
            ),
          )
          .toList();
    }

    
    final fresh = await remote.getAll(
      search: search,
      location: location,
      type: type,
    );

    
    try {
      await local.cacheInternships(
        fresh,
      ); 
    } catch (e) {
      print('Cache error (ignored): $e');
    }

    return fresh
        .map(
          (m) => InternshipEntity(
            id: m['id'],
            companyId: m['company_id'],
            title: m['title'],
            companyName: m['company_name'],
            location: m['location'],
            type: m['type'],
            description: m['description'],
            requirements: m['requirements'],
            skills: m['skills'],
            deadline: m['deadline'],
            isActive: m['is_active'] == 1,
            createdAt: m['created_at'] ?? '',
          ),
        )
        .toList();
  }

  @override
  Future<List<InternshipEntity>> getMyInternships() async {
    final fresh = await remote.getMyInternships();
    return fresh
        .map(
          (m) => InternshipEntity(
            id: m['id'],
            companyId: m['company_id'],
            title: m['title'],
            companyName: m['company_name'],
            location: m['location'],
            type: m['type'],
            description: m['description'],
            requirements: m['requirements'],
            skills: m['skills'],
            deadline: m['deadline'],
            isActive: m['is_active'] == 1,
            createdAt: m['created_at'] ?? '',
          ),
        )
        .toList();
  }

  @override
  Future<InternshipEntity> create(Map<String, dynamic> data) async {
    final result = await remote.create(data);
    return InternshipEntity(
      id: result['id'],
      companyId: result['company_id'],
      title: result['title'],
      companyName: result['company_name'],
      location: result['location'],
      type: result['type'],
      description: result['description'],
      requirements: result['requirements'],
      skills: result['skills'],
      deadline: result['deadline'],
      isActive: true,
      createdAt: result['created_at'] ?? DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<InternshipEntity> getById(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<InternshipEntity> update(int id, Map<String, dynamic> data) async {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int id) async => await remote.delete(id);
}
