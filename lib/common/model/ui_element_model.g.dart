// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_element_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UiElementModel _$UiElementModelFromJson(Map<String, dynamic> json) =>
    UiElementModel(
      json['mainTitle'] == null
          ? null
          : TitleText.fromJson(json['mainTitle'] as Map<String, dynamic>),
      json['subTitle'] == null
          ? null
          : TitleText.fromJson(json['subTitle'] as Map<String, dynamic>),
      json['image'] == null
          ? null
          : ElementImage.fromJson(json['image'] as Map<String, dynamic>),
      json['button'] == null
          ? null
          : ElementButton.fromJson(json['button'] as Map<String, dynamic>),
      (json['labelTexts'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['labelUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['rcmdShowType'] as String?,
      json['labelType'] as String?,
    );

Map<String, dynamic> _$UiElementModelToJson(UiElementModel instance) =>
    <String, dynamic>{
      'mainTitle': instance.mainTitle,
      'subTitle': instance.subTitle,
      'image': instance.image,
      'button': instance.button,
      'labelTexts': instance.labelTexts,
      'labelUrls': instance.labelUrls,
      'rcmdShowType': instance.rcmdShowType,
      'labelType': instance.labelType,
    };

TitleText _$TitleTextFromJson(Map<String, dynamic> json) => TitleText(
      json['title'] as String?,
      json['titleType'] as String?,
      json['titleImgUrl'] as String?,
    );

Map<String, dynamic> _$TitleTextToJson(TitleText instance) => <String, dynamic>{
      'title': instance.title,
      'titleType': instance.titleType,
      'titleImgUrl': instance.titleImgUrl,
    };

ElementImage _$ElementImageFromJson(Map<String, dynamic> json) => ElementImage(
      json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ElementImageToJson(ElementImage instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
    };

ElementButton _$ElementButtonFromJson(Map<String, dynamic> json) =>
    ElementButton(
      json['action'] as String?,
      json['actionType'] as String?,
      json['text'] as String?,
      json['iconUrl'] as String?,
    );

Map<String, dynamic> _$ElementButtonToJson(ElementButton instance) =>
    <String, dynamic>{
      'action': instance.action,
      'actionType': instance.actionType,
      'text': instance.text,
      'iconUrl': instance.iconUrl,
    };
