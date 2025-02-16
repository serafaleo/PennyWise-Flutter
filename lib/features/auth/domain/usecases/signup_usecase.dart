import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/core/usecase/usecase.dart';
import 'package:pennywise/features/auth/domain/entities/signup_request_entity.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<String, SignupRequestEntity> {
  @override
  Future<Either<Failure, String>> call(signUpEntity) async {
    return await sl<AuthRepository>().signUp(signUpEntity);
  }
}
