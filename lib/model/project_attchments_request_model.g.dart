// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_attchments_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectAttachmentsRequestModel _$ProjectAttachmentsRequestModelFromJson(
        Map<String, dynamic> json) =>
    ProjectAttachmentsRequestModel(
      projectId: json['projectId'] as int,
      createdByUser: json['createdByUser'] as int,
      projectAttachmentUrl: json['projectAttachmentUrl'] as String,
      videoUrl: json['videoUrl'] as String?,
    )..createAt = json['createAt'] as String;

Map<String, dynamic> _$ProjectAttachmentsRequestModelToJson(
        ProjectAttachmentsRequestModel instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'createdByUser': instance.createdByUser,
      'projectAttachmentUrl': instance.projectAttachmentUrl,
      'videoUrl': instance.videoUrl,
      'createAt': instance.createAt,
    };
