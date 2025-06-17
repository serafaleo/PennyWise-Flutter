import 'package:dio/dio.dart';
import 'package:pennywise/core/managers/dio_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/categories/data/models/category_model.dart';

abstract interface class CategoriesApiDataSource {
  Future<List<CategoryModel>> getAll(int page, int pageSize);
}

final class CategoriesApiDataSourceImpl implements CategoriesApiDataSource {
  static const String _controllerName = 'Categories';
  @override
  Future<List<CategoryModel>> getAll(int page, int pageSize) async {
    final Response<Object> response = await sl<DioManager>().get(
      _controllerName,
      queryParameters: <String, dynamic>{'page': page, 'pageSize': pageSize},
    );
    return (response.data as List<dynamic>).map((dynamic json) => CategoryModel.fromJson(json)).toList();
  }
}
