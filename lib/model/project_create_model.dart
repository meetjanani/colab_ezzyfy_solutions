import 'package:json_annotation/json_annotation.dart';

part 'project_create_model.g.dart';

@JsonSerializable()
class ProjectCreateModel {
  String projectName = "";
  String projectMobileNumber = "";
  String projectEmailAddress = "";
  String projectThumbnailImageUrl = "";
  String createdByUser = "";
  String createAt = DateTime.now().toString();

  ProjectCreateModel(
      {required this.projectName,
      required this.projectMobileNumber,
      required this.projectEmailAddress,
      required this.createdByUser,
      required this.projectThumbnailImageUrl});

  factory ProjectCreateModel.fromJson(Map<String, dynamic> data) =>
      _$ProjectCreateModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProjectCreateModelToJson(this);
}
