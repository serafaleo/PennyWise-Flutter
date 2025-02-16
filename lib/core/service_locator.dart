import 'package:get_it/get_it.dart';
import 'package:pennywise/core/network/dio_client.dart';
import 'package:pennywise/features/auth/data/datasources/auth_api_data_source.dart';
import 'package:pennywise/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository.dart';
import 'package:pennywise/features/auth/domain/usecases/signup_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Data Sources
  sl.registerSingleton<AuthApiDataSource>(AuthApiDataSourceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // UseCases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
}
