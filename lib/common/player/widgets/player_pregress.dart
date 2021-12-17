import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/time.dart';
import 'package:music_player/music_player.dart';

//带时间的进度条
class DurationProgressBar extends StatefulWidget {
  @override
  DurationProgressBarState createState() => DurationProgressBarState();
}

class DurationProgressBarState extends State<DurationProgressBar> {
  bool isUserTracking = false;

  double trackingPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return ProgressTrackingContainer(
        builder: _buildBar, player: context.player);
  }

  Widget _buildBar(BuildContext context) {
    final state = context.playbackState;
    Widget progressIndicator;

    String? durationText;
    String? positionText;
    if (state?.initialized == true) {
      final duration = context.playerValueRx.value?.metadata?.duration ?? 100;
      final position = state?.computedPosition ?? 1;

      durationText = getTimeStamp(duration);
      positionText = getTimeStamp(position);

      // final int maxBuffering = state!.bufferedPosition;
      // logger.d('maxBuffering = $maxBuffering');
      progressIndicator = Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          // LinearProgressIndicator(
          //   value: maxBuffering / duration,
          //   valueColor: const AlwaysStoppedAnimation<Color>(Colors.white70),
          //   backgroundColor: Colors.white12,
          // ),
          Slider(
            value: position.toDouble().clamp(0.0, duration.toDouble()),
            activeColor: Colors.white.withOpacity(0.75),
            inactiveColor: Colors.white.withOpacity(0.3),
            thumbColor: Colours.color_217,
            max: duration.toDouble(),
            onChangeStart: (value) {
              setState(() {
                isUserTracking = true;
                trackingPosition = value;
              });
            },
            onChanged: (value) {
              setState(() {
                trackingPosition = value;
              });
            },
            onChangeEnd: (value) async {
              isUserTracking = false;
              context.transportControls
                ..seekTo(value.round())
                ..play();
            },
          ),
        ],
      );
    } else {
      progressIndicator = Slider(value: 0, onChanged: (_) => {});
    }
    return Container(
        height: Dimens.gap_dp20,
        margin: EdgeInsets.only(top: Dimens.gap_dp10),
        child: SliderTheme(
          data: SliderThemeData(
              trackHeight: Dimens.gap_dp2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
            child: Row(
              children: <Widget>[
                Text(positionText ?? "00:00",
                    style: TextStyle(
                        color: Colors.white54, fontSize: Dimens.font_sp10)),
                // Padding(padding: EdgeInsets.only(left: Dimens.gap_dp4)),
                Expanded(
                  child: progressIndicator,
                ),
                // Padding(padding: EdgeInsets.only(left: Dimens.gap_dp4)),
                Text(durationText ?? "00:00",
                    style: TextStyle(
                        color: Colors.white54, fontSize: Dimens.font_sp10)),
              ],
            ),
          ),
        ));
  }
}
