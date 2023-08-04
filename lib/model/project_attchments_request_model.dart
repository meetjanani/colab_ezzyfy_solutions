import 'package:json_annotation/json_annotation.dart';

part 'project_attchments_request_model.g.dart';

@JsonSerializable()
class ProjectAttachmentsRequestModel {
  int projectId = 0;
  int createdByUser = 0;
  String projectAttachmentUrl = "";

  String createAt = DateTime.now().toString();

  ProjectAttachmentsRequestModel({
    required this.projectId,
    required this.createdByUser,
    required this.projectAttachmentUrl,
  });

  static List<ProjectAttachmentsRequestModel> fromJsonList(List<dynamic> dataList) {
    List<ProjectAttachmentsRequestModel> record = [];
    for (var e in dataList) {
      record.add(_$ProjectAttachmentsRequestModelFromJson(e));
    }
    return record;
  }

  factory ProjectAttachmentsRequestModel.fromJson(Map<String, dynamic> data) =>
      _$ProjectAttachmentsRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProjectAttachmentsRequestModelToJson(this);

  static List<dynamic>  toJsonListProject(List<ProjectAttachmentsRequestModel> dataList) {
    List<Map<String, dynamic>> jsonList = [];
    for (var item in dataList) {
      dataList.remove('id');
      jsonList.add(item.toJson());
    }
    return jsonList;
  }
}
