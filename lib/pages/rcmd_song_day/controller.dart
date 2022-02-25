import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/utils/list_song_check_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:music_player/music_player.dart';

import 'index.dart';

class RcmdSongDayController extends CheckSongController {
  RcmdSongDayController();

  final state = RcmdSongDayState();

  List<Song> items() => state.rcmdModel.value?.dailySongs ?? List.empty();

  //列表中随机一直图当背景
  final randomPic = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _requestData();
    showCheck.listen((p0) {});
  }

  Future<void> _requestData() async {
    MusicApi.getRcmdSongs().then((value) {
      if (value != null) {
        for (final reason in value.recommendReasons) {
          final index = value.dailySongs
              .indexWhere((element) => element.id == reason.songId);
          if (index != -1) {
            value.dailySongs.elementAt(index).reason = reason.reason;
          }
        }
        final index = Random().nextInt(value.dailySongs.length);
        randomPic.value = value.dailySongs.elementAt(index).al.picUrl ?? '';
      }
      state.rcmdModel.value = value;
    });
  }

  void playList(BuildContext context, {Song? song}) {
    context.player.playWithQueue(
        PlayQueue(
            queueId:
                DateFormat(DateFormat.YEAR_MONTH_DAY).format(DateTime.now()),
            queueTitle: '每日推荐',
            queue: items().toMetadataList()),
        metadata: song?.metadata);
  }
}
