import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

class BottomPlayerController extends StatelessWidget {
  const BottomPlayerController(this.child);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final media = context.mediaQuery;
    final bool hide = isSoftKeyboardDisplay(media);
    return Column(
      children: <Widget>[
        Expanded(
          child: MediaQuery(
            data: media.copyWith(
              viewInsets: media.viewInsets.copyWith(bottom: 0),
              padding: media.padding.copyWith(bottom: hide ? null : 0),
            ),
            child: child,
          ),
        ),
        if (!hide) BottomPlayerBar(bottomPadding: media.padding.bottom),
        SizedBox(height: media.viewInsets.bottom)
      ],
    );
  }
}

class BottomPlayerBar extends StatelessWidget {
  const BottomPlayerBar({
    Key? key,
    this.bottomPadding = 0,
  }) : super(key: key);

  final double bottomPadding;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => context.playerService.watchPlayerValue.value?.currentId == null
          ? Gaps.empty
          : InkWell(
              onTap: () {
                // context.playerService.watchPlayerValue.value?.queue.isPlayingFm
                // Get.toNamed(page)
              },
              child: Container(),
            ),
    );
  }
}
