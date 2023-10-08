import 'package:colab_ezzyfy_solutions/resource/extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_site_visits_response_model.g.dart';

@JsonSerializable(nullable: true)
class ProjectSiteVisitsResponseModel {
  int id = 0;
  int projectId = 0;
  int createdByUser = 0;
  String title = "";
  String description = "";
  String userName = "";
  String projectName = "";
  String? profilePictureUrl = "";
  String attachmentsForSiteVisit = "";
  // response[0]['users']['name']

  String createAt = DateTime.now().toString();

  ProjectSiteVisitsResponseModel({
    required this.projectId,
    required this.createdByUser,
    required this.title,
    required this.description,
  });

  factory ProjectSiteVisitsResponseModel.fromJson(Map<String, dynamic> data) =>
      _$ProjectSiteVisitsResponseModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProjectSiteVisitsResponseModelToJson(this);

  static List<ProjectSiteVisitsResponseModel> fromJsonList(List<dynamic> dataList) {
    List<ProjectSiteVisitsResponseModel> record = [];
    for (var e in dataList) {
      var attachment = _$ProjectSiteVisitsResponseModelFromJson(e);
      attachment.userName = e['users']['name'];
      attachment.profilePictureUrl = e['users']['profilePictureUrl'];
      attachment.projectName = e['projects']['name'];
      if (e['createAt'] != null)
        attachment.createAt = e['createAt'].toString().getColabDateFormat();
      record.add(attachment);
    }
    return record;
  }


  static List<dynamic>  toJsonListProject(List<ProjectSiteVisitsResponseModel> dataList) {
    List<Map<String, dynamic>> jsonList = [];
    for (var item in dataList) {
      dataList.remove('id');
      jsonList.add(item.toJson());
    }
    return jsonList;
  }
}
