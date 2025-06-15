import 'package:dio/dio.dart';
import 'package:pennywise/core/managers/dio_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/constants/auth_api_endpoints.dart';
import 'package:pennywise/features/auth/data/models/login_request_dto.dart';
import 'package:pennywise/features/auth/data/models/login_response_dto.dart';
import 'package:pennywise/features/auth/data/models/refresh_request_dto.dart';
import 'package:pennywise/features/auth/data/models/signup_request_dto.dart';

abstract interface class AuthApiDataSource {
  Future<void> signUp(SignUpRequestDto signUpDto);
  Future<LoginResponseDto> login(LoginRequestDto loginDto);
  Future<LoginResponseDto> refresh(RefreshRequestDto refreshDto);
  Future<void> logout();
}

final class AuthApiDataSourceImpl implements AuthApiDataSource {
  @override
  Future<LoginResponseDto> login(LoginRequestDto loginDto) async {
    final Response<Object> response = await sl<DioManager>().post(
      AuthApiEndpoints.loginUrl,
      data: loginDto.toJson(),
    );
    return LoginResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> signUp(SignUpRequestDto signUpDto) async {
    await sl<DioManager>().post(AuthApiEndpoints.signUpUrl, data: signUpDto.toJson());
    return;
  }

  @override
  Future<LoginResponseDto> refresh(RefreshRequestDto refreshDto) async {
    final Response<Object> response = await sl<DioManager>().post(
      AuthApiEndpoints.refreshUrl,
      data: refreshDto.toJson(),
    );
    return LoginResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await sl<DioManager>().post(AuthApiEndpoints.logouUrl);
    return;
  }
}
