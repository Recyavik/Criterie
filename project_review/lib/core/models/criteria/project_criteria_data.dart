import 'package:json_annotation/json_annotation.dart';
import 'package:project_review/core/models/criteria/criteria_group_data.dart';

part 'project_criteria_data.g.dart';

@JsonSerializable()
class ProjectCriteriaData {
  final String id;
  final String projectId;
  final List<CriteriaGroupData> criteria;

  ProjectCriteriaData(this.id, this.projectId, this.criteria);

  factory ProjectCriteriaData.fromJson(Map<String, dynamic> json) =>
      _$ProjectCriteriaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectCriteriaDataToJson(this);
}