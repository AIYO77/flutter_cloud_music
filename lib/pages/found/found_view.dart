import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_music/common/model/banner_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/found/model/found_ball_model.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_appbar.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_ball.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_banner.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_header_bg.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_music_calendar.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_new_song_album.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_shuffle_mlog.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_playable_dragon_ball.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_single_song.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_songlist_align.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_voicelist.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_tab_mlog.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:keframe/frame_separate_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'found_controller.dart';
import 'model/found_model.dart';
import 'widget/found_slied_playlist.dart';

class FoundPage extends StatelessWidget {
  FoundPage({Key? key}) : super(key: key);

  final controller = GetInstance().putOrFind(() => FoundController());

  final refreshController = RefreshController();

  Widget _buildItem(Blocks blocks, int index, String? nextType) {
    final itemHeight = controller.itemHeightFromType[blocks.showType] ?? 0;
    switch (blocks.showType) {
      case SHOWTYPE_BANNER:
        return FoundBanner(
          Key(blocks.extInfo.hashCode.toString()),
          BannerModel.fromJson(blocks.extInfo),
          itemHeight: itemHeight,
        );
      case SHOWTYPE_BALL:
        return FoundBall(
          (blocks.extInfo as List).map((e) => Ball.fromJson(e)).toList(),
          itemHeight: itemHeight,
        );
      case SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST:
        return FoundSliedPlaylist(
          uiElementModel: blocks.uiElement!,
          creatives: blocks.creatives!,
          curIndex: index,
          itemHeight: itemHeight,
        );
      case SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM:
        return FoundNewSongAlbum(
          blocks.creatives!,
          itemHeight: itemHeight,
          bottomRadius: nextType != SHOWTYPE_SLIDE_SINGLE_SONG,
        );
      case SHOWTYPE_SLIDE_SINGLE_SONG:
        return FoundSlideSingleSong(
          blocks,
          itemHeight: itemHeight,
        );
      case SHOWTYPE_SHUFFLE_MUSIC_CALENDAR:
        return FoundMusicCalendar(
          blocks: blocks,
          itemHeight: itemHeight,
        );
      case SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN:
        return FoundSlideSongListAlign(
          blocks,
          itemHeight: itemHeight,
        );
      case SHOWTYPE_SHUFFLE_MLOG:
      case HOMEPAGE_SLIDE_PLAYABLE_MLOG:
        return FoundShuffleMLOG(blocks: blocks, itemHeight: itemHeight);
      case SHOWTYPE_SLIDE_VOICELIST:
      case SLIDE_RCMDLIKE_VOICELIST:
        return FoundSlideVoiceList(blocks, itemHeight: itemHeight);
      case SHOWTYPE_SLIDE_PLAYABLE_DRAGON_BALL:
        return FoundSlideGragonBall(blocks, itemHeight: itemHeight);
      case SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB:
        return FoundTabMlogWidget(
            creatives: blocks.creatives!, itemHeight: itemHeight);
      default:
        return Gaps.empty;
    }
  }

  Widget _buildDivider(String type, String? nextType) {
    switch (type) {
      case SHOWTYPE_BANNER:
        return Gaps.empty;
      case SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM:
        return nextType == SHOWTYPE_SLIDE_SINGLE_SONG
            ? Gaps.empty
            : Gaps.vGap10;
      case SHOWTYPE_BALL:
        return Gaps.line;
      default:
        return Gaps.vGap10;
    }
  }

  Widget _buildListView(BuildContext context, FoundData? state) {
    Get.log("_buildListView $state");
    if (state != null) {
      controller.expirationTime = DateTime.now().millisecondsSinceEpoch +
          state.pageConfig.refreshInterval;
    }
    final listScroll = ScrollController();
    listScroll.addListener(() {
      controller.isScrolled.value = listScroll.position.pixels >= 15.0;
    });
    return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: _onRefresh,
        footer: Obx(() => CustomFooter(
            height: (context.playerValueRx.value?.current == null)
                ? Dimens.gap_dp50 + Adapt.bottomPadding()
                : Dimens.gap_dp95 + Adapt.bottomPadding(),
            builder: (context, mode) {
              return Container();
            })),
        child: ListView.separated(
            controller: listScroll,
            itemBuilder: (context, index) {
              final blocks = state!.blocks[index];
              final nextType = index + 1 < state.blocks.length
                  ? state.blocks[index + 1].showType
                  : null;
              return FrameSeparateWidget(
                  index: index,
                  placeHolder: Container(
                    color: Get.theme.cardColor,
                    height: controller.itemHeightFromType[blocks.showType] ?? 0,
                  ),
                  child: _buildItem(blocks, index, nextType));
            },
            separatorBuilder: (context, index) {
              final nextType = index + 1 < state!.blocks.length
                  ? state.blocks[index + 1].showType
                  : null;
              return _buildDivider(state.blocks[index].showType, nextType);
            },
            itemCount: state != null ? state.blocks.length : 0));
  }

  Future<void> _onRefresh() async {
    controller.getFoundRecList(refresh: true);
    controller.getDefaultSearch();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Get.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: FoundAppbar(),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            //顶部跟随banner变动的背景
            Positioned(
              top: 0,
              child: FoundHeaderColors(),
            ),
            Positioned.fill(
              top: Dimens.gap_dp56 + context.mediaQueryPadding.top,
              child: controller.obx(
                (state) {
                  Get.log("refresh finish");
                  refreshController.refreshCompleted();
                  return _buildListView(context, state);
                },
                onEmpty: const Text("empty"),
                onError: (err) {
                  Get.log('refresh error $err');
                  toast(err.toString());
                  refreshController.refreshFailed();
                  return Gaps.empty;
                },
                onLoading: _buildLoading(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    if (controller.state == null) {
      return Container(
          margin: const EdgeInsets.only(top: 100), child: MusicLoading());
    } else {
      // refreshController.requestRefresh();
      return Gaps.empty;
    }
  }
}
