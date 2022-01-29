import 'package:flutter/cupertino.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:get/get.dart';

import 'state.dart';

class SingerDetailLogic extends GetxController
    with GetTickerProviderStateMixin {
  final state = SingerDetailState();

  @override
  void onInit() {
    super.onInit();
    state.accountId = Get.arguments['accountId']?.toString();
    state.artistId = Get.arguments['artistId']?.toString();
    state.detail.listen((detail) {
      if (detail?.isSinger == true) {
        //是歌手
        //初始化动画
        _initAnimation();
        // 获取相似歌手推荐
        _getSimiArtist();
      }
    });
    state.scrollController.addListener(_onScroll);
  }

  @override
  void onReady() {
    super.onReady();
    _getDetail();
  }

  void _getDetail() {
    if (GetUtils.isNullOrBlank(state.accountId) == true) {
      //获取歌手详情
      MusicApi.getSingerInfo(state.artistId!).then((value) {
        state.detail.value = value?.detail;
      });
    } else {
      //获取用户详情（也包含歌手）
      MusicApi.getUserDetail(state.accountId!).then((value) {
        state.detail.value = value?.detail;
      });
    }
  }

  void _getSimiArtist() {
    MusicApi.getSimiArtist(state.getArtistId().toString()).then((value) {
      state.simiItems.value = value;
    });
  }

  @override
  void onClose() {
    state.animController?.dispose();
    state.scrollController.removeListener(_onScroll);
    state.scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    final renderBox =
        state.tabKey.currentContext?.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero); //组件坐标
    final tabTop = offset?.dy ?? 0;
    if (state.barBottom == null) {
      final barBox =
          state.barKey.currentContext?.findRenderObject() as RenderBox?;
      final barOffset = barBox?.localToGlobal(Offset(0.0, barBox.size.height));
      state.barBottom = barOffset?.dy;
    }

    state.isPinned.value = tabTop <= (state.barBottom ?? 0);
  }

  void _initAnimation() {
    if (state.animation == null) {
      state.animController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300));
      state.animation =
          Tween(begin: 0.0, end: 1.0).animate(state.animController!)
            ..addListener(() {
              state.animValue.value = state.animation!.value;
            });
    }
  }
}
