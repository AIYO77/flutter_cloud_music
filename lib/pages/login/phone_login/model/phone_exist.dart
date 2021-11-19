import 'package:json_annotation/json_annotation.dart';

part 'phone_exist.g.dart';

@JsonSerializable()
class PhoneExist extends Object {
  @JsonKey(name: 'exist')
  int exist;

  @JsonKey(name: 'nickname')
  String? nickname;

  @JsonKey(name: 'hasPassword')
  bool hasPassword;

  @JsonKey(name: 'code')
  int code;

  PhoneExist(
    this.exist,
    this.nickname,
    this.hasPassword,
    this.code,
  );

  factory PhoneExist.fromJson(Map<String, dynamic> srcJson) =>
      _$PhoneExistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PhoneExistToJson(this);
}
