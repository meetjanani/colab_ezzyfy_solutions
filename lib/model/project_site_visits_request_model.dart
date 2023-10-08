import 'package:json_annotation/json_annotation.dart';

part 'project_site_visits_request_model.g.dart';

@JsonSerializable()
class ProjectSiteVisitsRequestModel {
  int projectId = 0;
  int createdByUser = 0;
  String title = "";
  String description = "";
  String attachmentsForSiteVisit = "";

  String createAt = DateTime.now().toString();

  ProjectSiteVisitsRequestModel({
    required this.projectId,
    required this.createdByUser,
    required this.title,
    required this.description,
    required this.attachmentsForSiteVisit,
  });

  static List<ProjectSiteVisitsRequestModel> fromJsonList(List<dynamic> dataList) {
    List<ProjectSiteVisitsRequestModel> record = [];
    for (var e in dataList) {
      record.add(_$ProjectSiteVisitsRequestModelFromJson(e));
    }
    return record;
  }

  factory ProjectSiteVisitsRequestModel.fromJson(Map<String, dynamic> data) =>
      _$ProjectSiteVisitsRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$ProjectSiteVisitsRequestModelToJson(this);

  static List<dynamic>  toJsonListProject(List<ProjectSiteVisitsRequestModel> dataList) {
    List<Map<String, dynamic>> jsonList = [];
    for (var item in dataList) {
      dataList.remove('id');
      jsonList.add(item.toJson());
    }
    return jsonList;
  }
}
