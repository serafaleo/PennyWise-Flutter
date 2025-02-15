import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/features/auth/data/models/login_request_dto.dart';
import 'package:pennywise/features/auth/data/models/signup_request_dto.dart';
import 'package:pennywise/features/auth/domain/entities/token_response_entity.dart';

abstract interface class AuthRepositoryInterface {
  Future<Either<Failure, TokenResponseEntity>> login(LoginRequestDto loginDto);
  Future<Either<Failure, String>> signUp(SignUpRequestDto signUpDto);
  Future<Either<Failure, void>> logout();
}
