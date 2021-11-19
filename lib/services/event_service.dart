import 'dart:async';

import 'package:flutter_cloud_music/common/event/http_error_event.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/net/code.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EventService extends GetxService {
  late StreamSubscription stream;
  @override
  void onInit() {
    stream = eventBus.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
    super.onInit();
  }

  @override
  void onClose() {
    stream.cancel();
    super.onClose();
  }

  ///网络错误提醒
  void errorHandleFunction(int code, String message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        showToast('网络错误');
        break;
      case 301:
        showToast('需要登录');
        Get.toNamed(Routes.LOGIN);
        break;
      case 403:
        showToast('权限错误');
        break;
      case 404:
        showToast('404错误');
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        showToast('请求超时');
        break;
      default:
        showToast(message);
        break;
    }
  }

  void showToast(String message) {
    Get.log(message, isError: true);
    toast(message);
  }
}
