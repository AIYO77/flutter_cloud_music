/*
 * @Author: XingWei 
 * @Date: 2021-11-10 20:17:03 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-11-11 17:11:25
 * 
 * 歌词view
 */
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/lyric.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/lyric/lyric_controller.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class PlayingLyricView extends StatelessWidget {
  PlayingLyricView({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  final controller = Get.put<LyricController>(LyricController());

  @override
  Widget build(BuildContext context) {
    return ProgressTrackingContainer(
        builder: _buildLyric, player: context.player);
  }

  Widget _buildLyric(BuildContext context) {
    return GetBuilder<LyricController>(
      init: controller,
      initState: (_) {
        controller.currentLyric();
      },
      builder: (c) {
        const style = TextStyle(height: 2, fontSize: 16, color: Colors.white);
        return c.hasLyric
            ? LayoutBuilder(
                builder: (context, constraints) {
                  final normalStyle =
                      style.copyWith(color: style.color!.withOpacity(0.7));
                  return ShaderMask(
                    shaderCallback: (rect) {
                      return ui.Gradient.linear(Offset(rect.width / 2, 0),
                          Offset(rect.width / 2, constraints.maxHeight), [
                        const Color(0x00FFFFFF),
                        style.color!,
                        style.color!,
                        const Color(0x00FFFFFF),
                      ], [
                        0.0,
                        0.15,
                        0.85,
                        1
                      ]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Lyric(
                        lyric: c.lyric!,
                        lyricLineStyle: normalStyle,
                        highlight: style.color,
                        position: context.playbackState?.computedPosition,
                        onTap: onTap,
                        size: Size(
                            constraints.maxWidth,
                            constraints.maxHeight == double.infinity
                                ? 0
                                : constraints.maxHeight),
                        playing: context.playbackState?.isPlaying == true,
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  c.message!,
                  style: style,
                ),
              );
      },
    );
  }
}
