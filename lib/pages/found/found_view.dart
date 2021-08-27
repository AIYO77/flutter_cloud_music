import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/banner_model.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_ball.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_banner.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_music_calendar.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_new_song_album.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_shuffle_mlog.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_playable_dragon_ball.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_single_song.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_songlist_align.dart';
import 'package:flutter_cloud_music/pages/found/widget/found_slide_voicelist.dart';
import 'package:flutter_cloud_music/services/home_top_service.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:keframe/frame_separate_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'found_controller.dart';
import 'model/found_model.dart';
import 'widget/found_slied_playlist.dart';

class FoundPage extends GetView<FoundController> {
  FoundPage({Key? key}) : super(key: key);

  final refreshController = RefreshController();

  Widget _buildItem(Blocks blocks, int index) {
    final itemHeight = controller.itemHeightFromType[blocks.showType] ?? 0;
    Get.log('${blocks.showType} itemheight $itemHeight');
    switch (blocks.showType) {
      case SHOWTYPE_BANNER:
        return FoundBanner(
          BannerModel.fromJson(blocks.extInfo),
          itemHeight: itemHeight,
        );
      case SHOWTYPE_BALL:
        return FoundBall(
          blocks.extInfo,
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
        return FoundShuffleMLOG(blocks: blocks, itemHeight: itemHeight);
      case SHOWTYPE_SLIDE_VOICELIST:
        return FoundSlideVoiceList(blocks, itemHeight: itemHeight);
      case SHOWTYPE_SLIDE_PLAYABLE_DRAGON_BALL:
        return FoundSlideGragonBall(blocks, itemHeight: itemHeight);
      default:
        return Gaps.empty;
    }
  }

  Widget _buildDivider(String type) {
    switch (type) {
      case SHOWTYPE_BANNER:
      case SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM:
        return Gaps.empty;
      case SHOWTYPE_BALL:
        return Gaps.line;
      default:
        return Gaps.vGap10;
    }
  }

  Widget _buildListView(FoundData? state) {
    Get.log("_buildListView $state");
    if (state != null) {
      controller.expirationTime = DateTime.now().millisecondsSinceEpoch +
          state.pageConfig.refreshInterval;
    }
    final listScroll = ScrollController();
    listScroll.addListener(() {
      HomeTopService.to.isScrolled.value = listScroll.position.pixels >= 15.0;
    });
    return SmartRefresher(
        controller: refreshController,
        onRefresh: _onRefresh,
        child: ListView.separated(
            controller: listScroll,
            itemBuilder: (context, index) {
              final blocks = state!.blocks[index];
              return FrameSeparateWidget(
                  index: index,
                  placeHolder: Container(
                    color: Get.theme.cardColor,
                    height: controller.itemHeightFromType[blocks.showType] ?? 0,
                  ),
                  child: _buildItem(blocks, index));
            },
            separatorBuilder: (context, index) {
              return _buildDivider(state!.blocks[index].showType);
            },
            itemCount: state != null ? state.blocks.length : 0));
  }

  Future<void> _onRefresh() async {
    controller.getFoundRecList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) {
          Get.log("refresh finish");
          refreshController.refreshCompleted();
          return _buildListView(state);
        },
        onEmpty: const Text("empty"),
        onError: (err) {
          Get.log('refresh error $err');
          Fluttertoast.showToast(msg: err.toString());
          refreshController.refreshFailed();
          return Gaps.empty;
        },
        onLoading: _buildLoading(),
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
