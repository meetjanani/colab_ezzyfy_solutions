// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectCreateModel _$ProjectCreateModelFromJson(Map<String, dynamic> json) =>
    ProjectCreateModel(
      name: json['name'] as String,
      address: json['address'] as String,
      thumbnailImageUrl: json['thumbnailImageUrl'] as String,
      createdByUser: json['createdByUser'] as int,
    )
      ..createAt = json['createAt'] as String
      ..assignedUser = json['assignedUser'] as String;

Map<String, dynamic> _$ProjectCreateModelToJson(ProjectCreateModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'thumbnailImageUrl': instance.thumbnailImageUrl,
      'createdByUser': instance.createdByUser,
      'createAt': instance.createAt,
      'assignedUser': instance.assignedUser,
    };
