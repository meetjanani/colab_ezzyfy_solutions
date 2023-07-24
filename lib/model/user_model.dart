import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String name = "";
  String phoneNumber = "";
  String emailAddress = "";
  String createAt = DateTime.now().toString();

  UserModel({
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
