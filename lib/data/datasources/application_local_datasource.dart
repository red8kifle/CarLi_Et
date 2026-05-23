import 'package:sqflite/sqflite.dart';
import '../../core/local_db/local_database.dart';
import 'package:flutter/foundation.dart';

class ApplicationLocalDataSource {
  Future<List<Map<String, dynamic>>> getCachedApplications() async {
    if (kIsWeb) return [];
    try {
      final db = await LocalDatabase.database;
      return await db.query('cached_applications', orderBy: 'applied_at DESC');
    } catch (e) {
      return [];
    }
  }

  Future<void> cacheApplications(
    List<Map<String, dynamic>> applications,
  ) async {
    if (kIsWeb) return;
    try {
      final db = await LocalDatabase.database;
      await db.delete('cached_applications');
      for (final app in applications) {
        await db.insert('cached_applications', app);
      }
    } catch (e) {
      // Ignore cache errors
    }
  }

  Future<bool> isCacheFresh() async {
    if (kIsWeb) return false;
    // Simple implementation - always return false for now
    return false;
  }
}
