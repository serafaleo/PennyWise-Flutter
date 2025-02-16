import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/models/api_response_dto.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/datasources/auth_api_data_source.dart';
import 'package:pennywise/features/auth/data/models/login_request_dto.dart';
import 'package:pennywise/features/auth/data/models/signup_request_dto.dart';
import 'package:pennywise/features/auth/data/models/token_response_dto.dart';
import 'package:pennywise/features/auth/domain/entities/login_request_entity.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';
import 'package:pennywise/features/auth/domain/entities/token_response_entity.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, TokenResponseEntity>> login(LoginRequestEntity loginEntity) async {
    try {
      ApiResponseDto<TokenResponseDto> apiResponse = await sl<AuthApiDataSource>().login(
        LoginRequestDto.fromDomain(loginEntity),
      );
      if (apiResponse.success) {
        return Right(apiResponse.data!.toDomain());
      }
      return Left(Failure(apiResponse.message!));
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> signUp(SignupRequestEntity signUpEntity) async {
    try {
      ApiResponseDto<String> apiResponse = await sl<AuthApiDataSource>().signUp(
        SignUpRequestDto.fromDomain(signUpEntity),
      );
      if (apiResponse.success) {
        return Right(apiResponse.data!);
      }
      return Left(Failure(apiResponse.message!));
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      ApiResponseDto<void> apiResponse = await sl<AuthApiDataSource>().logout();
      if (apiResponse.success) {
        return Right(null);
      }
      return Left(Failure(apiResponse.message!));
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }
}
