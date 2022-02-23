import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/list_song_check_controller.dart';
import 'package:get/get.dart';

class NewSongAlbumController extends CheckSongController
    with GetTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: '新歌'),
    const Tab(text: '新碟'),
  ];

  late TabController tabController;

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

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
