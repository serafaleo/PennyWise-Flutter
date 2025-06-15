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
  Future<void> saveSession(LoginResponseDto tokenDto);
  Future<void> clearSession();
  Future<void> tryRestoreSession();
}

final class AuthManagerImpl implements AuthManager {
  LoginResponseDto? _tokenDto;

  @override
  String? get userName => _tokenDto?.userName;
  @override
  String? get userId => _tokenDto?.userId;
  @override
  String? get accessToken => _tokenDto?.accessToken;
  @override
  String? get refreshToken => _tokenDto?.refreshToken;

  @override
  Future<void> saveSession(LoginResponseDto tokenDto) async {
    _tokenDto = tokenDto;
    await sl<FlutterSecureStorage>().write(
      key: SecureStorageConstants.authSession,
      value: jsonEncode(tokenDto.toJson()),
    );
  }

  @override
  Future<void> clearSession() async {
    _tokenDto = null;
    await sl<FlutterSecureStorage>().delete(key: SecureStorageConstants.authSession);
  }

  @override
  Future<void> tryRestoreSession() async {
    final String? tokenDtoJsonString = await sl<FlutterSecureStorage>().read(
      key: SecureStorageConstants.authSession,
    );
    if (tokenDtoJsonString.isNotNullOrEmpty()) {
      _tokenDto = LoginResponseDto.fromJson(jsonDecode(tokenDtoJsonString!));
    }
  }
}
