class ApplicationEntity {
  final int id;
  final int internshipId;
  final int studentId;
  final String? coverLetter;
  final String status;
  final String appliedAt;
  final String? internshipTitle;
  final String? companyName;
  final String? studentName;
  final String? studentEmail;
  final String? university;
  final String? resumeUrl;
  final int? year;
  final String? gpa;
  final String? skills;

  const ApplicationEntity({
    required this.id,
    required this.internshipId,
    required this.studentId,
    this.coverLetter,
    required this.status,
    required this.appliedAt,
    this.internshipTitle,
    this.companyName,
    this.studentName,
    this.studentEmail,
    this.university,
    this.resumeUrl,
    this.year,
    this.gpa,
    this.skills,
  });

  bool get isPending => status == 'pending';
  bool get isAccepted => status == 'accepted';
  bool get isRejected => status == 'rejected';

  String get yearText => year != null ? '${year}th Year' : 'N/A';
  String get gpaText => gpa != null && gpa!.isNotEmpty ? gpa! : 'N/A';
}
