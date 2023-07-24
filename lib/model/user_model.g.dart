// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      emailAddress: json['emailAddress'] as String,
    )..createAt = json['createAt'] as String;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'emailAddress': instance.emailAddress,
      'createAt': instance.createAt,
    };
