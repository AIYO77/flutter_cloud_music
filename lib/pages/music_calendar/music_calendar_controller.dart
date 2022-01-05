import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicCalendarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;

  final dates = List<DateTime>.empty(growable: true);

  @override
  void onInit() {
    super.onInit();
    final date = Get.parameters['date'] ??
        DateTime.now().millisecondsSinceEpoch.toString();
    initLabels();
    int initTabIndex = 2; //默认选中当前月
    final cur = DateTime.fromMillisecondsSinceEpoch(int.parse(date));
    final index = dates.indexWhere(
        (element) => element.year == cur.year && element.month == cur.month);
    if (index != -1) {
      initTabIndex = index;
    }
    tabController = TabController(
        vsync: this, length: dates.length, initialIndex: initTabIndex);

    pageController = PageController(initialPage: initTabIndex);
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    tabController.dispose();
    pageController.dispose();
  }

  void changeTab(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void pageChanged(int index) {
    tabController.animateTo(index);
  }

  void initLabels() {
    dates.clear();
    final now = DateTime.now();
    //当前月的前后两个月
    for (int i = 0; i < 5; i++) {
      if (i < 2) {
        //左边
        final month = now.month - (2 - i);
        if (month <= 0) {
          //前一年
          dates.add(DateTime(now.year - 1, 12 + month));
        } else {
          //同一年
          dates.add(DateTime(now.year, month));
        }
      } else if (i == 2) {
        //当前
        dates.add(now);
      } else {
        //右边
        final month = now.month + (i - 2);
        if (month > 12) {
          //下一年
          dates.add(DateTime(now.year + 1, month - 12));
        } else {
          //同一年
          dates.add(DateTime(now.year, month));
        }
      }
    }
  }

  List<Tab> getTabs() {
    return dates.map((e) => Tab(text: '${e.month}月')).toList();
  }
}
