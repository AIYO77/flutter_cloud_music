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
  int? playMaxbr;

  @JsonKey(name: 'maxbr')
  int? maxbr;

  @JsonKey(name: 'freeTrialPrivilege')
  FreeTrialPrivilege? freeTrialPrivilege;

  PrivilegeModel(
    this.id,
    this.fee,
    this.payed,
    this.preSell,
    this.playMaxbr,
    this.maxbr,
    this.freeTrialPrivilege,
  );

  factory PrivilegeModel.fromJson(Map<String, dynamic> srcJson) =>
      PrivilegeModel(
        srcJson['id'] as int,
        srcJson['fee'] as int,
        srcJson['payed'] as int,
        srcJson['preSell'] as bool,
        srcJson['playMaxbr'] as int?,
        srcJson['maxbr'] as int?,
        srcJson['freeTrialPrivilege'] == null
            ? null
            : FreeTrialPrivilege.fromJson(
                Map<String, dynamic>.from(srcJson['freeTrialPrivilege'])),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'fee': fee,
        'payed': payed,
        'preSell': preSell,
        'playMaxbr': playMaxbr,
        'maxbr': maxbr,
        'freeTrialPrivilege': freeTrialPrivilege?.toJson(),
      };

  int? getMaxPlayBr() {
    return playMaxbr ?? maxbr;
  }
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
