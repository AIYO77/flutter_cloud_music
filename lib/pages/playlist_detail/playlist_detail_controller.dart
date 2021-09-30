import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/enum/enum.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:get/get.dart';

class PlaylistDetailController extends GetxController {
  String playlistId = ''; //歌单ID
  String autoplay = '0'; //自动播放 0否

  late double expandedHeight;

  //top content info key
  final GlobalKey topContentKey = GlobalKey();
  //appbar key
  final GlobalKey appBarKey = GlobalKey();

  //歌单详情
  final detail = Rx<PlaylistDetailModel?>(null);

  //图片
  final coverImage = Rx<ImageProvider?>(null);

  //标题状态
  final titleStatus = Rx<PlayListTitleStatus>(PlayListTitleStatus.Normal);

  //是否是官方歌单
  final isOfficial = false.obs;

  //全部歌曲集合
  final songs = Rx<List<Song>?>(null);

  //是否是第二次打开官方歌单
  bool secondOpenOfficial = false;

  @override
  void onInit() {
    playlistId = Get.parameters['id'] ?? "";
    autoplay = Get.parameters['autoplay'] ?? "";

    secondOpenOfficial = box.read<bool>(playlistId) ?? false;

    expandedHeight =
        Adapt.px(secondOpenOfficial ? Adapt.screenH() * 0.55 : 256);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ));
    super.onInit();
  }

  @override
  InternalFinalCallback<void> get onDelete =>
      InternalFinalCallback(callback: () {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ));
      });

  @override
  Future<void> onReady() async {
    final detailModel = await MusicApi.getPlaylistDetail(playlistId);
    if (detailModel?.playlist.officialPlaylistType == ALG_OP) {
      //官方歌单
      isOfficial.value = true;
      box.write(playlistId, true);
    }
    List<Song>? result;
    if (detailModel?.playlist.trackIds.length !=
        detailModel?.playlist.tracks.length) {
      //歌曲数量和歌曲ID不一致,请求全部歌曲{id,id}
      //如果ids>1000分批请求
      final idLength = detailModel!.playlist.trackIds.length;
      if (idLength > 1000) {
        for (var i = 0; i < (idLength / 1000).ceil(); i++) {
          final start = 1000 * i;
          int end = 1000 * (i + 1);
          end = end > idLength + 1 ? idLength : end;
          final idList = detailModel.playlist.trackIds
              .getRange(start, end)
              .map((e) => e.id.toString());
          final ids = idList.reduce((value, element) => '$value,$element');

          final data = await MusicApi.getSongsInfo(ids);

          result ??= List.empty(growable: true);
          result.addAll(data!);

          logger.d(
              'id length = ${idList.length} request length = ${data.length} result lenght = ${result.length}');
        }
      } else {
        //小于一千 直接请求
        final ids = detailModel.playlist.trackIds
            .map((e) => e.id.toString())
            .reduce((value, element) => '$value,$element');
        result = await MusicApi.getSongsInfo(ids);
      }
    } else {
      result = detailModel?.playlist.tracks;
    }
    detail.value = detailModel;
    songs.value = result;
  }

  @override
  void onClose() {}

  double clipOffset() {
    double offset = 0.0;
    final RenderBox? barRender =
        appBarKey.currentContext?.findRenderObject() as RenderBox?;

    final RenderBox? contentRender =
        topContentKey.currentContext?.findRenderObject() as RenderBox?;

    if (barRender != null && contentRender != null) {
      final barUnderY = barRender
          .localToGlobal(Offset(0.0, barRender.size.height))
          .dy; //bar的底部的Y坐标
      final contentTopY =
          contentRender.localToGlobal(Offset.zero).dy; //内容的顶部Y坐标
      // Get.log('barUnderY = $barUnderY  contentTopY = $contentTopY');
      if (contentTopY <= barUnderY) {
        //内容超过了appbar的底部区域 裁剪
        offset = barUnderY - contentTopY;
      } else {
        offset = 0.0;
      }
    }
    return offset;
  }
}
