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
  Future<Response<Object>> get(String url, {Map<String, dynamic>? queryParameters});
  Future<Response<Object>> delete(String url);
  Future<Response<Object>> put(String url, {Object? data});
  Future<Response<Object>> request(
    String url,
    Object? data,
    Map<String, dynamic>? queryParameter,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  );
}

final class DioManagerImpl implements DioManager {
  late final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: Endpoints.baseUrl,
            headers: <String, dynamic>{'Content-Type': 'application/json; charset=UTF-8'},
            responseType: ResponseType.json,
            sendTimeout: kDebugMode ? null : const Duration(seconds: 10),
            receiveTimeout: kDebugMode ? null : const Duration(seconds: 10),
            connectTimeout: kDebugMode ? null : const Duration(seconds: 10),
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
  Future<Response<Object>> get(String url, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  @override
  Future<Response<Object>> delete(String url) async {
    return await _dio.delete(url);
  }

  @override
  Future<Response<Object>> put(String url, {Object? data}) async {
    return await _dio.put(url, data: data);
  }

  @override
  Future<Response<Object>> request(
    String url,
    Object? data,
    Map<String, dynamic>? queryParameter,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  ) async {
    return await _dio.request(
      url,
      data: data,
      queryParameters: queryParameter,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
