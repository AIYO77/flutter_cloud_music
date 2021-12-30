import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:get/get.dart';

class NewSongAlbumController extends GetxController
    with SingleGetTickerProviderMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: '新歌'),
    const Tab(text: '新碟'),
  ];

  late TabController tabController;

  //底部歌曲控制栏动画
  late AnimationController controller;
  late Animation<Offset> animation;
  //是否展示编辑
  final showCheck = false.obs;
  //已选中的歌曲
  final selectedSong = Rx<List<Song>?>(null);

  @override
  void onInit() {
    final tabName = Get.parameters['tab']?.toString();
    tabController = TabController(
        initialIndex: tabName == null || tabName == 'song' ? 0 : 1,
        length: myTabs.length,
        vsync: this);
    tabController.addListener(() {
      showCheck.value = false;
      selectedSong.value = null;
    });
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    //从下到上
    animation = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(controller);
    super.onInit();
  }

  @override
  void onReady() {
    showCheck.listen((p0) {
      selectedSong.value = null;
      if (p0) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    controller.dispose();
  }
}
