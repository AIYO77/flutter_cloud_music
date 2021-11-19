// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_exist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneExist _$PhoneExistFromJson(Map<String, dynamic> json) => PhoneExist(
      json['exist'] as int,
      json['nickname'] as String?,
      json['hasPassword'] as bool,
      json['code'] as int,
    );

Map<String, dynamic> _$PhoneExistToJson(PhoneExist instance) =>
    <String, dynamic>{
      'exist': instance.exist,
      'nickname': instance.nickname,
      'hasPassword': instance.hasPassword,
      'code': instance.code,
    };
