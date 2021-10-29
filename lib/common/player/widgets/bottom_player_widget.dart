import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/bottom_player_controller.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/player_circular_progress.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/player/widgets/rotation_cover_image.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';
import 'package:music_player/src/player/music_metadata.dart';

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
    return InkWell(
      onTap: () {
        // context.playerService.watchPlayerValue.value?.queue.isPlayingFm
        // Get.toNamed(page)
      },
      child: MediaQuery(
        data: context.mediaQuery.copyWith(
          viewInsets: context.mediaQueryViewInsets.copyWith(bottom: 0),
        ),
        child: Obx(() => BottomContentWidget(
              isFmPlaying: controller.isFmPlaying.value,
              bottomPadding: bottomPadding,
            )),
      ),
    );
  }
}

class BottomContentWidget extends StatelessWidget {
  BottomContentWidget({required this.isFmPlaying, required this.bottomPadding});

  final bool isFmPlaying;
  final double bottomPadding;
  final controller = Get.find<PlayerContoller>();
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    final curPlayId = PlayerService.to.curPlayId.value;
    logger.d('curPlayId = $curPlayId');
    if (curPlayId == null || curPlayId < 0) {
      return Gaps.empty;
    }
    final queue = PlayerService.to.watchPlayerValue.value?.queue;
    final backgroundColor = Get.theme.cardColor.withOpacity(0.97);

    final initPage = controller.getCurPage(queue?.queue, curPlayId.toString());
    logger.d('queue.size = ${queue?.queue.length}  initPage = $initPage');
    controller.pageController = PageController(initialPage: initPage);

    ///Fm : 48  other: 58
    return SizedBox(
      height: isFmPlaying
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
                                color: Get.theme.dividerColor.withOpacity(0.5),
                                width: Dimens.gap_dp1))),
                    margin:
                        EdgeInsets.only(top: isFmPlaying ? 0 : Dimens.gap_dp4),
                  ),
                ),
                Positioned.fill(
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
          ),
          Container(
            height: bottomPadding,
            width: Adapt.screenW(),
            color: backgroundColor,
          )
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
        Obx(() => RotationCoverImage(
            rotating: controller.isPlaying.value, music: music)),
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
              margin: EdgeInsets.only(top: isFmPlaying ? 0 : Dimens.gap_dp18),
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
