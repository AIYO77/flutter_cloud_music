import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/search_api.dart';
import 'package:flutter_cloud_music/common/model/album_detail.dart';
import 'package:flutter_cloud_music/common/model/artists_model.dart';
import 'package:flutter_cloud_music/common/model/search_videos.dart';
import 'package:flutter_cloud_music/common/model/simple_play_list_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_album.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_artist.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_playlist.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_song.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_user.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_video.dart';
import 'package:flutter_cloud_music/widgets/playall_cell.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/res/dimens.dart';
import '../../../../widgets/music_loading.dart';
import '../../../found/model/found_new_song.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/5/5 2:29 下午
/// Des: 搜索结果分页通用列表

class SearchResultCommonPage extends StatefulWidget {
  final String keywords;
  final int type;

  const SearchResultCommonPage(
      {Key? key, required this.keywords, required this.type})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<SearchResultCommonPage> {
  List<dynamic>? items;

  late ScrollController scrollController;
  late RefreshController refreshController;

  @override
  void initState() {
    scrollController = ScrollController();
    refreshController = RefreshController();
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      body: items == null
          ? Padding(
              padding: EdgeInsets.only(top: Dimens.gap_dp50),
              child: MusicLoading(),
            )
          : SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: () => _request(),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  if (widget.type == SEARCH_SONGS)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: GeneralSliverDelegate(
                        child: PlayAllCell(
                          playAllTap: () {
                            final musics = items!
                                .cast<Song>()
                                .map((e) => e.metadata)
                                .toList();
                            context.player.playWithQueue(PlayQueue(
                                queueId: widget.keywords.hashCode.toString(),
                                queueTitle: widget.keywords,
                                queue: musics));
                          },
                        ),
                      ),
                    ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Container(
                        color: context.theme.cardColor,
                        padding: EdgeInsets.only(left: Dimens.gap_dp16),
                        child: _buildItem(index),
                      );
                    }, childCount: items!.length),
                  )
                ],
              ),
            ),
    );
  }

  void _request() {
    SearchApi.search(widget.keywords,
            type: widget.type, offset: items?.length ?? 0)
        .then((value) {
      items ??= List.empty(growable: true);
      final hasMore = value['hasMore'] as bool?;
      if (hasMore != null) {
        if (hasMore) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
      switch (widget.type) {
        case SEARCH_SONGS: //单曲
          items!.addAll((value['songs'] as List).map(
            (e) => SongData.fromJson(e).buildSong(),
          ));
          break;
        case SEARCH_VIDEOS: //视频
          final video = SearchVideos.fromJson(value);
          items!.addAll(video.videos);
          break;
        case SEARCH_ALBUMS: //专辑
          final list =
              (value['albums'] as List).map((e) => Album.fromJson(e)).toList();
          items!.addAll(list);
          final count = value['albumCount'] as int? ?? 0;
          if (items!.length >= count) {
            refreshController.loadNoData();
          } else {
            refreshController.loadComplete();
          }
          break;
        case SEARCH_SINGER: //歌手
          items!.addAll(
              (value['artists'] as List).map((e) => Artists.fromJson(e)));
          break;
        case SEARCH_LYRIC: //歌词
          return Container();
        case SEARCH_PLAYLIST: //歌单
          items!.addAll((value['playlists'] as List)
              .map((e) => SimplePlayListModel.fromJson(e)));
          break;
        case SEARCH_USER: //用户
          items!.addAll(
              (value['userprofiles'] as List).map((e) => UserInfo.fromJson(e)));
          break;
      }
      setState(() {
        logger.d(items!.length);
      });
    });
  }

  Widget _buildItem(int index) {
    final item = items!.elementAt(index);
    switch (widget.type) {
      case SEARCH_SONGS: //单曲
        return SearchSongCell(song: item, keywords: widget.keywords);
      case SEARCH_VIDEOS: //视频
        return SearchVideoCell(video: item, keywords: widget.keywords);
      case SEARCH_ALBUMS: //专辑
        return SearchAlbumCell(album: item, keywords: widget.keywords);
      case SEARCH_SINGER: //歌手
        return SearchArtistCell(artist: item, keywords: widget.keywords)
            .paddingOnly(right: Dimens.gap_dp16);
      case SEARCH_LYRIC: //歌词
      case SEARCH_PLAYLIST: //歌单
        return SearchPlaylistCell(playlist: item, keywords: widget.keywords);
      case SEARCH_USER: //用户
        return SearchUserCell(userInfo: item, keywords: widget.keywords);
      default:
        throw ArgumentError('type not support');
    }
  }
}
