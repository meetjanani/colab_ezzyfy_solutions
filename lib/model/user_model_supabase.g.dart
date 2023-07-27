// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_supabase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelSupabase _$UserModelSupabaseFromJson(Map<String, dynamic> json) =>
    UserModelSupabase(
      id: json['id'] as int,
      name: json['name'] as String,
      mobileNumber: json['mobileNumber'] as String,
      emailAddress: json['emailAddress'] as String,
    )..createAt = json['createAt'] as String;

Map<String, dynamic> _$UserModelSupabaseToJson(UserModelSupabase instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'emailAddress': instance.emailAddress,
      'createAt': instance.createAt,
    };
