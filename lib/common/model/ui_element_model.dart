import 'package:json_annotation/json_annotation.dart';

part 'ui_element_model.g.dart';

@JsonSerializable()
class UiElementModel extends Object {
  @JsonKey(name: 'mainTitle')
  TitleText? mainTitle;

  @JsonKey(name: 'subTitle')
  TitleText? subTitle;

  @JsonKey(name: 'image')
  ElementImage? image;

  @JsonKey(name: 'button')
  ElementButton? button;

  @JsonKey(name: 'labelTexts')
  List<String>? labelTexts;

  @JsonKey(name: 'labelUrls')
  List<String>? labelUrls;

  @JsonKey(name: 'rcmdShowType')
  String? rcmdShowType;

  @JsonKey(name: 'labelType')
  String? labelType;

  UiElementModel(
    this.mainTitle,
    this.subTitle,
    this.image,
    this.button,
    this.labelTexts,
    this.labelUrls,
    this.rcmdShowType,
    this.labelType,
  );

  factory UiElementModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UiElementModelFromJson(srcJson);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'mainTitle': mainTitle?.toJson(),
        'subTitle': subTitle?.toJson(),
        'image': image?.toJson(),
        'button': button?.toJson(),
        'labelTexts': labelTexts,
        'labelUrls': labelUrls,
        'rcmdShowType': rcmdShowType,
        'labelType': labelType,
      };
}

@JsonSerializable()
class TitleText extends Object {
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'titleType')
  String? titleType;

  @JsonKey(name: 'titleImgUrl')
  String? titleImgUrl;

  TitleText(this.title, this.titleType, this.titleImgUrl);

  factory TitleText.fromJson(Map<String, dynamic> srcJson) =>
      _$TitleTextFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TitleTextToJson(this);
}

@JsonSerializable()
class ElementImage extends Object {
  @JsonKey(name: 'imageUrl')
  String? imageUrl;

  ElementImage(
    this.imageUrl,
  );

  factory ElementImage.fromJson(Map<String, dynamic> srcJson) =>
      _$ElementImageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ElementImageToJson(this);
}

@JsonSerializable()
class ElementButton extends Object {
  @JsonKey(name: 'action')
  String? action;

  @JsonKey(name: 'actionType')
  String? actionType;

  @JsonKey(name: 'text')
  String? text;

  @JsonKey(name: 'iconUrl')
  String? iconUrl;

  ElementButton(
    this.action,
    this.actionType,
    this.text,
    this.iconUrl,
  );

  factory ElementButton.fromJson(Map<String, dynamic> srcJson) =>
      _$ElementButtonFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ElementButtonToJson(this);
}
