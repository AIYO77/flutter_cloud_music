import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/song_cell.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class PlayListContent extends StatelessWidget {
  PlayListContent(this.songs);

  List<Song>? songs;

  final controller = Get.find<PlaylistDetailController>();

  @override
  Widget build(BuildContext context) {
    if (songs == null) {
      return SliverToBoxAdapter(
        child: Container(
            margin: EdgeInsets.only(top: Dimens.gap_dp95),
            child: MusicLoading(
              axis: Axis.horizontal,
            )),
      );
    } else {
      final subs = controller.detail.value?.playlist.subscribers;
      return (songs!.isEmpty &&
              controller.detail.value!.playlist.creator.userId ==
                  AuthService.to.userId)
          ? _buildAddSong()
          : SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (songs!.length > index) {
                  return NumSongCell(
                    song: songs!.elementAt(index),
                    index: index,
                    clickCallback: () {
                      final clickSong = songs!.elementAt(index);
                      if (clickSong.canPlay()) {
                        context.player.playWithQueue(
                            PlayQueue(
                                queueId: controller.detail.value!.playlist.id
                                    .toString(),
                                // queueId: kFmPlayQueueId,
                                queueTitle:
                                    controller.detail.value!.playlist.name,
                                queue: songs!.toMetadataList()),
                            metadata: clickSong.metadata);
                      } else {
                        toast('该歌曲暂无法播放');
                      }
                    },
                  );
                } else {
                  return Container(
                    height: Dimens.gap_dp58,
                    color: Get.theme.cardColor,
                    child: Row(
                      children: [
                        Gaps.hGap10,
                        Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final user = subs!.elementAt(index);
                                return buildUserAvatar(user.avatarUrl,
                                    Size(Dimens.gap_dp30, Dimens.gap_dp30));
                              },
                              separatorBuilder: (context, index) {
                                return Gaps.hGap10;
                              },
                              itemCount: subs?.length ?? 0),
                        ),
                        Text(
                          '${getPlayCountStrFromInt(controller.detail.value?.playlist.subscribedCount ?? 0)}人收藏',
                          style: TextStyle(
                              color: Colours.color_177,
                              fontSize: Dimens.font_sp13),
                        ),
                        Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          height: Dimens.gap_dp20,
                          color: Colours.color_195,
                        ),
                        Gaps.hGap10,
                      ],
                    ),
                  );
                }
              },
                  childCount: songs!.length +
                      (GetUtils.isNullOrBlank(subs) == true ? 0 : 1)),
            );
    }
  }

  Widget _buildAddSong() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: Dimens.gap_dp50),
        child: CupertinoButton(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp70),
              alignment: Alignment.center,
              height: Dimens.gap_dp40,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp20)),
                  border: Border.all(color: Colours.app_main_light)),
              child: Text(
                '添加歌曲',
                style: TextStyle(
                    color: Colours.app_main_light,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimens.font_sp16),
              ),
            ),
            onPressed: () {
              Get.toNamed(Routes.ADD_SONG, arguments: controller.playlistId);
            }),
      ),
    );
  }
}
