import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:get/get.dart';

class BottomPlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: Adapt.screenW(),
          // height: PlayerService.to.curPlay,
          color: Get.theme.cardColor,
        ));
  }
}
