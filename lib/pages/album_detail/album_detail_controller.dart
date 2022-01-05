import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/album_detail.dart';
import 'package:flutter_cloud_music/common/model/album_dynamic_info.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/enum/enum.dart';
import 'package:get/get.dart';

class AlbumDetailController extends GetxController {
  late String albumId;
  double appbarHeight = 0.0;
  double expandedHeight = Adapt.px(256);
  //标题状态
  final titleStatus = Rx<PlayListTitleStatus>(PlayListTitleStatus.Normal);
  //图片
  final coverImage = Rx<ImageProvider?>(null);

  GlobalKey appBarKey = GlobalKey(debugLabel: 'album_detail');
  final GlobalKey topContentKey = GlobalKey(debugLabel: 'top_content');

  final albumDetail = Rx<AlbumDetail?>(null);
  final dynamicInfo = Rx<AlbumDynamicInfo?>(null);

  @override
  void onInit() {
    albumId = Get.parameters['id'] ?? "";
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    MusicApi.getAlbumDetail(albumId).then((value) {
      if (value == null) {
        Get.back();
      } else {
        albumDetail.value = value;
      }
    });
    MusicApi.getAlbumDynamicInfo(albumId).then((value) {
      dynamicInfo.value = value;
    });
  }

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
