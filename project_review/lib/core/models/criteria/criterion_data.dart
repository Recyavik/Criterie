import 'package:json_annotation/json_annotation.dart';

part 'criterion_data.g.dart';

@JsonSerializable()
class CriterionData {
  final int id;
  final String title;
  final double coast;
  bool isSelected;

  CriterionData(
      {required this.id,
      required this.coast,
      required this.title,
      this.isSelected = false});

  factory CriterionData.fromJson(Map<String, dynamic> json) =>
      _$CriterionDataFromJson(json);

  void changeSelection()=>isSelected = !isSelected;

  Map<String, dynamic> toJson() => _$CriterionDataToJson(this);
}
