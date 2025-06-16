import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/models/problem_details_dto.dart';

final class ProblemDetailsInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final ProblemDetailsDto problemDetails = ProblemDetailsDto.fromJson(err.response!.data);
      final Failure failure = Failure(problemDetails.detail);
      err.response!.data = failure;
    } catch (e) {
      if (kDebugMode) {
        err.response!.data = Failure(err.error.toString());
      } else {
        err.response!.data = Failure();
      }
    } finally {
      handler.reject(err);
    }
  }
}
