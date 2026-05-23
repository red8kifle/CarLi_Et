class InternshipEntity {
  final int id;
  final int companyId;
  final String title;
  final String companyName;
  final String location;
  final String type;
  final String? description;
  final String? requirements;
  final String? skills;
  final String? deadline;
  final bool isActive;
  final String createdAt;
  const InternshipEntity({
    required this.id,
    required this.companyId,
    required this.title,
    required this.companyName,
    required this.location,
    required this.type,
    this.description,
    this.requirements,
    this.skills,
    this.deadline,
    required this.isActive,
    required this.createdAt,
  });
}
