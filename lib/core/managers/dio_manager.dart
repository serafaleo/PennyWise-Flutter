import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pennywise/core/constants/endpoints.dart';
import 'package:pennywise/core/interceptors/auth_interceptor.dart';
import 'package:pennywise/core/interceptors/problem_details_interceptor.dart';
import 'package:pennywise/core/interceptors/timeout_interceptor.dart';

abstract interface class DioManager {
  Future<Response<Object>> post(String url, {Object? data});
  Future<Response<Object>> request(String url, {Options? options});
}

final class DioManagerImpl implements DioManager {
  late final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            headers: <String, dynamic>{'Content-Type': 'application/json; charset=UTF-8'},
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            connectTimeout: const Duration(seconds: 10),
          ),
        )
        ..interceptors.addAll(<Interceptor>[TimeoutInterceptor(), AuthInterceptor(), ProblemDetailsInterceptor()])
        ..httpClientAdapter = IOHttpClientAdapter(
          createHttpClient: () {
            final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: false));
            client.badCertificateCallback = (X509Certificate cert, String host, int port) =>
                kDebugMode ? true : false; // TODO(serafa.leo): Test this
            return client;
          },
        );

  @override
  Future<Response<Object>> post(String url, {Object? data}) async {
    return await _dio.post(url, data: data);
  }

  @override
  Future<Response<Object>> request(String url, {Options? options}) async {
    return await _dio.request(url, options: options);
  }
}
