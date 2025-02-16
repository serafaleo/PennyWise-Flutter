import 'package:dio/dio.dart';
import 'package:pennywise/core/models/api_response_dto.dart';
import 'package:pennywise/core/network/dio_client.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/constants/auth_api_constants.dart';
import 'package:pennywise/features/auth/data/models/login_request_dto.dart';
import 'package:pennywise/features/auth/data/models/signup_request_dto.dart';
import 'package:pennywise/features/auth/data/models/token_response_dto.dart';

abstract interface class AuthApiDataSource {
  Future<ApiResponseDto<TokenResponseDto>> login(LoginRequestDto loginDto);
  Future<ApiResponseDto<String>> signUp(SignUpRequestDto signUpDto);
  Future<ApiResponseDto<void>> logout();
}

class AuthApiDataSourceImpl implements AuthApiDataSource {
  @override
  Future<ApiResponseDto<TokenResponseDto>> login(LoginRequestDto loginDto) async {
    Response response = await sl<DioClient>().post(AuthApiConstants.loginUrl, data: loginDto.toJson());
    ApiResponseDto<TokenResponseDto> apiResponse = ApiResponseDto.fromJson(
      response.data,
      (json) => TokenResponseDto.fromJson(json as Map<String, dynamic>),
    );
    return apiResponse;
  }

  @override
  Future<ApiResponseDto<String>> signUp(SignUpRequestDto signUpDto) async {
    Response response = await sl<DioClient>().post(AuthApiConstants.signUpUrl, data: signUpDto.toJson());
    ApiResponseDto<String> apiResponse = ApiResponseDto.fromJson(response.data, (json) => json as String);
    return apiResponse;
  }

  @override
  Future<ApiResponseDto<void>> logout() async {
    Response response = await sl<DioClient>().post(AuthApiConstants.loginUrl);
    ApiResponseDto<void> apiResponse = ApiResponseDto.fromJson(response.data, (json) {});
    return apiResponse;
  }
}
