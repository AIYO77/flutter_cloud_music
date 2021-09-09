import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:get/get.dart';

class PlaylistDetailController extends GetxController {
  String playlistId = ''; //歌单ID
  String autoplay = '0'; //自动播放 0否

  late double expandedHeight;

  //歌单详情
  final detail = Rx<PlaylistDetailModel?>(null);

  //图片
  final coverImage = Rx<ImageProvider?>(null);

  //是否是第二次打开官方歌单
  bool secondOpenOfficial = false;

  @override
  void onInit() {
    playlistId = Get.parameters['id'] ?? "";
    autoplay = Get.parameters['autoplay'] ?? "";

    secondOpenOfficial = box.read<bool>(playlistId) ?? false;
    expandedHeight = Adapt.px(secondOpenOfficial ? 380 : 256);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    final detailModel = await MusicApi.getPlaylistDetail(playlistId);
    detail.value = detailModel;
    if (detailModel?.playlist.officialPlaylistType == ALG_OP) {
      //官方歌单
      box.write(playlistId, true);
    }
  }

  @override
  void onClose() {}
}
