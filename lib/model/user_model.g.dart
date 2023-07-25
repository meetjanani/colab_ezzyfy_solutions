// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      mobileNumber: json['mobileNumber'] as String,
      emailAddress: json['emailAddress'] as String,
    )..createAt = json['createAt'] as String;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'mobileNumber': instance.mobileNumber,
      'emailAddress': instance.emailAddress,
      'createAt': instance.createAt,
    };
