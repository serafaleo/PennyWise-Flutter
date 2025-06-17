import 'package:json_annotation/json_annotation.dart';
import 'package:pennywise/features/categories/domain/entities/category_entity.dart';
import 'package:pennywise/features/categories/domain/enums/category_type_enum.dart';

part 'category_model.g.dart';

@JsonSerializable()
final class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.userId,
    required super.parentCategoryId,
    required super.categoryType,
    required super.name,
    required super.description,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  factory CategoryModel.fromDomain(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      userId: entity.userId,
      parentCategoryId: entity.parentCategoryId,
      categoryType: entity.categoryType,
      name: entity.name,
      description: entity.description,
    );
  }

  CategoryEntity toDomain() {
    return CategoryEntity(
      id: id,
      userId: userId,
      parentCategoryId: parentCategoryId,
      categoryType: categoryType,
      name: name,
      description: description,
    );
  }
}
