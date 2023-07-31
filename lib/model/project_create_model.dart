import 'package:json_annotation/json_annotation.dart';

part 'project_create_model.g.dart';

@JsonSerializable()
class ProjectCreateModel {
  String name = "";
  String address = "";
  String thumbnailImageUrl = "";
  int createdByUser = 0;
  String createAt = DateTime.now().toString();

  ProjectCreateModel({
    required this.name,
    required this.address,
    required this.thumbnailImageUrl,
    required this.createdByUser,
  });

  static List<ProjectCreateModel> fromJsonList(List<dynamic> dataList) {
    List<ProjectCreateModel> record = [];
    for (var e in dataList) {
      record.add(_$ProjectCreateModelFromJson(e));
    }
    return record;
  }

  factory ProjectCreateModel.fromJson(Map<String, dynamic> data) =>
      _$ProjectCreateModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProjectCreateModelToJson(this);
}
