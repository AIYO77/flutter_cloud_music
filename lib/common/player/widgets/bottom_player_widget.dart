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
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
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
            bottomPadding: Adapt.bottomPadding(),
          ),
        )
      ],
    );
  }
}

class BottomPlayerBar extends StatelessWidget {
  BottomPlayerBar({Key? key, this.bottomPadding = 0}) : super(key: key);

  final double bottomPadding;

  final controller = Get.put<PlayerContoller>(PlayerContoller());

  @override
  Widget build(BuildContext context) {
    logger.d('BottomPlayerBar');
    return InkWell(
      onTap: () {
        // context.playerService.watchPlayerValue.value?.queue.isPlayingFm
        Get.toNamed(Routes.PLAYING);
      },
      child: MediaQuery(
        data: context.mediaQuery.copyWith(
          viewInsets: context.mediaQueryViewInsets.copyWith(bottom: 0),
        ),
        child: Obx(
          () => BottomContentWidget(
            isFmPlaying: context.playerService.isFmPlaying.value,
            bottomPadding: bottomPadding,
            curPlayId: context.playerService.curPlayId.value,
          ),
        ),
      ),
    );
  }
}

class BottomContentWidget extends StatelessWidget {
  BottomContentWidget({
    Key? key,
    required this.isFmPlaying,
    required this.bottomPadding,
    this.curPlayId,
  }) : super(key: key);
  final bool isFmPlaying;
  final double bottomPadding;
  final int? curPlayId;
  final controller = Get.find<PlayerContoller>();
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    if (curPlayId == null || (curPlayId ?? -1) < 0) {
      return Gaps.empty;
    }
    final queue = PlayerService.to.watchPlayerValue.value?.queue;
    final backgroundColor = Get.theme.cardColor;

    final initPage = controller.getCurPage(queue?.queue, curPlayId.toString());
    logger.d('queue.size = ${queue?.queue.length}  initPage = $initPage');
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
                      itemCount: queue?.queue.length ?? 0,
                      controller: controller.pageController,
                      physics: isFmPlaying
                          ? const NeverScrollableScrollPhysics()
                          : const BouncingScrollPhysics(),
                      onPageChanged: (page) async {
                        controller.playFromIndex(context, page);
                      },
                      itemBuilder: (context, index) {
                        final muisc = queue!.queue.elementAt(index);
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
                          Get.bottomSheet(Container(
                            height: 200,
                            color: Colors.white,
                          ));
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
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.gap_dp7),
          child: CachedNetworkImage(
            imageUrl: music.iconUri ?? '',
            width: Dimens.gap_dp36,
            height: Dimens.gap_dp36,
            placeholder: (context, url) =>
                Image.asset(ImageUtils.getImagePath('ecf')),
            errorWidget: (context, url, e) =>
                Image.asset(ImageUtils.getImagePath('ecf')),
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
              child: Obx(() => RotationCoverImage(
                    rotating: controller.isPlaying.value,
                    music: music.toMusic(),
                    pading: Dimens.gap_dp9,
                  ))),
        ),
        Gaps.hGap10,
        Expanded(child: _buildTitle(music))
      ],
    );
  }

  Widget _buildTitle(MusicMetadata music) {
    final titleStyle = captionStyle();
    return RichText(
      maxLines: 1,
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
            WidgetSpan(
                child: Container(
              margin: EdgeInsets.only(top: isFmPlaying ? 0 : Dimens.gap_dp20),
              child: Text(
                music.subtitle!,
                style: titleStyle.copyWith(
                    fontSize: Dimens.font_sp12,
                    color: titleStyle.color?.withOpacity(0.6)),
              ),
            ))
          ]),
    );
  }
}
