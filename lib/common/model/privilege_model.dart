import 'package:json_annotation/json_annotation.dart';

part 'privilege_model.g.dart';

@JsonSerializable()
class PrivilegeModel extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'fee')
  int fee;

  @JsonKey(name: 'payed')
  int payed;

  @JsonKey(name: 'preSell')
  bool preSell;

  @JsonKey(name: 'playMaxbr')
  int playMaxbr;

  @JsonKey(name: 'freeTrialPrivilege')
  FreeTrialPrivilege freeTrialPrivilege;

  PrivilegeModel(
    this.id,
    this.fee,
    this.payed,
    this.preSell,
    this.playMaxbr,
    this.freeTrialPrivilege,
  );

  factory PrivilegeModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PrivilegeModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PrivilegeModelToJson(this);
}

@JsonSerializable()
class FreeTrialPrivilege extends Object {
  @JsonKey(name: 'resConsumable')
  bool resConsumable;

  @JsonKey(name: 'userConsumable')
  bool userConsumable;

  FreeTrialPrivilege(
    this.resConsumable,
    this.userConsumable,
  );

  factory FreeTrialPrivilege.fromJson(Map<String, dynamic> srcJson) =>
      _$FreeTrialPrivilegeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FreeTrialPrivilegeToJson(this);
}
