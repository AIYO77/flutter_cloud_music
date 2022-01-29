import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/singer_detail_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/user_detail_model.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

class SingerDetailState {
  //用户ID 如果是入驻歌手 也有用户ID
  String? accountId;

  //歌手ID 获取详情如果没有{accountId}就用这个ID
  String? artistId;

  //详情
  final detail = Rx<SingerOrUserDetail?>(null);

  //相似歌手推荐
  final simiItems = Rx<List<Ar>?>(null);

  SingerOrUserDetail? get detailValue => detail.value;

  //相似歌手收起动画
  Animation<double>? animation;
  AnimationController? animController;
  final animValue = 0.0.obs;

  //tab key
  late GlobalKey tabKey;
  //bar Key
  late GlobalKey barKey;
  double? barBottom;

  late ScrollController scrollController;

  //吸顶
  final isPinned = false.obs;

  SingerDetailState() {
    tabKey = GlobalKey();
    barKey = GlobalKey();
    scrollController = ScrollController();
  }

  void startAnim() {
    if (animController?.isAnimating == true) return;
    if (animValue.value == 0) {
      animController?.forward();
    } else {
      animController?.reverse();
    }
  }

  String getName() {
    return detailValue?.userDetail?.profile.artistName ??
        detailValue?.userDetail?.profile.nickname ??
        detailValue?.singerDetail?.artist.name ??
        '';
  }

  Identify? getIdentify() {
    return detailValue?.singerDetail?.identify ??
        detailValue?.userDetail?.identify;
  }

  String getAvatarUrl() {
    return detailValue?.userDetail?.profile.avatarUrl ??
        detailValue?.singerDetail?.user?.avatarUrl ??
        '';
  }

  String getBackgroundUrl() {
    return detailValue?.userDetail?.profile.backgroundUrl ??
        detailValue?.singerDetail?.user?.backgroundUrl ??
        detailValue?.singerDetail?.artist.cover ??
        '';
  }

  bool isSinger() {
    return getArtistId() != null;
  }

  int? getArtistId() {
    return detailValue?.userDetail?.profile.artistId ??
        detailValue?.singerDetail?.artist.id;
  }

  int? getUserId() {
    if (isSinger()) {
      return getArtistId();
    }
    return detailValue?.userDetail?.profile.userId;
  }

  bool isFollow() {
    return detailValue?.userDetail?.profile.followed ??
        detailValue?.singerDetail?.artist.followed ??
        detailValue?.singerDetail?.user?.followed ??
        false;
  }

  String getLevel() {
    String extension = '';
    if (detailValue?.userDetail != null) {
      extension +=
          '${getPlayCountStrFromInt(detailValue!.userDetail!.profile.follows)} 关注    ';
      extension +=
          '${getFansCountStr(detailValue!.userDetail!.profile.followeds)} 粉丝    ';
      extension +=
          'Lv.${getPlayCountStrFromInt(detailValue!.userDetail!.level)}';
    }
    return extension;
  }
}

class SingerOrUserDetail {
  final bool isSinger;

  final SingerDetailModel? singerDetail;

  final UserDetailModel? userDetail;

  const SingerOrUserDetail(this.isSinger, this.singerDetail, this.userDetail);
}
