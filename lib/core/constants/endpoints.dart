import 'package:flutter/foundation.dart';

const String _localhost = '10.0.2.2';

final class Endpoints {
  static const String baseUrl = kDebugMode ? 'https://$_localhost:44345/api/' : 'PRODUCTION URL HERE!!!';
}
