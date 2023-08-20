import 'package:json_annotation/json_annotation.dart';

part 'create_project_request_model.g.dart';

@JsonSerializable()
class CreateProjectRequestModel {
  String name = "";
  String address = "";
  String thumbnailImageUrl = "";
  int createdByUser = 0;
  String createAt = DateTime.now().toString();
  String assignedUser = "";

  CreateProjectRequestModel({
    required this.name,
    required this.address,
    required this.thumbnailImageUrl,
    required this.createdByUser,
    required this.assignedUser,
  });

  static List<CreateProjectRequestModel> fromJsonList(List<dynamic> dataList) {
    List<CreateProjectRequestModel> record = [];
    for (var e in dataList) {
      record.add(_$CreateProjectRequestModelFromJson(e));
    }
    return record;
  }

  factory CreateProjectRequestModel.fromJson(Map<String, dynamic> data) =>
      _$CreateProjectRequestModelFromJson(data);

  Map<String, dynamic> toJson() => _$CreateProjectRequestModelToJson(this);
}
