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
  final showSimiItems = false.obs;

  //tab key
  late GlobalKey tabKey;

  //bar Key
  late GlobalKey barKey;
  double? barBottom;

  late ScrollController scrollController;

  //吸顶
  final isPinned = false.obs;

  List<SingerTabModel>? tabs;
  TabController? tabController;

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

  int? getMusicSize() {
    if (detailValue?.userDetail != null) {
      return detailValue!.userDetail!.singerModel?.artist.musicSize;
    }
    if (detailValue?.singerDetail != null) {
      return detailValue!.singerDetail!.artist.musicSize;
    }
    return null;
  }

  int? getAlbumSize() {
    if (detailValue?.userDetail != null) {
      return detailValue!.userDetail!.singerModel?.artist.albumSize;
    }
    if (detailValue?.singerDetail != null) {
      return detailValue!.singerDetail!.artist.albumSize;
    }
    return null;
  }

  int? getMVSize() {
    if (detailValue?.userDetail != null) {
      return detailValue!.userDetail!.singerModel?.artist.mvSize;
    }
    if (detailValue?.singerDetail != null) {
      return detailValue!.singerDetail!.artist.mvSize;
    }
    return null;
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

  ///身份
  String? getSecondaryIdentity() {
    if (detailValue?.singerDetail?.secondaryExpertIdentiy != null) {
      return detailValue!.singerDetail!.secondaryExpertIdentiy!
          .map((e) => e.name)
          .join('、');
    }
    if (detailValue?.userDetail?.singerModel?.secondaryExpertIdentiy != null) {
      return detailValue!.userDetail!.singerModel!.secondaryExpertIdentiy!
          .map((e) => e.name)
          .join('、');
    }
    return null;
  }

  ///性别
  String getGender() {
    if (detailValue?.userDetail?.profile != null) {
      return detailValue!.userDetail!.profile.getGenderStr();
    }
    if (detailValue?.singerDetail?.user != null) {
      return detailValue!.singerDetail!.user!.getGenderStr();
    }
    return '';
  }

  ///生日和星座
  String getBirthday() {
    if (detailValue?.userDetail?.profile != null) {
      final birthday = detailValue!.userDetail!.profile.birthday;
      if (birthday > 0) {
        final date = DateTime.fromMillisecondsSinceEpoch(birthday);
        return '${date.year}-${date.month}-${date.day} ${getSignWithMd(m: date.month, d: date.day)}';
      }
    }
    if (detailValue?.singerDetail?.user != null) {
      final birthday = detailValue!.singerDetail!.user!.birthday;
      if (birthday > 0) {
        final date = DateTime.fromMillisecondsSinceEpoch(birthday);
        return '${date.year}-${date.month}-${date.day} ${getSignWithMd(m: date.month, d: date.day)}';
      }
    }
    return '';
  }

  ///简介
  String getDes() {
    if (isSinger()) {
      return detailValue?.singerDetail?.artist.briefDesc ??
          detailValue?.userDetail?.singerModel?.artist.briefDesc ??
          '';
    }
    if (detailValue?.userDetail?.profile != null) {
      return detailValue!.userDetail!.profile.description;
    }
    if (detailValue?.singerDetail?.user != null) {
      return detailValue!.singerDetail!.user!.description ?? '';
    }
    return '';
  }
}

class SingerOrUserDetail {
  final bool isSinger;

  final SingerDetailModel? singerDetail;

  final UserDetailModel? userDetail;

  const SingerOrUserDetail(this.isSinger, this.singerDetail, this.userDetail);
}

class SingerTabModel {
  final SingerTabType type;

  final String title;

  final int? num;

  const SingerTabModel({required this.type, required this.title, this.num});
}

enum SingerTabType {
  homePage,
  songPage,
  albumPage,
  evenPage,
  mvPage,
}
