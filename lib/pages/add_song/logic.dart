import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/event/mine_pl_content_event.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddSongLogic extends GetxController {
  // 最近播放列表
  final items = Rx<List<Song>?>(null);

  //歌单ID
  late String pid;

  //是否添加了
  bool isAdded = false;

  @override
  void onInit() {
    super.onInit();
    pid = Get.arguments as String? ?? '';
  }

  @override
  void onReady() {
    super.onReady();
    _getRecentPlay();
  }

  ///获取最近播放
  void _getRecentPlay() {
    MusicApi.getRecentPlay().then((value) {
      items.value = value;
    });
  }

  ///添加音乐到歌单
  Future<void> addMusicToPl(Song song) async {
    EasyLoading.show();
    final result =
        await MusicApi.addOrDelTracks(op: 'add', pid: pid, trackIds: [song.id]);
    if (result) {
      EasyLoading.instance.successWidget = Image.asset(
        ImageUtils.getImagePath('btn_add'),
        width: Dimens.gap_dp40,
        color: Colours.app_main_light,
      );
      EasyLoading.showSuccess('已收藏到歌单');
      EasyLoading.instance.successWidget = null;
      isAdded = true;
    }
  }

  @override
  void onClose() {
    eventBus.fire(MinePlContentEvent(isAdded));
    super.onClose();
  }
}
