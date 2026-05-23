import '../../domain/entities/application_entity.dart';
import '../../domain/repositories/application_repository.dart';
import '../datasources/application_remote_datasource.dart';
import '../datasources/application_local_datasource.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  final ApplicationRemoteDataSource remote;
  final ApplicationLocalDataSource local;

  ApplicationRepositoryImpl(this.remote, this.local);

  @override
  Future<List<ApplicationEntity>> getMyApplications() async {
    final fresh = await remote.getMyApplications();
    return fresh
        .map(
          (m) => ApplicationEntity(
            id: m['id'],
            internshipId: m['internship_id'],
            studentId: m['student_id'],
            coverLetter: m['cover_letter'],
            status: m['status'],
            appliedAt: m['applied_at'],
            internshipTitle: m['internship_title'],
            companyName: m['company_name'],
            studentName: m['student_name'],
            studentEmail: m['student_email'],
            university: m['university'],
            resumeUrl: m['resume_url'],
            year: m['year'] is int
                ? m['year']
                : int.tryParse(m['year']?.toString() ?? ''),
            gpa: m['gpa']?.toString(),
            skills: m['skills'],
          ),
        )
        .toList();
  }

  @override
  Future<List<ApplicationEntity>> getApplicants(int internshipId) async {
    final fresh = await remote.getApplicants(internshipId);
    return fresh
        .map(
          (m) => ApplicationEntity(
            id: m['id'],
            internshipId: m['internship_id'],
            studentId: m['student_id'],
            coverLetter: m['cover_letter'],
            status: m['status'],
            appliedAt: m['applied_at'],
            internshipTitle: m['internship_title'],
            companyName: m['company_name'],
            studentName: m['student_name'],
            studentEmail: m['student_email'],
            university: m['university'],
            resumeUrl: m['resume_url'],
            year: m['year'] is int
                ? m['year']
                : int.tryParse(m['year']?.toString() ?? ''),
            gpa: m['gpa']?.toString(),
            skills: m['skills'],
          ),
        )
        .toList();
  }

  @override
  Future<ApplicationEntity> apply(
    int internshipId, {
    String? coverLetter,
  }) async {
    final result = await remote.apply(internshipId, coverLetter: coverLetter);
    return ApplicationEntity(
      id: result['id'],
      internshipId: result['internship_id'],
      studentId: result['student_id'],
      coverLetter: result['cover_letter'],
      status: result['status'],
      appliedAt: result['applied_at'],
      internshipTitle: result['internship_title'],
      companyName: result['company_name'],
      studentName: result['student_name'],
      studentEmail: result['student_email'],
      university: result['university'],
      resumeUrl: result['resume_url'],
      year: result['year'],
      gpa: result['gpa'],
      skills: result['skills'],
    );
  }

  @override
  Future<ApplicationEntity> updateStatus(
    int applicationId,
    String status,
  ) async {
    final result = await remote.updateStatus(applicationId, status);
    return ApplicationEntity(
      id: result['id'],
      internshipId: result['internship_id'],
      studentId: result['student_id'],
      coverLetter: result['cover_letter'],
      status: result['status'],
      appliedAt: result['applied_at'],
      internshipTitle: result['internship_title'],
      companyName: result['company_name'],
      studentName: result['student_name'],
      studentEmail: result['student_email'],
      university: result['university'],
      resumeUrl: result['resume_url'],
      year: result['year'],
      gpa: result['gpa'],
      skills: result['skills'],
    );
  }

  @override
  Future<void> withdraw(int applicationId) async {
    await remote.withdraw(applicationId);
  }
}
