// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      parentCategoryId: json['parentCategoryId'] as String?,
      categoryType: $enumDecode(_$ECategoryTypeEnumMap, json['categoryType']),
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'parentCategoryId': instance.parentCategoryId,
      'categoryType': _$ECategoryTypeEnumMap[instance.categoryType]!,
      'name': instance.name,
      'description': instance.description,
    };

const _$ECategoryTypeEnumMap = {
  ECategoryType.expense: 0,
  ECategoryType.income: 1,
};
