import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/features/auth/domain/entities/login_request_entity.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';
import 'package:pennywise/features/auth/domain/entities/token_response_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, TokenResponseEntity>> login(LoginRequestEntity loginEntity);
  Future<Either<Failure, String>> signUp(SignupRequestEntity signUpEntity);
  Future<Either<Failure, void>> logout();
}
