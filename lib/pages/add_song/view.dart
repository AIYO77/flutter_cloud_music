import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';

import '../../common/values/constants.dart';
import 'logic.dart';

class AddSongPage extends GetView<AddSongLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        title: Text('添加音乐到歌单'),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: context.theme.appBarTheme.toolbarHeight ?? 44,
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
              alignment: Alignment.center,
              child: Text(
                '完成',
                style: body2Style(),
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          Obx(() => GetUtils.isNullOrBlank(controller.items.value) == true
              ? _buildLoading()
              : _buildList(controller.items.value!))
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Dimens.gap_dp15, Dimens.gap_dp10, Dimens.gap_dp15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SINGLE_SEARCH);
              },
              child: Hero(
                tag: SINGLE_SEARCH,
                child: Container(
                  height: Dimens.gap_dp38,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        context.isDarkMode ? Colors.white12 : Colours.color_245,
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimens.gap_dp18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colours.color_156,
                        size: Dimens.gap_dp20,
                      ),
                      Gaps.hGap3,
                      Text('搜索歌曲',
                          style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.text_gray))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: Dimens.gap_dp17, bottom: Dimens.gap_dp8),
              child: Text(
                '最近播放',
                style: body1Style(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: Dimens.gap_dp50),
        child: MusicLoading(),
      ),
    );
  }

  Widget _buildList(List<Song> list) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      final song = list.elementAt(index);
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.addMusicToPl(song);
          },
          child: SizedBox(
            height: Dimens.gap_dp58,
            width: double.infinity,
            child: Row(
              children: [
                Gaps.hGap15,
                ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp4)),
                  child: CachedNetworkImage(
                    imageUrl: ImageUtils.getImageUrlFromSize(song.al.picUrl,
                        Size(Dimens.gap_dp105, Dimens.gap_dp105)),
                    height: Dimens.gap_dp48,
                    width: Dimens.gap_dp48,
                    placeholder: placeholderWidget,
                    errorWidget: errorWidget,
                  ),
                ),
                Gaps.hGap9,
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.name,
                      style: body2Style(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap4,
                    Text(
                      '${song.arString()} - ${song.al.name}',
                      style: captionStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                )),
                Obx(() => (PlayerService.to.curPlayId.value == song.id)
                    ? Image.asset(
                        ImageUtils.getPlayingMusicTag(),
                        color: Colours.btn_selectd_color,
                        width: Dimens.gap_dp13,
                      )
                    : Gaps.empty),
                Gaps.hGap15
              ],
            ),
          ),
        ),
      );
    }, childCount: list.length));
  }
}
