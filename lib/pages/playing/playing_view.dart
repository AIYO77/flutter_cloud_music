import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/lyric/playing_lyric_view.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
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
          Obx(() =>
              BlurBackground(music: context.playerValueRx.value?.metadata)),
          Material(
            color: Colors.transparent,
            child: Column(
              children: [
                //标题bar
                Obx(() =>
                    PlayingTitle(song: context.playerValueRx.value?.current)),
                //唱片动画
                _CenterSection(music: context.playerValueRx.value?.current),
                //点赞等操作
                _PlayingOperationBar()
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
    final iconColor = Colors.white.withOpacity(0.9);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Obx(() => LikeButton(song: context.playerValueRx.value?.current)),
        IconButton(
            icon: Image.asset(
              ImageUtils.getImagePath('icn_download'),
              color: iconColor,
            ),
            onPressed: () {
              notImplemented(context);
            }),
        Obx(() => CommentButton(
              song: context.playerValueRx.value?.current,
            )),
        IconButton(
            icon: Icon(
              Icons.share,
              color: iconColor,
            ),
            onPressed: () {
              notImplemented(context);
            }),
      ],
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
