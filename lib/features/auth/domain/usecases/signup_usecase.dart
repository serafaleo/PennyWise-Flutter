import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/core/usecase/usecase.dart';
import 'package:pennywise/features/auth/domain/entities/login_request_entity.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository.dart';

final class SignUpUseCase implements UseCase<Unit, SignupRequestEntity> {
  @override
  Future<Either<Failure, Unit>> call(SignupRequestEntity signUpEntity) async {
    return await sl<AuthRepository>().signUp(signUpEntity);
  }
}
