import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';

class InternshipRemoteDataSource {
  final ApiClient client;
  InternshipRemoteDataSource(this.client);

  Future<List<Map<String, dynamic>>> getAll({
    String? search,
    String? location,
    String? type,
  }) async {
    final res = await client.dio.get(
      '/internships',
      queryParameters: {
        if (search != null) 'search': search,
        if (location != null) 'location': location,
        if (type != null) 'type': type,
      },
    );
    return List<Map<String, dynamic>>.from(res.data['internships']);
  }

  Future<List<Map<String, dynamic>>> getMyInternships() async {
    final res = await client.dio.get('/internships/mine');
    return List<Map<String, dynamic>>.from(res.data['internships']);
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final res = await client.dio.post('/internships', data: data);
    return res.data['internship'];
  }

  Future<void> delete(int id) async =>
      await client.dio.delete('/internships/$id');
}
