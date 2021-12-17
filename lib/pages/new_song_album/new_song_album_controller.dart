import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewSongAlbumController extends GetxController
    with SingleGetTickerProviderMixin {
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
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    tabController.dispose();
  }
}
