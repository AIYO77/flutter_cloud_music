import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart'; // 设备信息插件包
import 'package:flutter_ume_kit_dio/flutter_ume_kit_dio.dart'; // Dio 网络请求调试工具
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart'; // 性能插件包
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player/music_player.dart';

import 'app.dart';
import 'common/net/init_dio.dart';
import 'common/player/player_interceptors.dart';

Future<void> main() async {
  await GetStorage.init();
  // packageInfo = await PackageInfo.fromPlatform();

  WidgetsFlutterBinding.ensureInitialized();
  PluginManager.instance
    ..register(const WidgetInfoInspector())
    ..register(const WidgetDetailInspector())
    ..register(const ColorSucker())
    // ..register(Console())
    ..register(DioInspector(dio: httpManager.getDio()))
    ..register(AlignRuler())
    ..register(Performance())
    ..register(const MemoryInfoPage())
    ..register(CpuInfoPage());
  // ..register(const DeviceInfoPanel());

  runZonedGuarded(() {
    runApp(UMEWidget(enable: kDebugMode, child: musicApp()));
  }, (Object obj, StackTrace stack) {
    Get.log(obj.toString());
    Get.log(stack.toString());
  });
}

@pragma('vm:entry-point')
void playerBackgroundService() {
  logger.d('start playerBackgroundService');
  WidgetsFlutterBinding.ensureInitialized();
  GetInstance().put(AuthService());
  runBackgroundService(
    imageLoadInterceptor: PlayerInterceptors.loadImageInterceptor,
    playUriInterceptor: PlayerInterceptors.playUriInterceptor,
    playQueueInterceptor: QuietPlayQueueInterceptor(),
  );
}
