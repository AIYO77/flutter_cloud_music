import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  final pageController = PageController();

  final pages = <String>[
    Routes.FOUND,
    Routes.PODCAST,
    Routes.MINE,
    Routes.K_SONG,
    Routes.CLOUD_VILLAGE
  ];

  @override
  void update([List<Object>? ids, bool condition = true]) {
    super.update(ids, condition);
    toast('HomeController onInit');
    logger.i('HomeController onInit');
  }

  @override
  void onClose() {}

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }
}
