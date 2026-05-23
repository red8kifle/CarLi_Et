import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_client.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/datasources/internship_remote_datasource.dart';
import '../../data/datasources/internship_local_datasource.dart';
import '../../data/repositories/internship_repository_impl.dart';
import '../../domain/repositories/internship_repository.dart';
import '../../data/datasources/application_remote_datasource.dart';
import '../../data/datasources/application_local_datasource.dart';
import '../../data/repositories/application_repository_impl.dart';
import '../../domain/repositories/application_repository.dart';

final apiClientProvider = Provider((ref) => ApiClient());

// Auth
final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(ref.read(apiClientProvider)),
);
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(apiClientProvider),
  ),
);

// Internships
final internshipRemoteDataSourceProvider = Provider(
  (ref) => InternshipRemoteDataSource(ref.read(apiClientProvider)),
);
final internshipLocalDataSourceProvider = Provider(
  (ref) => InternshipLocalDataSource(),
);
final internshipRepositoryProvider = Provider<InternshipRepository>(
  (ref) => InternshipRepositoryImpl(
    ref.read(internshipRemoteDataSourceProvider),
    ref.read(internshipLocalDataSourceProvider),
  ),
);

// Applications
final applicationRemoteDataSourceProvider = Provider(
  (ref) => ApplicationRemoteDataSource(ref.read(apiClientProvider)),
);
final applicationLocalDataSourceProvider = Provider(
  (ref) => ApplicationLocalDataSource(),
);
final applicationRepositoryProvider = Provider<ApplicationRepository>(
  (ref) => ApplicationRepositoryImpl(
    ref.read(applicationRemoteDataSourceProvider),
    ref.read(applicationLocalDataSourceProvider),
  ),
);
