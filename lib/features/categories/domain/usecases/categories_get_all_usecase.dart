import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/core/usecase/usecase.dart';
import 'package:pennywise/features/categories/domain/entities/category_entity.dart';
import 'package:pennywise/features/categories/domain/repositories/categories_repository.dart';

final class CategoriesGetAllUseCase implements UseCase<List<CategoryEntity>, (int page, int pageSize)> {
  @override
  Future<Either<Failure, List<CategoryEntity>>> call((int page, int pageSize) params) async {
    return await sl<CategoriesRepository>().getAll(params.$1, params.$2);
  }
}
