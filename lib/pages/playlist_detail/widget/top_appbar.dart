import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:get/get.dart';

import '../playlist_detail_controller.dart';

class PlaylistTopAppbar extends StatelessWidget {
  final controller = Get.find<PlaylistDetailController>();

  PlaylistTopAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colours.app_main,
        );
  }
}
