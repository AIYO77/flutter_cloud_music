import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/album/singer_albums_view.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/home/singer_home_view.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/song/singer_songs_view.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/video/singer_video_view.dart';
import 'package:flutter_cloud_music/widgets/follow/follow_widget.dart';
import 'package:flutter_cloud_music/widgets/keep_alive_wrapper.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';

import 'state.dart';

class SingerDetailLogic extends GetxController
    with GetTickerProviderStateMixin {
  final state = SingerDetailState();

  @override
  void onInit() {
    super.onInit();
    state.accountId = Get.arguments['accountId']?.toString();
    state.artistId = Get.arguments['artistId']?.toString();
    state.detail.listen((detail) {
      if (detail?.isSinger == true) {
        //是歌手
        //初始化动画
        _initAnimation();
        // 获取相似歌手推荐
        _getSimiArtist();
      }
      if (state.tabController == null && detail != null) {
        initTabs(detail);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    _getDetail();
  }

  void _getDetail() {
    if (GetUtils.isNullOrBlank(state.accountId) == true) {
      //获取歌手详情
      MusicApi.getSingerInfo(state.artistId!).then((value) {
        state.detail.value = value?.detail;
      });
    } else {
      //获取用户详情（也包含歌手）
      MusicApi.getUserDetail(state.accountId!).then((value) {
        state.detail.value = value?.detail;
      });
    }
  }

  void _getSimiArtist() {
    MusicApi.getSimiArtist(state.getArtistId().toString()).then((value) {
      state.simiItems.value = value;
    });
  }

  @override
  void onClose() {
    state.animController?.dispose();
    state.scrollController.dispose();
    state.tabController?.dispose();
    super.onClose();
  }

  void _initAnimation() {
    if (state.animation == null) {
      state.animController = AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300));
      state.animation =
          Tween(begin: 0.0, end: 1.0).animate(state.animController!)
            ..addListener(() {
              state.animValue.value = state.animation!.value;
            });
    }
  }

  void initTabs(SingerOrUserDetail detail) {
    state.tabs ??= List.empty(growable: true);
    state.tabs!
        .add(const SingerTabModel(type: SingerTabType.homePage, title: '主页'));

    if (state.isSinger()) {
      state.tabs!
          .add(const SingerTabModel(type: SingerTabType.songPage, title: '歌曲'));
      state.tabs!.add(SingerTabModel(
          type: SingerTabType.albumPage,
          title: '专辑',
          num: state.getAlbumSize() ?? 0));
    }
    if (GetUtils.isNullOrBlank(state.accountId) == false) {
      state.tabs!.add(SingerTabModel(
          type: SingerTabType.evenPage,
          title: '动态',
          num: detail.userDetail!.profile.eventCount));
    }
    if (state.isSinger()) {
      state.tabs!.add(SingerTabModel(
          type: SingerTabType.mvPage,
          title: '视频',
          num: state.getMVSize() ?? 0));
    }

    state.tabController =
        TabController(length: state.tabs!.length, vsync: this);
  }

  List<Widget> getTabBarViews() {
    final widgets = List<Widget>.empty(growable: true);
    for (final element in state.tabs!) {
      switch (element.type) {
        case SingerTabType.homePage:
          widgets.add(KeepAliveWrapper(
            child: SingerHomeView(state, this),
          ));
          break;
        case SingerTabType.songPage:
          widgets.add(KeepAliveWrapper(
            child: SingerSongsView(id: state.getArtistId()!),
          ));
          break;
        case SingerTabType.albumPage:
          widgets.add(KeepAliveWrapper(
            child: SingerAlbumsView(state.getArtistId()!),
          ));
          break;
        case SingerTabType.evenPage:
          widgets.add(KeepAliveWrapper(
            child: Container(),
          ));
          break;
        case SingerTabType.mvPage:
          widgets.add(KeepAliveWrapper(
            child: SingerVideoView(state.getArtistId()!),
          ));
          break;
      }
    }
    return widgets;
  }

  ///相似歌手推荐listview
  Widget simiListView(List<Ar>? items) {
    if (GetUtils.isNullOrBlank(items) == true) {
      return Center(
        child: MusicLoading(),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = items!.elementAt(index);
        return GestureDetector(
          onTap: () {
            toUserDetail(artistId: item.id, accountId: item.accountId);
          },
          child: Container(
            height: Adapt.px(137),
            width: Dimens.gap_dp95,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? const Color(0xff292929) : Colours.color_248,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.gap_dp10),
              ),
            ),
            child: Column(
              children: [
                Gaps.vGap10,
                //头像
                ClipOval(
                  child: CachedNetworkImage(
                    width: Dimens.gap_dp45,
                    height: Dimens.gap_dp45,
                    fit: BoxFit.cover,
                    imageUrl: ImageUtils.getImageUrlFromSize(
                        item.picUrl, Size(Dimens.gap_dp50, Dimens.gap_dp50)),
                    placeholder: (context, url) {
                      return Container(
                        color: Colours.load_image_placeholder(),
                      );
                    },
                  ),
                ),
                Gaps.vGap7,
                //name
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp10, right: Dimens.gap_dp10),
                  child: Text(
                    item.getNameStr() ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        headline1Style().copyWith(fontSize: Dimens.font_sp12),
                  ),
                ),
                Gaps.vGap3,
                //fansCount
                Text(
                  '${getFansCountStr(item.fansCount)}粉丝',
                  style: captionStyle().copyWith(fontSize: Dimens.font_sp11),
                ),
                Gaps.vGap8,
                //follow btn
                SizedBox(
                  width: Dimens.gap_dp60,
                  height: Dimens.gap_dp26,
                  child: FollowWidget(Key(item.accountId.toString()),
                      id: item.id.toString(),
                      isFollowed: item.followed ?? false),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.hGap10;
      },
      itemCount: items?.length ?? 0,
    );
  }
}
