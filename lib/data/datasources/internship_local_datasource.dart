import 'package:sqflite/sqflite.dart';
import '../../core/local_db/local_database.dart';
import 'package:flutter/foundation.dart';

class InternshipLocalDataSource {
  static const String _cacheKey = 'internships';

  Future<List<Map<String, dynamic>>> getCachedInternships() async {
    if (kIsWeb) return [];
    try {
      final db = await LocalDatabase.database;
      return await db.query('cached_internships', orderBy: 'created_at DESC');
    } catch (e) {
      print('Get cached error: $e');
      return [];
    }
  }

  
  Future<void> cacheInternships(List<Map<String, dynamic>> internships) async {
    if (kIsWeb) return;
    try {
      final db = await LocalDatabase.database;
      await db.delete('cached_internships');

      for (final internship in internships) {
        await db.insert('cached_internships', {
          'id': internship['id'],
          'company_id': internship['company_id'],
          'title': internship['title'],
          'company_name': internship['company_name'],
          'location': internship['location'],
          'type': internship['type'],
          'description': internship['description'],
          'requirements': internship['requirements'],
          'skills': internship['skills'],
          'deadline': internship['deadline'],
          'is_active': internship['is_active'] ?? 1,
          'created_at':
              internship['created_at'] ?? DateTime.now().toIso8601String(),
          'updated_at':
              internship['updated_at'] ?? DateTime.now().toIso8601String(),
        });
      }

      await LocalDatabase.updateCacheMeta(_cacheKey);
    } catch (e) {
      print('Cache internships error: $e');
    }
  }

 
  Future<void> cache(List<Map<String, dynamic>> internships) async {
    await cacheInternships(internships);
  }

  Future<bool> isCacheFresh() async {
    if (kIsWeb) return false;
    return await LocalDatabase.isCacheFresh(_cacheKey);
  }
}
