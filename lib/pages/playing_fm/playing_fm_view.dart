import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/singer_detail/selector.dart';
import 'package:flutter_cloud_music/widgets/blur_background.dart';
import 'package:get/get.dart';

import '../../common/player/widgets/lyric/playing_lyric_view.dart';
import '../../common/player/widgets/player_common_widget.dart';
import '../../common/player/widgets/player_pregress.dart';
import '../../common/res/colors.dart';
import '../../common/transition/downToUp_with_fade.dart';
import '../../common/utils/image_utils.dart';
import '../../common/values/constants.dart';
import '../../widgets/comment_button.dart';
import '../../widgets/like_button.dart';
import 'playing_fm_controller.dart';

class PlayingFmPage extends GetView<PlayingFmController> {
  const PlayingFmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(() => BlurBackground(
                musicCoverUrl: context.curPlayRx.value?.al.picUrl,
              )),
          Material(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                _buildAppbar(),
                _CenterSection(),
                Gaps.vGap8,
                DurationProgressBar(),
                _FmControllerBar(controller),
                SizedBox(height: Adapt.bottomPadding()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      title: Text(
        "私人FM",
        style:
            Get.theme.appBarTheme.titleTextStyle?.copyWith(color: Colors.white),
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: Dimens.gap_dp46,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.only(left: Dimens.gap_dp22),
          child: Image.asset(
            ImageUtils.getImagePath('list_icn_arr_open'),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _CenterSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CenterSectionState();
}

class _CenterSectionState extends State<_CenterSection> {
  static bool _showLyric = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedCrossFade(
        crossFadeState:
            _showLyric ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild,
            Key bottomChildKey) {
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
        duration: const Duration(milliseconds: 300),
        firstChild: GestureDetector(
          onTap: () {
            setState(() {
              _showLyric = !_showLyric;
            });
          },
          child: Obx(() => _FmCover(context.curPlayRx.value)),
        ),
        secondChild: PlayingLyricView(
          onTap: () {
            setState(() {
              _showLyric = !_showLyric;
            });
          },
        ),
      ),
    );
  }
}

class _FmCover extends StatelessWidget {
  final Song? music;

  const _FmCover(this.music);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimens.gap_dp32, vertical: Dimens.gap_dp18),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.gap_dp8),
              child: Hero(
                tag: HERO_TAG_CUR_PLAY,
                createRectTween: createRectTween,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: CachedNetworkImage(
                    imageUrl: music?.al.picUrl ?? '',
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset('default_cover_play');
                    },
                    errorWidget: (context, url, e) {
                      return Image.asset('default_cover_play');
                    },
                  ),
                ),
              )),
        ),
        Text(
          music?.name ?? '',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: Dimens.font_sp17,
              fontWeight: FontWeight.w500),
        ),
        Gaps.vGap16,
        InkWell(
          onTap: () {
            launchArtistDetailPage(context, music?.ar);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                constraints: const BoxConstraints(maxWidth: 200),
                child: Text(
                  music?.arString() ?? '',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: Dimens.font_sp13,
                      fontWeight: FontWeight.normal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Image.asset(
                ImageUtils.getImagePath('icon_more'),
                height: Dimens.gap_dp17,
                color: Colors.white.withOpacity(0.8),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _FmControllerBar extends StatelessWidget {
  final PlayingFmController controller;

  const _FmControllerBar(this.controller);

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

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              icon: Image.asset(
                ImageUtils.getImagePath('playlist_icn_delete'),
                color: Colours.color_217,
              ),
              onPressed: () {
                controller.trashMusic(context);
              }),
          FavoriteButton(),
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
          Obx(() => CommentButton(
                songId: context.curPlayRx.value?.id.toString() ?? '',
              )),
        ],
      ),
    );
  }
}
