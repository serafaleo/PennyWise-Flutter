import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pennywise/core/services/auth_session_manager.dart';
import 'package:pennywise/core/services/dio_client.dart';
import 'package:pennywise/features/auth/data/datasources/auth_api_data_source.dart';
import 'package:pennywise/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository.dart';
import 'package:pennywise/features/auth/domain/usecases/login_usecase.dart';
import 'package:pennywise/features/auth/domain/usecases/logout_usecase.dart';
import 'package:pennywise/features/auth/domain/usecases/signup_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // MUST be before AuthSessionManager
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  sl.registerLazySingleton<AuthSessionManager>(() => AuthSessionManagerImpl());

  _setupAuth();
}

void _setupAuth() {
  // Data Sources
  sl.registerLazySingleton<AuthApiDataSource>(() => AuthApiDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // UseCases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase());
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase());
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase());
}
