import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/features/auth/data/models/login_request_dto.dart';
import 'package:pennywise/features/auth/data/models/signup_request_dto.dart';
import 'package:pennywise/features/auth/domain/entities/token_response_entity.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository_interface.dart';

class AuthRepositoryImpl implements AuthRepositoryInterface {
  @override
  Future<Either<Failure, TokenResponseEntity>> login(LoginRequestDto loginDto) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUp(SignUpRequestDto signUpDto) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
