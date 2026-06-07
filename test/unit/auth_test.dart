import 'package:flutter_test/flutter_test.dart';
import 'package:carli_et/domain/entities/user_entity.dart';
import 'package:carli_et/domain/entities/internship_entity.dart';
import 'package:carli_et/domain/entities/application_entity.dart';

void main() {
  group('UserEntity Tests', () {
    test('Student user is created correctly', () {
      final user = UserEntity(
        id: 1,
        email: 'student@test.com',
        role: 'student',
        fullName: 'Test Student',
        token: 'test_token_123',
      );

      expect(user.id, 1);
      expect(user.email, 'student@test.com');
      expect(user.role, 'student');
      expect(user.fullName, 'Test Student');
      expect(user.isStudent, true);
      expect(user.isCompany, false);
    });

    test('Company user is created correctly', () {
      final user = UserEntity(
        id: 2,
        email: 'company@test.com',
        role: 'company',
        fullName: 'Test Company',
        token: 'test_token_456',
      );

      expect(user.id, 2);
      expect(user.email, 'company@test.com');
      expect(user.role, 'company');
      expect(user.isCompany, true);
      expect(user.isStudent, false);
    });
  });

  group('InternshipEntity Tests', () {
    test('Internship entity is created correctly', () {
      final internship = InternshipEntity(
        id: 1,
        companyId: 1,
        title: 'Flutter Developer',
        companyName: 'Tech Corp',
        location: 'Addis Ababa',
        type: 'Remote',
        description: 'Great opportunity',
        requirements: 'Flutter experience',
        skills: 'Dart, Flutter',
        deadline: '2026-12-31',
        isActive: true,
        createdAt: '2026-01-01',
      );

      expect(internship.id, 1);
      expect(internship.title, 'Flutter Developer');
      expect(internship.location, 'Addis Ababa');
      expect(internship.type, 'Remote');
      expect(internship.isActive, true);
    });
  });

  group('ApplicationEntity Tests', () {
    test('Pending application status is correct', () {
      final application = ApplicationEntity(
        id: 1,
        internshipId: 1,
        studentId: 1,
        coverLetter: 'I am interested',
        status: 'pending',
        appliedAt: '2026-01-01',
        internshipTitle: 'Flutter Developer',
        companyName: 'Tech Corp',
        studentName: 'Test Student',
      );

      expect(application.id, 1);
      expect(application.status, 'pending');
      expect(application.isPending, true);
      expect(application.isAccepted, false);
      expect(application.isRejected, false);
    });

    test('Accepted application status is correct', () {
      final application = ApplicationEntity(
        id: 2,
        internshipId: 1,
        studentId: 1,
        coverLetter: 'I am interested',
        status: 'accepted',
        appliedAt: '2026-01-01',
      );

      expect(application.status, 'accepted');
      expect(application.isAccepted, true);
      expect(application.isPending, false);
    });

    test('Rejected application status is correct', () {
      final application = ApplicationEntity(
        id: 3,
        internshipId: 1,
        studentId: 1,
        coverLetter: 'I am interested',
        status: 'rejected',
        appliedAt: '2026-01-01',
      );

      expect(application.status, 'rejected');
      expect(application.isRejected, true);
      expect(application.isPending, false);
    });
  });
}
