import '../entities/application_entity.dart';

abstract class ApplicationRepository {
  Future<List<ApplicationEntity>> getMyApplications();
  Future<List<ApplicationEntity>> getApplicants(int internshipId);
  Future<ApplicationEntity> apply(int internshipId, {String? coverLetter});
  Future<ApplicationEntity> updateStatus(int applicationId, String status);
  Future<void> withdraw(int applicationId);
}
