import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/features/categories/domain/entities/category_entity.dart';

abstract interface class CategoriesRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAll(int page, int pageSize);
}
