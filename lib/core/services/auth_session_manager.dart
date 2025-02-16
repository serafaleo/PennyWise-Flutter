import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/models/token_response_dto.dart';

abstract interface class AuthSessionManager {
  Future<void> saveSession(TokenResponseDto tokenDto);
  Future<void> clearSession();
}

final class AuthSessionManagerImpl implements AuthSessionManager {
  TokenResponseDto? _tokenDto;
  static const String _secureStorageKey = "Session";

  String? get userId => _tokenDto?.userId;
  String? get accessToken => _tokenDto?.accessToken;
  String? get refreshToken => _tokenDto?.refreshToken;

  @override
  Future<void> saveSession(TokenResponseDto tokenDto) async {
    _tokenDto = tokenDto;
    await sl<FlutterSecureStorage>().write(
      key: _secureStorageKey,
      value: jsonEncode(tokenDto.toJson()),
    );
  }

  @override
  Future<void> clearSession() async {
    _tokenDto = null;
    await sl<FlutterSecureStorage>().delete(key: _secureStorageKey);
  }
}
