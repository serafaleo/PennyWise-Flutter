import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/managers/auth_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:pennywise/features/auth/data/models/login_request_dto.dart';
import 'package:pennywise/features/auth/data/models/login_response_dto.dart';
import 'package:pennywise/features/auth/data/models/signup_request_dto.dart';
import 'package:pennywise/features/auth/domain/entities/login_request_entity.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository.dart';

final class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, Unit>> login(LoginRequestEntity loginEntity) async {
    try {
      final LoginResponseDto token = await sl<AuthApiDataSource>().login(
        LoginRequestDto.fromDomain(loginEntity),
      );
      sl<AuthManager>().saveSession(token);
      return const Right<Failure, Unit>(unit);
    } on DioException catch (e) {
      return Left<Failure, Unit>(e.response!.data as Failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp(SignupRequestEntity signUpEntity) async {
    try {
      await sl<AuthApiDataSource>().signUp(SignUpRequestDto.fromDomain(signUpEntity));
      return const Right<Failure, Unit>(unit);
    } on DioException catch (e) {
      return Left<Failure, Unit>(e.response!.data as Failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await sl<AuthApiDataSource>().logout();
      sl<AuthManager>().clearSession();
      return const Right<Failure, Unit>(unit);
    } on DioException catch (e) {
      return Left<Failure, Unit>(e.response!.data as Failure);
    }
  }
}
