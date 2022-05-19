import 'package:json_annotation/json_annotation.dart';

part 'response_data.g.dart';

@JsonSerializable()
class ResponseData {
  @JsonKey(name: 'Status')
  final String? status;
  @JsonKey(name: 'Error')
  final String? error;
  @JsonKey(name: 'Path')
  final String? path;

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  ResponseData({this.status, this.error, this.path});
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}