import 'package:json_annotation/json_annotation.dart';

part 'create_project_response_model.g.dart';

@JsonSerializable()
class CreateProjectResponseModel {
  int id = 0;
  String name = "";
  String address = "";
  String thumbnailImageUrl = "";
  int createdByUser = 0;
  String createAt = DateTime.now().toString();
  String updatedAt = DateTime.now().toString();
  String assignedUser = "";
  String assignedSiteVisitUser = "";

  CreateProjectResponseModel({
    required this.name,
    required this.address,
    required this.thumbnailImageUrl,
    required this.createdByUser,
  });

  static List<CreateProjectResponseModel> fromJsonList(List<dynamic> dataList) {
    List<CreateProjectResponseModel> record = [];
    for (var e in dataList) {
      record.add(_$CreateProjectResponseModelFromJson(e));
    }
    return record;
  }

  factory CreateProjectResponseModel.fromJson(Map<String, dynamic> data) =>
      _$CreateProjectResponseModelFromJson(data);

  Map<String, dynamic> toJson() => _$CreateProjectResponseModelToJson(this);
}
