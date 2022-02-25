import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/bottom_player_controller.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/player/widgets/player_circular_progress.dart';
import 'package:flutter_cloud_music/common/player/widgets/rotation_cover_image.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/playing_list/page_playing_list.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

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
          child: BottomPlayerBar(
            // key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            bottomPadding: Adapt.bottomPadding(),
          ),
        )
      ],
    );
  }
}

class BottomPlayerBar extends StatefulWidget {
  const BottomPlayerBar({Key? key, this.bottomPadding = 0}) : super(key: key);

  final double bottomPadding;

  @override
  _BottomPlayerBarState createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        toPlaying();
      },
      child: MediaQuery(
        data: context.mediaQuery.copyWith(
          viewInsets: context.mediaQueryViewInsets.copyWith(bottom: 0),
        ),
        child: Obx(
          () => _BottomContentWidget(
            key: Key(context.playerService.queueIdValue.value),
            listSize: context.playerService.queueSizeValue.value,
            bottomPadding: widget.bottomPadding,
            curPlayId: context.playerService.curPlayId.value,
          ),
        ),
      ),
    );
  }
}

class _BottomContentWidget extends GetView<PlayerContoller> {
  _BottomContentWidget({
    Key? key,
    required this.listSize,
    required this.bottomPadding,
    this.curPlayId,
  }) : super(key: key);

  final bool isFmPlaying = PlayerService.to.isFmPlaying.value;
  final double bottomPadding;
  final int? curPlayId;

  final int listSize;

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerContoller());
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (curPlayId == null || (curPlayId ?? -1) < 0) {
      return Gaps.empty;
    }
    final backgroundColor = Get.theme.cardColor;
    final queue = context.player.queue;
    final initPage = controller.getCurPage(queue.queue, curPlayId.toString());
    controller.pageController = PageController(initialPage: initPage);

    return SizedBox(
      height: Dimens.gap_dp58 + bottomPadding,
      width: Adapt.screenW(),
      child: Stack(
        children: [
          Positioned.fill(
              child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Get.theme.dividerColor, width: Dimens.gap_dp1))),
            margin: EdgeInsets.only(
              top: isFmPlaying ? 0 : Dimens.gap_dp5,
            ),
          )),
          //背景
          Positioned(
              top: isFmPlaying ? 0 : Dimens.gap_dp5 + Dimens.gap_dp1,
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: backgroundColor.withOpacity(0.8),
                  ),
                ),
              )),
          //内容
          Positioned.fill(
              bottom: bottomPadding,
              child: Row(
                crossAxisAlignment: isFmPlaying
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PageView.builder(
                      key: UniqueKey(),
                      itemCount: listSize,
                      controller: controller.pageController,
                      physics: isFmPlaying
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      onPageChanged: (page) async {
                        controller.playFromIndex(context, page);
                      },
                      itemBuilder: (context, index) {
                        final muisc = queue.queue.elementAt(index);
                        return isFmPlaying
                            ? _buildFmWidget(muisc)
                            : _buildNormWidget(muisc);
                      },
                    ),
                  ),
                  CircularContollerbar(),
                  Gaps.hGap12,
                  Container(
                    margin: EdgeInsets.only(
                        top: isFmPlaying ? 0.0 : Dimens.gap_dp7),
                    child: InkWell(
                        onTap: () {
                          PlayingListDialog.show(context);
                        },
                        child: Image.asset(
                          ImageUtils.getImagePath('epj'),
                          width: Dimens.gap_dp40,
                          height: Dimens.gap_dp40,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        )),
                  ),
                  Gaps.hGap8
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildFmWidget(MusicMetadata music) {
    return Row(
      children: [
        Gaps.hGap16,
        Hero(
          tag: HERO_TAG_CUR_PLAY,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.gap_dp7),
            child: CachedNetworkImage(
              imageUrl: music.iconUri ?? '',
              width: Dimens.gap_dp36,
              height: Dimens.gap_dp36,
              placeholder: (context, url) =>
                  Image.asset(ImageUtils.getImagePath('default_cover_play')),
              errorWidget: (context, url, e) =>
                  Image.asset(ImageUtils.getImagePath('default_cover_play')),
            ),
          ),
        ),
        Gaps.hGap10,
        Expanded(child: _buildTitle(music))
      ],
    );
  }

  Widget _buildNormWidget(MusicMetadata music) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.hGap16,
        SizedBox.fromSize(
          size: Size(Dimens.gap_dp44, Dimens.gap_dp44),
          child: Hero(
              tag: HERO_TAG_CUR_PLAY,
              child: RotationCoverImage(
                rotating: controller.isPlaying.value,
                music: music.toMusic(),
                pading: Dimens.gap_dp9,
              )),
        ),
        Gaps.hGap10,
        Expanded(child: _buildTitle(music))
      ],
    );
  }

  Widget _buildTitle(MusicMetadata music) {
    final titleStyle = body1Style();
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: music.title,
            style: titleStyle.copyWith(fontSize: Dimens.font_sp14),
            children: [
              WidgetSpan(child: Gaps.hGap4),
              TextSpan(
                  text: '-',
                  style: titleStyle.copyWith(
                      fontSize: Dimens.font_sp12,
                      color: titleStyle.color?.withOpacity(0.6))),
              WidgetSpan(child: Gaps.hGap4),
              TextSpan(
                text: music.subtitle,
                style: titleStyle.copyWith(
                    fontSize: Dimens.font_sp12,
                    color: titleStyle.color?.withOpacity(0.6)),
              )
              // WidgetSpan(
              //     child: Container(
              //   // margin: EdgeInsets.only(top: isFmPlaying ? 0 : Dimens.gap_dp20),
              //   child: ,
              // ))
            ]),
      ),
    );
  }
}
