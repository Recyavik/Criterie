// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'criteria_group_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CriteriaGroupData _$CriteriaGroupDataFromJson(Map<String, dynamic> json) =>
    CriteriaGroupData(
      json['id'] as int,
      json['groupId'] as String,
      json['title'] as String,
      (json['criterion'] as List<dynamic>)
          .map((e) => CriterionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CriteriaGroupDataToJson(CriteriaGroupData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'title': instance.title,
      'criterion': instance.criterion,
    };
