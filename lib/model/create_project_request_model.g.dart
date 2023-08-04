// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_project_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProjectRequestModel _$CreateProjectRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateProjectRequestModel(
      name: json['name'] as String,
      address: json['address'] as String,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String,
      createdByUser: json['createdByUser'] as int,
    )
      ..createAt = json['createAt'] as String
      ..assignedUser = json['assignedUser'] as String;

Map<String, dynamic> _$CreateProjectRequestModelToJson(
        CreateProjectRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'createdByUser': instance.createdByUser,
      'createAt': instance.createAt,
      'assignedUser': instance.assignedUser,
    };
