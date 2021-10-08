import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:get/get.dart';

class BottomPlayerController extends StatelessWidget {
  const BottomPlayerController(this.child);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: child),
        Positioned(
          bottom: 0,
          child: BottomPlayerBar(bottomPadding: Adapt.bottomPadding()),
        )
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
    final backgroundColor = Get.theme.cardColor.withOpacity(0.98);
    return Obx(
      () => context.playerValueRx.value?.currentId == null
          ? Gaps.empty
          : InkWell(
              onTap: () {
                // context.playerService.watchPlayerValue.value?.queue.isPlayingFm
                // Get.toNamed(page)
              },

              ///Fm : 48  other: 58
              child: MediaQuery(
                data: context.mediaQuery.copyWith(
                  viewInsets: context.mediaQueryViewInsets.copyWith(bottom: 0),
                ),
                child: SizedBox(
                  height: context.playerValueRx.value!.queue.isPlayingFm
                      ? Dimens.gap_dp48 + bottomPadding
                      : Dimens.gap_dp58 + bottomPadding,
                  width: Adapt.screenW(),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    border: Border(
                                        top: BorderSide(
                                            color: Get.theme.dividerColor
                                                .withOpacity(0.5),
                                            width: Dimens.gap_dp1))),
                                margin: EdgeInsets.only(
                                    top: context.playerValueRx.value!.queue
                                            .isPlayingFm
                                        ? 0
                                        : Dimens.gap_dp4),
                              ),
                            ),
                            Row(
                              crossAxisAlignment:
                                  context.playerValueRx.value!.queue.isPlayingFm
                                      ? CrossAxisAlignment.center
                                      : CrossAxisAlignment.start,
                              children: [],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: bottomPadding,
                        width: Adapt.screenW(),
                        color: backgroundColor,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
