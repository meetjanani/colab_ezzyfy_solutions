// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_attchments_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectAttachmentsResponseModel _$ProjectAttachmentsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProjectAttachmentsResponseModel(
      projectId: json['projectId'] as int,
      createdByUser: json['createdByUser'] as int,
      projectAttachmentUrl: json['projectAttachmentUrl'] as String,
    )
      ..id = json['id'] as int
      ..userName = json['userName'] ?? '' as String
      ..projectName = json['projectName'] ?? ''as String
      ..profilePictureUrl = json['profilePictureUrl'] ?? ''as String?
      ..createAt = json['createAt'] ?? ''as String;

Map<String, dynamic> _$ProjectAttachmentsResponseModelToJson(
        ProjectAttachmentsResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'createdByUser': instance.createdByUser,
      'projectAttachmentUrl': instance.projectAttachmentUrl,
      'userName': instance.userName,
      'projectName': instance.projectName,
      'profilePictureUrl': instance.profilePictureUrl,
      'createAt': instance.createAt,
    };
