import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class LocalDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (kIsWeb) return _getMemoryDatabase();
    _db ??= await _initDb();
    return _db!;
  }

  static Future<Database> _getMemoryDatabase() async {
    return await openDatabase(
      'memory.db',
      version: 2,
      onCreate: (db, version) async {
        await _createTables(db);
      },
    );
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'carli_et.db');

    return await openDatabase(
      path,
      version: 2, 
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        
        if (oldVersion < 2) {
          try {
            await db.execute(
              'ALTER TABLE cached_internships ADD COLUMN updated_at TEXT',
            );
          } catch (e) {
            print('Column may already exist: $e');
          }
        }
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    
    await db.execute('DROP TABLE IF EXISTS cached_internships');
    await db.execute('DROP TABLE IF EXISTS cached_applications');
    await db.execute('DROP TABLE IF EXISTS cache_meta');

    
    await db.execute('''
      CREATE TABLE cached_internships (
        id INTEGER PRIMARY KEY,
        company_id INTEGER,
        title TEXT,
        company_name TEXT,
        location TEXT,
        type TEXT,
        description TEXT,
        requirements TEXT,
        skills TEXT,
        deadline TEXT,
        is_active INTEGER,
        created_at TEXT,
        updated_at TEXT,
        cached_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    
    await db.execute('''
      CREATE TABLE cached_applications (
        id INTEGER PRIMARY KEY,
        internship_id INTEGER,
        student_id INTEGER,
        cover_letter TEXT,
        status TEXT,
        applied_at TEXT,
        internship_title TEXT,
        company_name TEXT,
        student_name TEXT,
        student_email TEXT,
        university TEXT,
        resume_url TEXT,
        cached_at TEXT DEFAULT (datetime('now'))
      )
    ''');

    
    await db.execute('''
      CREATE TABLE cache_meta (
        key TEXT PRIMARY KEY,
        cached_at TEXT NOT NULL
      )
    ''');
  }

  static Future<void> clearCache() async {
    if (kIsWeb) return;
    final db = await database;
    await db.delete('cached_internships');
    await db.delete('cached_applications');
    await db.delete('cache_meta');
  }

  static Future<bool> isCacheFresh(String key, {int maxAgeMinutes = 5}) async {
    if (kIsWeb) return false;
    try {
      final db = await database;
      final result = await db.query(
        'cache_meta',
        where: 'key = ?',
        whereArgs: [key],
      );
      if (result.isEmpty) return false;
      final cachedAt = DateTime.parse(result.first['cached_at'] as String);
      return DateTime.now().difference(cachedAt).inMinutes < maxAgeMinutes;
    } catch (e) {
      return false;
    }
  }

  static Future<void> updateCacheMeta(String key) async {
    if (kIsWeb) return;
    try {
      final db = await database;
      await db.insert('cache_meta', {
        'key': key,
        'cached_at': DateTime.now().toIso8601String(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Update cache meta error: $e');
    }
  }
}
