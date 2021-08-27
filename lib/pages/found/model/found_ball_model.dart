import 'package:json_annotation/json_annotation.dart';

part 'found_ball_model.g.dart';

@JsonSerializable()
class Ball extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'iconUrl')
  String iconUrl;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'skinSupport')
  bool skinSupport;

  @JsonKey(name: 'homepageMode')
  String homepageMode;

  Ball(
    this.id,
    this.name,
    this.iconUrl,
    this.url,
    this.skinSupport,
    this.homepageMode,
  );

  factory Ball.fromJson(Map<String, dynamic> srcJson) =>
      _$BallFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BallToJson(this);
}
