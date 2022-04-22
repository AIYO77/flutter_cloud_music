import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/album_detail/album_detail_controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/song_cell.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:music_player/music_player.dart';

class AlbumDetailSongList extends StatelessWidget {
  AlbumDetailSongList(this.songs, {required this.controller});

  List<Song>? songs;

  final AlbumDetailController controller;

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
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return NumSongCell(
            song: songs!.elementAt(index),
            index: index,
            clickCallback: () {
              final clickSong = songs!.elementAt(index);
              if (clickSong.canPlay()) {
                context.player.playWithQueue(
                    PlayQueue(
                        queueId:
                            controller.albumDetail.value!.album.id.toString(),
                        // queueId: kFmPlayQueueId,
                        queueTitle: controller.albumDetail.value!.album.name,
                        queue: songs!.map((e) => e.metadata).toList()),
                    metadata: clickSong.metadata);
              } else {
                toast('该歌曲暂无法播放');
              }
            },
          );
        }, childCount: songs!.length),
      );
    }
  }
}
