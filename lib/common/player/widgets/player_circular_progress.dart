import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/player_common_widget.dart';
import 'package:flutter_cloud_music/common/player/widgets/player_progress_container.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class CircularContollerbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CircularContollerbarState();
}

class CircularContollerbarState extends State<CircularContollerbar> {
  @override
  Widget build(BuildContext context) {
    return PlayerProgressContainer(builder: _buildBar, player: context.player);
  }

  Widget _buildBar(BuildContext context) {
    final state = context.playbackState;
    final color = Get.isDarkMode ? Colors.white : Colors.black;

    final duration = context.playerValueRx.value?.metadata?.duration ?? 100;
    final position = state?.computedPosition ?? 1;

    final Widget progressIndicator = CircularProgressIndicator(
      value: (state?.initialized == true && duration > 0)
          ? (position / duration)
          : 0,
      backgroundColor: color.withOpacity(0.08),
      strokeWidth: Adapt.px(1.5),
      color: color,
    );
    return Container(
      height: Dimens.gap_dp29,
      width: Dimens.gap_dp29,
      margin: EdgeInsets.only(
          top: context.player.queue.isPlayingFm ? 0.0 : Dimens.gap_dp13),
      child: GestureDetector(
        onTap: () {
          if (context.player.playbackStateListenable.value.state ==
              PlayerState.Playing) {
            context.transportControls.pause();
          } else {
            context.transportControls.play();
          }
        },
        child: Stack(
          children: [
            Positioned.fill(child: progressIndicator),
            Center(
              child: PlayingIndicator(
                playing: Image.asset(
                  ImageUtils.getImagePath('bwq'),
                  width: Dimens.gap_dp16,
                  fit: BoxFit.cover,
                  color: color,
                ),
                pausing: Padding(
                  padding: EdgeInsets.only(left: Dimens.gap_dp2),
                  child: Image.asset(
                    ImageUtils.getImagePath('bwr'),
                    width: Dimens.gap_dp16,
                    fit: BoxFit.cover,
                    color: color,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
