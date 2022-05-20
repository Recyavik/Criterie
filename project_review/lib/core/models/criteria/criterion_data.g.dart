// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criterion_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriterionData _$CriterionDataFromJson(Map<String, dynamic> json) =>
    CriterionData(
      id: json['id'] as int,
      coast: (json['coast'] as num).toDouble(),
      title: json['title'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$CriterionDataToJson(CriterionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'coast': instance.coast,
      'isSelected': instance.isSelected,
    };
