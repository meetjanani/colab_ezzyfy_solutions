// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectCreateModel _$ProjectCreateModelFromJson(Map<String, dynamic> json) =>
    ProjectCreateModel(
      projectName: json['projectName'] as String,
      projectMobileNumber: json['projectMobileNumber'] as String,
      projectEmailAddress: json['projectEmailAddress'] as String,
      createdByUser: json['createdByUser'] as String,
      projectThumbnailImageUrl: json['projectThumbnailImageUrl'] as String,
    )..createAt = json['createAt'] as String;

Map<String, dynamic> _$ProjectCreateModelToJson(ProjectCreateModel instance) =>
    <String, dynamic>{
      'projectName': instance.projectName,
      'projectMobileNumber': instance.projectMobileNumber,
      'projectEmailAddress': instance.projectEmailAddress,
      'projectThumbnailImageUrl': instance.projectThumbnailImageUrl,
      'createdByUser': instance.createdByUser,
      'createAt': instance.createAt,
    };
