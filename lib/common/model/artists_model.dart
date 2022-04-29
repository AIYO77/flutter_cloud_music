import 'package:json_annotation/json_annotation.dart';

part 'artists_model.g.dart';

@JsonSerializable()
class ArtistsModel extends Object {
  @JsonKey(name: 'artists')
  List<Artists> artists;

  @JsonKey(name: 'more')
  bool more;

  ArtistsModel(
    this.artists,
    this.more,
  );

  factory ArtistsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistsModelToJson(this);
}

@JsonSerializable()
class Artists extends Object {
  @JsonKey(name: 'accountId')
  int? accountId;

  @JsonKey(name: 'albumSize')
  int albumSize;

  @JsonKey(name: 'alias')
  List<String> alias;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'img1v1Url')
  String img1v1Url;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'trans')
  String? trans;

  @JsonKey(name: 'mvSize')
  int? mvSize;

  @JsonKey(name: 'identityIconUrl')
  String? identityIconUrl;

  Artists(this.accountId, this.albumSize, this.alias, this.followed, this.id,
      this.img1v1Url, this.name, this.trans, this.mvSize, this.identityIconUrl);

  factory Artists.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistsToJson(this);

  String getArName() {
    if (trans != null && trans!.isNotEmpty) {
      return '$name（$trans）';
    } else if (alias.isNotEmpty) {
      return '$name（${alias.join('/')}）';
    } else {
      return name;
    }
  }

  String? getExtraStr() {
    if (trans != null && trans!.isNotEmpty) {
      return '（$trans）';
    } else if (alias.isNotEmpty) {
      return '（${alias.join('/')}）';
    }
    return null;
  }
}
