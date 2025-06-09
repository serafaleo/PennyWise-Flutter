abstract interface class AuthManager {
  String? get accessToken;
}

final class AuthManagerImpl implements AuthManager {
  @override
  String? get accessToken => 'FOO'; // TODO(serafaleo)
}
