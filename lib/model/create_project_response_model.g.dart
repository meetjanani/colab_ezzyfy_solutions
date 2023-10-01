// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_project_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProjectResponseModel _$CreateProjectResponseModelFromJson(
        Map<String, dynamic> json) =>
    CreateProjectResponseModel(
      name: json['name'] as String,
      address: json['address'] as String,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String,
      createdByUser: json['createdByUser'] as int,
    )
      ..id = json['id'] as int
      ..createAt = json['createAt'] as String
      ..updatedAt = json['updatedAt'] as String
      ..assignedUser = json['assignedUser'] as String
      ..assignedSiteVisitUser = json['assignedSiteVisitUser'] as String;

Map<String, dynamic> _$CreateProjectResponseModelToJson(
        CreateProjectResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'createdByUser': instance.createdByUser,
      'createAt': instance.createAt,
      'updatedAt': instance.updatedAt,
      'assignedUser': instance.assignedUser,
      'assignedSiteVisitUser': instance.assignedSiteVisitUser,
    };
