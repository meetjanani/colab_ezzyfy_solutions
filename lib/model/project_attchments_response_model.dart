import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_attchments_response_model.g.dart';

@JsonSerializable(nullable: true)
class ProjectAttachmentsResponseModel {
  int id = 0;
  int projectId = 0;
  int createdByUser = 0;
  String projectAttachmentUrl = "";
  String userName = "";
  String projectName = "";
  String? profilePictureUrl = "";
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
      attachment.profilePictureUrl = e['users']['profilePictureUrl'];
      attachment.projectName = e['projects']['name'];
      if (e['createAt'] != null)
        attachment.createAt = e['createAt'].toString().getColabDateFormat();
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

class TimeLineAttachmentListModel{
  String createAt;
  List<ProjectAttachmentsResponseModel> imagesForDay;

  TimeLineAttachmentListModel(
      this.createAt,
      this.imagesForDay,
      );
}
