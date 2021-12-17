import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'web_controller.dart';

class WebPage extends GetView<WebController> {
  const WebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: MyAppBar(
            centerTitle: controller.title.value,
            onPressed: () {
              controller.webController.canGoBack().then((value) {
                value ? controller.webController.goBack() : Get.back();
              });
            },
          ),
          body: Column(
            children: [
              SizedBox(
                height: controller.progress.value == 1 ? 0 : Dimens.gap_dp1,
                width: Adapt.screenW(),
                child: LinearProgressIndicator(
                  value: controller.progress.value,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Get.isDarkMode ? Colors.white : Colours.app_main),
                ),
              ),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(controller.url),
                  ),
                  onWebViewCreated: (webController) {
                    controller.webController = webController;
                  },
                  onProgressChanged: (webController, progress) {
                    controller.progress.value = progress / 100;
                  },
                  onTitleChanged: (webController, title) {
                    controller.title.value = title ?? '';
                  },
                ),
              )
            ],
          ),
        ));
  }
}
