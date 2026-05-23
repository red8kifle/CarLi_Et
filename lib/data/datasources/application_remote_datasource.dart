import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';

class ApplicationRemoteDataSource {
  final ApiClient client;

  ApplicationRemoteDataSource(this.client);

  Future<List<Map<String, dynamic>>> getMyApplications() async {
    try {
      final response = await client.dio.get('/applications/mine');
      return List<Map<String, dynamic>>.from(response.data['applications']);
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<List<Map<String, dynamic>>> getApplicants(int internshipId) async {
    try {
      final response = await client.dio.get(
        '/applications/internship/$internshipId',
      );
      final applications = List<Map<String, dynamic>>.from(
        response.data['applications'],
      );
      return applications;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Map<String, dynamic>> apply(
    int internshipId, {
    String? coverLetter,
  }) async {
    try {
      final response = await client.dio.post(
        '/applications',
        data: {
          'internship_id': internshipId,
          if (coverLetter != null && coverLetter.isNotEmpty)
            'cover_letter': coverLetter,
        },
      );
      return response.data['application'];
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Map<String, dynamic>> updateStatus(
    int applicationId,
    String status,
  ) async {
    try {
      final response = await client.dio.put(
        '/applications/$applicationId/status',
        data: {'status': status},
      );
      return response.data['application'];
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<void> withdraw(int applicationId) async {
    try {
      await client.dio.delete('/applications/$applicationId');
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return e.response?.data['message'] ?? e.message ?? 'Network error';
    }
    return e.message ?? 'Network error';
  }
}
