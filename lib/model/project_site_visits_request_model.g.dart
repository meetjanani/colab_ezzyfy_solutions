// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_site_visits_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectSiteVisitsRequestModel _$ProjectSiteVisitsRequestModelFromJson(
        Map<String, dynamic> json) =>
    ProjectSiteVisitsRequestModel(
      projectId: json['projectId'] as int,
      createdByUser: json['createdByUser'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      attachmentsForSiteVisit: json['attachmentsForSiteVisit'] as String,
      visitDate: json['visitDate'] as String,
    )..createAt = json['createAt'] as String;

Map<String, dynamic> _$ProjectSiteVisitsRequestModelToJson(
        ProjectSiteVisitsRequestModel instance) =>
    <String, dynamic>{
      'projectId': instance.projectId,
      'createdByUser': instance.createdByUser,
      'title': instance.title,
      'description': instance.description,
      'attachmentsForSiteVisit': instance.attachmentsForSiteVisit,
      'createAt': instance.createAt,
      'visitDate': instance.visitDate,
    };
