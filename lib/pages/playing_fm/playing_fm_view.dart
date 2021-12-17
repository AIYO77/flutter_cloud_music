import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/blur_background.dart';
import 'package:get/get.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'playing_fm_controller.dart';

class PlayingFmPage extends GetView<PlayingFmController> {
  const PlayingFmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(() => BlurBackground(
                musicCoverUrl: context.playerValueRx.value?.current?.al.picUrl,
              )),
        ],
      ),
    );
  }
}
