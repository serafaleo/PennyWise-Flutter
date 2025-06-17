import 'package:pennywise/core/entities/common_entity.dart';
import 'package:pennywise/features/categories/domain/enums/category_type_enum.dart';

class CategoryEntity extends CommonEntity {
  final String? parentCategoryId;
  final ECategoryType categoryType;
  final String name;
  final String? description;

  CategoryEntity({
    required super.id,
    required super.userId,
    required this.parentCategoryId,
    required this.categoryType,
    required this.name,
    required this.description,
  });
}
