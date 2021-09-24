import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/home/widgets/drawer.dart';
import 'package:flutter_cloud_music/pages/home/widgets/home_top_bar.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/home_top_service.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  Future<bool> _dialogExitApp(BuildContext context) async {
    //Android 返回键 退回到桌面 不杀应用
    if (GetPlatform.isAndroid) {
      const intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);
    return Obx(() => WillPopScope(
        onWillPop: () {
          return _dialogExitApp(context);
        },
        child: Scaffold(
          appBar: HomeTopBar(
              bgDecoration: HomeTopService.to.isScrolled.value
                  ? BoxDecoration(color: Get.theme.cardColor)
                  : BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            HomeTopService.to.appBarBgColors.value
                                .withAlpha(25),
                            HomeTopService.to.appBarBgColors.value.withAlpha(15)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
              child: HomeTopService.to.appbarChild.value),
          drawer: const DrawerWidget(),
          body: Navigator(
            key: Get.nestedKey(1),
            initialRoute: Routes.FOUND,
            onGenerateRoute: controller.onGenerateRoute,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.foundation),
                label: '列表',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.details),
                label: '详情',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.login),
                label: '登录',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.label),
                label: '测试',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit),
                label: '雪花',
              )
            ],
            backgroundColor: Get.theme.cardColor,
            selectedItemColor: Colors.pink,
            showUnselectedLabels: true,
            elevation: 0,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
          ),
        )));
  }
}
