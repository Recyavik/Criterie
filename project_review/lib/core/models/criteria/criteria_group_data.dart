import 'package:json_annotation/json_annotation.dart';
import 'package:project_review/core/models/criteria/criterion_data.dart';

part 'criteria_group_data.g.dart';

@JsonSerializable()
class CriteriaGroupData {
  final int id;
  final String groupId;
  final String title;
  final List<CriterionData> criterion;

  CriteriaGroupData(this.id, this.groupId, this.title, this.criterion);

  factory CriteriaGroupData.fromJson(Map<String, dynamic> json) =>
      _$CriteriaGroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$CriteriaGroupDataToJson(this);
}