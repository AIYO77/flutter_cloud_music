import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class LoadingLogic extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final route = Get.parameters['route'];
    switch ('/$route') {
      case Routes.PRIVATE_FM:
        //私人FM 获取歌曲
        _getFmSongs();
        break;
    }
  }

  Future<void> _getFmSongs() async {
    EasyLoading.show(status: '加载中...');
    final data = await MusicApi.getFmMusics();
    if (GetUtils.isNullOrBlank(data) == true) {
      EasyLoading.showError('获取失败');
    } else {
      PlayerService.to.player.playFm(data);
      Future.delayed(const Duration(milliseconds: 1000)).then((value) {
        EasyLoading.dismiss();
        Get.offAndToNamed(Routes.PRIVATE_FM);
      });
    }
  }
}
