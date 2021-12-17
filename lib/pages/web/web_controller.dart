import 'dart:developer';

import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebController extends GetxController {
  late String url;

  final title = ''.obs;

  final progress = 0.0.obs;

  late InAppWebViewController webController;

  @override
  void onInit() {
    url = Get.parameters['url'].toString();
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {
    webController.clearFocus();
  }
}
