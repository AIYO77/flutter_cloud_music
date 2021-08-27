// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      (json['banners'] as List<dynamic>)
          .map((e) => Banner.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'banners': instance.banner,
    };

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner(
      json['bannerId'] as String?,
      json['pic'] as String?,
      json['titleColor'] as String?,
      json['requestId'] as String?,
      json['exclusive'] as bool,
      json['scm'] as String?,
      json['song'] == null
          ? null
          : Song.fromJson(json['song'] as Map<String, dynamic>),
      json['targetId'] as int,
      json['showAdTag'] as bool,
      json['targetType'] as int,
      json['typeTitle'] as String?,
      json['url'] as String?,
      json['encodeId'] as String?,
    );

Map<String, dynamic> _$BannerToJson(Banner instance) => <String, dynamic>{
      'bannerId': instance.bannerId,
      'pic': instance.pic,
      'titleColor': instance.titleColor,
      'requestId': instance.requestId,
      'exclusive': instance.exclusive,
      'scm': instance.scm,
      'song': instance.song,
      'targetId': instance.targetId,
      'showAdTag': instance.showAdTag,
      'targetType': instance.targetType,
      'typeTitle': instance.typeTitle,
      'url': instance.url,
      'encodeId': instance.encodeId,
    };
