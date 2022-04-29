import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/api/search_api.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_album.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_artist.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_playLists.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_sim_query.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_songs.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_user.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_album.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_artist.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_playlist.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_sim_query.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_song.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/cell_user.dart';
import 'package:flutter_cloud_music/pages/search/search_result/widgets/search_more_card.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/27 8:08 下午
/// Des: 综合结果

class SynthesizePage extends StatefulWidget {
  final String keywords;

  final ParamSingleCallback<int> onMoreTap;

  const SynthesizePage({required this.keywords, required this.onMoreTap});

  @override
  _State createState() => _State();
}

class _State extends State<SynthesizePage> {
  late List<Widget> items;

  @override
  void initState() {
    super.initState();
    items = List.empty(growable: true);
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Padding(
            padding: EdgeInsets.only(top: Dimens.gap_dp50),
            child: MusicLoading(),
          )
        : ListView(
            padding: EdgeInsets.zero,
            children: items,
          );
  }

  Future _request() async {
    items.clear();
    final result =
        await SearchApi.search(widget.keywords, type: SEARCH_COMPOSITE);
    if (result != null) {
      (result['order'] as List).map((e) => e.toString()).forEach((element) {
        switch (element) {
          case 'song':
            final songs = SearchSongs.fromJson(result[element]);
            items.add(SearchMoreCard(
                keywords: widget.keywords,
                title: '单曲',
                moreText: songs.moreText,
                onMoreTap: () {
                  widget.onMoreTap.call(SEARCH_SONGS);
                },
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: songs.songs
                      .map((e) =>
                          SearchSongCell(song: e, keywords: widget.keywords))
                      .toList(),
                )));
            break;
          case 'playList':
            final playlist = SearchPlayLists.fromJson(result[element]);
            items.add(SearchMoreCard(
              keywords: widget.keywords,
              title: '歌单',
              moreText: playlist.moreText,
              onMoreTap: () {
                widget.onMoreTap.call(SEARCH_PLAYLIST);
              },
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: playlist.playLists
                    .map(
                      (e) => SearchPlaylistCell(
                        playlist: e,
                        keywords: widget.keywords,
                      ),
                    )
                    .toList(),
              ),
            ));
            break;
          case 'artist':
            final artist = SearchArtist.fromJson(result[element]);
            items.add(SearchMoreCard(
              keywords: widget.keywords,
              title: '艺人',
              moreText: artist.moreText,
              onMoreTap: () {
                widget.onMoreTap.call(SEARCH_SINGER);
              },
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: artist.artists
                    .map((e) =>
                        SearchArtistCell(artist: e, keywords: widget.keywords))
                    .toList(),
              ),
            ));
            break;
          case 'album':
            final album = SearchAlbum.fromJson(result[element]);
            items.add(SearchMoreCard(
                keywords: widget.keywords,
                title: '专辑',
                moreText: album.moreText,
                onMoreTap: () {
                  widget.onMoreTap.call(SEARCH_ALBUMS);
                },
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: album.albums
                      .map((e) =>
                          SearchAlbumCell(album: e, keywords: widget.keywords))
                      .toList(),
                )));
            break;
          case 'sim_query':
            final sim = SearchSimQuery.fromJson(result[element]);
            items.add(SearchMoreCard(
                keywords: widget.keywords,
                title: '相关搜索',
                child: Wrap(
                  spacing: Dimens.gap_dp10,
                  runSpacing: Dimens.gap_dp10,
                  children: sim.sim_querys
                      .map((e) => SearchSimQueryCell(
                          keywordValue: e, keywords: widget.keywords))
                      .toList(),
                )));
            break;
          case 'user':
            final user = SearchUser.fromJson(result[element]);
            items.add(SearchMoreCard(
              keywords: widget.keywords,
              moreText: user.moreText,
              onMoreTap: () {
                widget.onMoreTap.call(SEARCH_USER);
              },
              title: '用户',
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: user.users
                    .map((e) =>
                        SearchUserCell(userInfo: e, keywords: widget.keywords))
                    .toList(),
              ),
            ));
            break;
        }
      });
    }
    Future.delayed(const Duration(milliseconds: 10)).whenComplete(() {
      setState(() {});
    });
  }
}
