import 'package:dio/dio.dart';
import 'package:pennywise/core/errors/failure.dart';

final class TimeoutInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      err = DioException(
        requestOptions: err.requestOptions,
        type: err.type,
        error: err.error,
        stackTrace: err.stackTrace,
        message: err.message,
        response: Response<Object>(
          requestOptions: err.requestOptions,
          data: Failure('Conexão com o servidor levou mais do que o esperado'),
        ),
      );

      handler.reject(err);
      return;
    }

    handler.next(err);
  }
}
