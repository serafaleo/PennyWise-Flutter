import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/core/usecase/usecase.dart';
import 'package:pennywise/features/auth/domain/repositories/auth_repository.dart';

final class LogoutUseCase implements UseCase<Unit, Unit> {
  @override
  Future<Either<Failure, Unit>> call(Unit params) async {
    return await sl<AuthRepository>().logout();
  }
}
