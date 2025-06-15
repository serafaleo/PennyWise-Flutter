import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pennywise/core/constants/secure_storage.dart';
import 'package:pennywise/core/helpers/extension_methods/string_extensions.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/models/login_response_dto.dart';

abstract interface class AuthManager {
  String? get userName;
  String? get userId;
  String? get accessToken;
  String? get refreshToken;
  Future<void> saveSession(LoginResponseDto loginResponseDto);
  Future<void> clearSession();
  Future<void> tryRestoreSession();
}

final class AuthManagerImpl implements AuthManager {
  LoginResponseDto? _loginResponseDto;

  @override
  String? get userName => _loginResponseDto?.userName;
  @override
  String? get userId => _loginResponseDto?.userId;
  @override
  String? get accessToken => _loginResponseDto?.accessToken;
  @override
  String? get refreshToken => _loginResponseDto?.refreshToken;

  @override
  Future<void> saveSession(LoginResponseDto loginResponseDto) async {
    _loginResponseDto = loginResponseDto;
    await sl<FlutterSecureStorage>().write(
      key: SecureStorageConstants.authSession,
      value: jsonEncode(loginResponseDto.toJson()),
    );
  }

  @override
  Future<void> clearSession() async {
    _loginResponseDto = null;
    await sl<FlutterSecureStorage>().delete(key: SecureStorageConstants.authSession);
  }

  @override
  Future<void> tryRestoreSession() async {
    final String? tokenDtoJsonString = await sl<FlutterSecureStorage>().read(
      key: SecureStorageConstants.authSession,
    );
    if (tokenDtoJsonString.isNotNullOrEmpty()) {
      _loginResponseDto = LoginResponseDto.fromJson(jsonDecode(tokenDtoJsonString!));
    }
  }
}
