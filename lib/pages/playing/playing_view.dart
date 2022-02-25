import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/lyric/playing_lyric_view.dart';
import 'package:flutter_cloud_music/common/player/widgets/player_common_widget.dart';
import 'package:flutter_cloud_music/common/player/widgets/player_pregress.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/playing_list/page_playing_list.dart';
import 'package:flutter_cloud_music/widgets/blur_background.dart';
import 'package:flutter_cloud_music/widgets/comment_button.dart';
import 'package:flutter_cloud_music/widgets/like_button.dart';
import 'package:flutter_cloud_music/widgets/play_album_cover.dart';
import 'package:flutter_cloud_music/widgets/playing_title.dart';
import 'package:get/get.dart';

import 'playing_controller.dart';

class PlayingPage extends GetView<PlayingController> {
  const PlayingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          //背景
          Obx(() => BlurBackground(
              musicCoverUrl: context.curPlayRx.value?.al.picUrl)),
          Material(
            color: Colors.transparent,
            child: Column(
              children: [
                //标题bar
                Obx(() => PlayingTitle(song: context.curPlayRx.value)),
                //唱片动画
                Obx(() => _CenterSection(music: controller.curPlaying.value)),
                //点赞等操作
                _PlayingOperationBar(),
                //进度条
                DurationProgressBar(),
                //控制器
                PlayerControllerBar()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PlayingOperationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const iconColor = Colours.color_217;
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.gap_dp6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FavoriteButton(),
          IconButton(
              icon: Image.asset(
                ImageUtils.getImagePath('icn_download'),
                color: iconColor,
                width: Dimens.gap_dp24,
              ),
              onPressed: () {
                notImplemented(context);
              }),
          Obx(() => CommentButton(
                songId: context.curPlayRx.value?.id.toString() ?? '',
              )),
          IconButton(
              iconSize: Dimens.gap_dp24,
              icon: Image.asset(
                ImageUtils.getImagePath('play_icn_more'),
                color: iconColor,
              ),
              onPressed: () {
                notImplemented(context);
              }),
        ],
      ),
    );
  }
}

//独有的 FM另一种样式
class _CenterSection extends StatefulWidget {
  const _CenterSection({Key? key, this.music}) : super(key: key);
  final Song? music;

  @override
  State<StatefulWidget> createState() => _CenterSectionState();
}

class _CenterSectionState extends State<_CenterSection> {
  static bool _showLyric = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AnimatedCrossFade(
            crossFadeState: _showLyric
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
            layoutBuilder: (Widget topChild, Key topChildKey,
                Widget bottomChild, Key bottomChildKey) {
              return Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Center(
                    key: bottomChildKey,
                    child: bottomChild,
                  ),
                  Center(
                    key: topChildKey,
                    child: topChild,
                  ),
                ],
              );
            },
            firstChild: GestureDetector(
              onTap: () {
                setState(() {
                  _showLyric = !_showLyric;
                });
              },
              child: PlayAlbumCover(music: widget.music),
            ),
            secondChild: PlayingLyricView(
              onTap: () {
                setState(() {
                  _showLyric = !_showLyric;
                });
              },
            )));
  }
}

class PlayerControllerBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconPlayPause = PlayingIndicator(
        playing: IconButton(
            iconSize: Dimens.gap_dp80,
            onPressed: () {
              context.transportControls.pause();
            },
            icon: Image.asset(ImageUtils.getImagePath('btn_pause'))),
        pausing: IconButton(
            iconSize: Dimens.gap_dp80,
            onPressed: () {
              context.transportControls.play();
            },
            icon: Image.asset(ImageUtils.getImagePath('btn_play'))));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          iconSize: Dimens.gap_dp40,
          onPressed: () {
            context.transportControls
                .setPlayMode(context.playerValueRx.value!.playMode.next);
          },
          icon: Obx(
            () => Image.asset(
              context.playModelRx.value.iconPath,
              color: Colours.color_217,
              width: Dimens.gap_dp25,
            ),
          ),
        ),
        IconButton(
            iconSize: Dimens.gap_dp40,
            onPressed: () {
              context.transportControls.skipToPrevious();
            },
            icon: Image.asset(
              ImageUtils.getImagePath('play_btn_prev'),
              color: Colours.color_217,
            )),
        iconPlayPause,
        IconButton(
            iconSize: Dimens.gap_dp40,
            onPressed: () {
              context.transportControls.skipToNext();
            },
            icon: Image.asset(
              ImageUtils.getImagePath('play_btn_next'),
              color: Colours.color_217,
            )),
        IconButton(
            onPressed: () {
              PlayingListDialog.show(context);
            },
            icon: Image.asset(
              ImageUtils.getImagePath('play_btn_src'),
              color: Colours.color_217,
              width: Dimens.gap_dp28,
            ))
      ],
    );
  }
}
