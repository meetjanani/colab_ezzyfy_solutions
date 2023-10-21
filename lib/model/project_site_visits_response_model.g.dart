// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_site_visits_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectSiteVisitsResponseModel _$ProjectSiteVisitsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProjectSiteVisitsResponseModel(
      projectId: json['projectId'] as int,
      createdByUser: json['createdByUser'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    )
      ..id = json['id'] as int
      ..userName = json['userName'] ?? '' as String
      ..projectName = json['projectName'] ?? '' as String
      ..profilePictureUrl = json['profilePictureUrl'] ?? '' as String?
      ..attachmentsForSiteVisit = json['attachmentsForSiteVisit'] ?? '' as String
      ..createAt = json['createAt'] ?? ''as String
      ..visitDate = json['visitDate'] ?? '' as String;

Map<String, dynamic> _$ProjectSiteVisitsResponseModelToJson(
        ProjectSiteVisitsResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'createdByUser': instance.createdByUser,
      'title': instance.title,
      'description': instance.description,
      'userName': instance.userName,
      'projectName': instance.projectName,
      'profilePictureUrl': instance.profilePictureUrl,
      'attachmentsForSiteVisit': instance.attachmentsForSiteVisit,
      'createAt': instance.createAt,
      'visitDate': instance.visitDate,
    };
