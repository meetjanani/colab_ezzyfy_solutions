import 'package:json_annotation/json_annotation.dart';

part 'project_attchments_response_model.g.dart';

@JsonSerializable()
class ProjectAttachmentsResponseModel {
  int id = 0;
  int projectId = 0;
  int createdByUser = 0;
  String projectAttachmentUrl = "";
  String userName = "";
  String projectName = "";
  // response[0]['users']['name']

  String createAt = DateTime.now().toString();

  ProjectAttachmentsResponseModel({
    required this.projectId,
    required this.createdByUser,
    required this.projectAttachmentUrl,
  });

  static List<ProjectAttachmentsResponseModel> fromJsonList(List<dynamic> dataList) {
    List<ProjectAttachmentsResponseModel> record = [];
    for (var e in dataList) {
      var attachment = _$ProjectAttachmentsResponseModelFromJson(e);
      attachment.userName = e['users']['name'];
      attachment.projectName = e['projects']['name'];
      record.add(attachment);
    }
    return record;
  }

  factory ProjectAttachmentsResponseModel.fromJson(Map<String, dynamic> data) =>
      _$ProjectAttachmentsResponseModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProjectAttachmentsResponseModelToJson(this);

  static List<dynamic>  toJsonListProject(List<ProjectAttachmentsResponseModel> dataList) {
    List<Map<String, dynamic>> jsonList = [];
    for (var item in dataList) {
      dataList.remove('id');
      jsonList.add(item.toJson());
    }
    return jsonList;
  }
}
