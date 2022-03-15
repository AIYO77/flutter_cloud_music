import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVideoLogic extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
}
