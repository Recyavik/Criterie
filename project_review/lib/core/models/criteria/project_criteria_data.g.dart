// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_criteria_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectCriteriaData _$ProjectCriteriaDataFromJson(Map<String, dynamic> json) =>
    ProjectCriteriaData(
      json['id'] as String,
      json['projectId'] as String,
      (json['criteria'] as List<dynamic>)
          .map((e) => CriteriaGroupData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProjectCriteriaDataToJson(
        ProjectCriteriaData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'criteria': instance.criteria,
    };
