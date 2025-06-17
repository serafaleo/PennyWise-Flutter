import 'package:dio/dio.dart';
import 'package:pennywise/core/constants/routes.dart';
import 'package:pennywise/core/helpers/extension_methods/string_extensions.dart';
import 'package:pennywise/core/managers/auth_manager.dart';
import 'package:pennywise/core/managers/dio_manager.dart';
import 'package:pennywise/core/managers/router_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/data/datasources/auth_api_datasource.dart';
import 'package:pennywise/features/auth/data/models/login_response_dto.dart';
import 'package:pennywise/features/auth/data/models/refresh_request_dto.dart';

final class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String? accessToken = sl<AuthManager>().accessToken;
    if (accessToken.isNotNullOrEmpty()) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && sl<AuthManager>().userId.isNotNullOrEmpty()) {
      try {
        final LoginResponseDto newToken = await sl<AuthApiDataSource>().refresh(
          RefreshRequestDto(
            userId: sl<AuthManager>().userId!,
            refreshToken: sl<AuthManager>().refreshToken!,
          ),
        );
        sl<AuthManager>().saveSession(newToken);
        final Response<Object> clonedRequest = await _retryRequest(err);
        return handler.resolve(clonedRequest);
      } catch (e) {
        sl<AuthManager>().clearSession();
        sl<RouterManager>().go(
          Routes.login,
          extra: true,
        );
      }
    }
    handler.next(err);
  }

  Future<Response<Object>> _retryRequest(DioException err) async {
    // Clone and retry the request
    final RequestOptions opts = err.requestOptions;
    final Response<Object> clonedRequest = await sl<DioManager>().request(
      opts.path,
      opts.data,
      opts.queryParameters,
      opts.cancelToken,
      Options(
        method: opts.method,
        headers: opts.headers,
        contentType: opts.contentType,
        responseType: opts.responseType,
        followRedirects: opts.followRedirects,
        validateStatus: opts.validateStatus,
        receiveDataWhenStatusError: opts.receiveDataWhenStatusError,
        extra: opts.extra,
        requestEncoder: opts.requestEncoder,
        responseDecoder: opts.responseDecoder,
        sendTimeout: opts.sendTimeout,
        receiveTimeout: opts.receiveTimeout,
      ),
      opts.onReceiveProgress,
      opts.onSendProgress,
    );
    return clonedRequest;
  }
}
