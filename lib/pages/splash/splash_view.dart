import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);
    return Scaffold(
      body: Container(
        color: Colours.app_main,
        padding: EdgeInsets.only(top: controller.isFirst ? 100 : 255),
        height: Adapt.screenH(),
        width: Adapt.screenW(),
        child: Column(
          children: [
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (controller.isFirst) {
      return Image.asset(
        'assets/anim/cif.webp',
      );
    } else {
      return Image.asset(
        ImageUtils.getImagePath('e18'),
        height: Adapt.px(100),
        width: Adapt.px(100),
      );
    }
  }
}
