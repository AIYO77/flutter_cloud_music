import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ume/flutter_ume.dart'; // UME 框架
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart'; // debugPrint 插件包
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart'; // 设备信息插件包
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart'; // 性能插件包
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart'; // UI 插件包
import 'package:get/get_utils/get_utils.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';

Future<void> main() async {
  await GetStorage.init();
  if (kDebugMode) {
    PluginManager.instance
      ..register(const WidgetInfoInspector())
      ..register(const WidgetDetailInspector())
      ..register(const ColorSucker())
      ..register(Console())
      ..register(AlignRuler())
      ..register(Performance())
      ..register(const MemoryInfoPage())
      ..register(CpuInfoPage());
    // ..register(const DeviceInfoPanel());

    runZonedGuarded(() {
      runApp(injectUMEWidget(child: musicApp(), enable: true));
    }, (Object obj, StackTrace stack) {
      Get.log(obj.toString());
      Get.log(stack.toString());
    });
  } else {
    runApp(musicApp());
  }
  //必须放着runApp之后执行，在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值
  if (GetPlatform.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  if (GetPlatform.isIOS) {
    const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(dark);
  }
}
