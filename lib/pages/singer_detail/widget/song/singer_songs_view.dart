import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/song_cell.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/song/singer_songs_controller.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:flutter_cloud_music/widgets/playall_cell.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/12 5:50 下午
/// Des: 歌手歌曲列表

class SingerSongsView extends StatelessWidget {
  final int id;

  SingerSongsView({required this.id});

  late SingerSongsController controller;

  @override
  Widget build(BuildContext context) {
    controller = GetInstance().putOrFind(() => SingerSongsController(id));
    return Obx(() => (controller.songs.value == null)
        ? _loading()
        : _buildList(context, controller.songs.value!));
  }

  Widget _buildList(BuildContext context, List<Song> list) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: PlayAllCell(
            playCount: list.length,
            title: (controller.order.value == 'hot') ? '播放热门' : '播放最新歌曲',
            actions: [
              IconButton(
                onPressed: () {
                  Get.bottomSheet(_buildOrderMethod());
                },
                icon: Image.asset(
                  ImageUtils.getImagePath('icn_order_change'),
                  color: headlineStyle().color,
                  width: Dimens.gap_dp20,
                ),
              )
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return NumSongCell(
              song: list.elementAt(index),
              index: index,
              clickCallback: () {
                final clickSong = list.elementAt(index);
                if (clickSong.canPlay()) {
                  context.player.playWithQueue(
                      PlayQueue(
                          queueId: controller.id.toString(),
                          queueTitle: '',
                          queue: list.map((e) => e.metadata).toList()),
                      metadata: clickSong.metadata);
                } else {
                  toast('该歌曲暂无法播放');
                }
              },
            );
          }, childCount: list.length),
        ),
        //更多歌曲
        if (list.length >= 50)
          SliverToBoxAdapter(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  toast('全部演唱');
                },
                child: Container(
                  height: Dimens.gap_dp50,
                  width: Adapt.screenW(),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: '全部演唱',
                          style: captionStyle()
                              .copyWith(fontSize: Dimens.font_sp14)),
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageUtils.getImagePath('icon_more'),
                            color: captionStyle().color,
                            width: Dimens.gap_dp12,
                          ))
                    ]),
                  ),
                ),
              ),
            ),
          ),
        Obx(() => SliverToBoxAdapter(
              child: padingBottomBox(context.playerValueRx.value),
            ))
      ],
    );
  }

  Widget _loading() {
    return Container(
      margin: EdgeInsets.only(top: Dimens.gap_dp50),
      child: MusicLoading(),
    );
  }

  Widget _buildOrderMethod() {
    return Container(
      height: Dimens.gap_dp150 + Adapt.bottomPadding(),
      width: Adapt.screenW(),
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.gap_dp16),
              topRight: Radius.circular(Dimens.gap_dp16))),
      child: ClipRect(
        child: Column(
          children: [
            Container(
              height: Dimens.gap_dp49,
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.gap_dp16),
                      topRight: Radius.circular(Dimens.gap_dp16))),
              alignment: Alignment.centerLeft,
              child: Text(
                '选择排序方式',
                style: captionStyle().copyWith(fontSize: Dimens.font_sp14),
              ),
            ),
            Gaps.line,
            _buildOrderCell('hot'),
            _buildOrderCell('time'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCell(String order) {
    final isHot = order == 'hot';
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
          controller.order.value = order;
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          height: Dimens.gap_dp50,
          child: Row(
            children: [
              Image.asset(
                ImageUtils.getImagePath(isHot ? 'icn_hot' : 'icn_time'),
                color: body1Style().color,
                width: Dimens.gap_dp26,
              ),
              Gaps.hGap5,
              Text(
                isHot ? '按照热度排序' : '按照时间排序',
                style: body1Style().copyWith(fontSize: Dimens.font_sp14),
              ),
              const Expanded(child: Gaps.empty),
              if (controller.order.value == order)
                Image.asset(
                  ImageUtils.getImagePath('icn_check'),
                  width: Dimens.gap_dp25,
                )
            ],
          ),
        ),
      ),
    );
  }
}
