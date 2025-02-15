import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/models/api_response_dto.dart';
import 'package:pennywise/core/network/dio_client.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/constants/auth_api_constants.dart';
import 'package:pennywise/features/auth/data/models/login_request_dto.dart';
import 'package:pennywise/features/auth/data/models/signup_request_dto.dart';
import 'package:pennywise/features/auth/data/models/token_response_dto.dart';

abstract interface class AuthApiServiceInterface {
  Future<Either<Failure, ApiResponseDto<TokenResponseDto>>> login(LoginRequestDto loginDto);
  Future<Either<Failure, ApiResponseDto<String>>> signUp(SignUpRequestDto signUpDto);
  Future<Either<Failure, ApiResponseDto<void>>> logout();
}

class AuthApiServiceImpl implements AuthApiServiceInterface {
  @override
  Future<Either<Failure, ApiResponseDto<TokenResponseDto>>> login(LoginRequestDto loginDto) async {
    try {
      Response response = await sl<DioClient>().post(AuthApiConstants.loginUrl, data: loginDto.toJson());
      ApiResponseDto<TokenResponseDto> apiResponse = ApiResponseDto.fromJson(
        response.data,
        (json) => TokenResponseDto.fromJson(json as Map<String, dynamic>),
      );
      return Right(apiResponse);
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, ApiResponseDto<String>>> signUp(SignUpRequestDto signUpDto) async {
    try {
      Response response = await sl<DioClient>().post(AuthApiConstants.signUpUrl, data: signUpDto.toJson());
      ApiResponseDto<String> apiResponse = ApiResponseDto.fromJson(response.data, (json) => json as String);
      return Right(apiResponse);
    } catch (e) {
      if (kDebugMode) {
        return Left(Failure(e.toString()));
      } else {
        return Left(Failure());
      }
    }
  }

  @override
  Future<Either<Failure, ApiResponseDto<void>>> logout() async {
    throw UnimplementedError();
  }
}
