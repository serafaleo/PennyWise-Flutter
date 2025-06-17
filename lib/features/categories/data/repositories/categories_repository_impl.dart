import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pennywise/core/errors/failure.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/categories/data/datasources/categories_api_datasource.dart';
import 'package:pennywise/features/categories/data/models/category_model.dart';
import 'package:pennywise/features/categories/domain/entities/category_entity.dart';
import 'package:pennywise/features/categories/domain/repositories/categories_repository.dart';

final class CategoriesRepositoryImpl implements CategoriesRepository {
  @override
  Future<Either<Failure, List<CategoryEntity>>> getAll(int page, int pageSize) async {
    try {
      final List<CategoryModel> models = await sl<CategoriesApiDataSource>().getAll(page, pageSize);
      final List<CategoryEntity> entities = <CategoryEntity>[];
      for (final CategoryModel categoryModel in models) {
        entities.add(categoryModel.toDomain());
      }
      return Right<Failure, List<CategoryEntity>>(entities);
    } on DioException catch (e) {
      return Left<Failure, List<CategoryEntity>>(e.response!.data as Failure);
    }
  }
}
