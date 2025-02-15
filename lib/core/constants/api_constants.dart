import 'package:flutter/foundation.dart';

const _localhost = "10.0.2.2";

class ApiConstants {
  static const baseUrl = kDebugMode ? 'https://$_localhost:44309/api' : 'PRODUCTION URL HERE!!!';
}
