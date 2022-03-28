import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/video_api.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/event/index.dart';
import '../../common/event/mine_pl_content_event.dart';
import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import '../../common/utils/image_utils.dart';

class AddVideoLogic extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  //歌单ID
  late String pid;
  //是否添加了
  bool isAdded = false;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    pid = Get.arguments as String? ?? '';
    logger.i(pid);
  }

  ///添加音乐到歌单
  Future<void> addVideoToPl(dynamic id) async {
    EasyLoading.show();
    final result = await VideoApi.addVideoToPl(pid: pid, ids: [id]);
    if (result) {
      EasyLoading.instance.successWidget = Image.asset(
        ImageUtils.getImagePath('btn_add'),
        width: Dimens.gap_dp40,
        color: Colours.app_main_light,
      );
      EasyLoading.showSuccess('已收藏到歌单');
      EasyLoading.instance.successWidget = null;
      isAdded = true;
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    eventBus.fire(MinePlContentEvent(isAdded));
    super.onClose();
  }
}
