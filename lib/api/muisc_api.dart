import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/model/album_cover_info.dart';
import 'package:flutter_cloud_music/common/model/album_detail.dart';
import 'package:flutter_cloud_music/common/model/album_dynamic_info.dart';
import 'package:flutter_cloud_music/common/model/artists_model.dart';
import 'package:flutter_cloud_music/common/model/calendar_events.dart';
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:flutter_cloud_music/common/model/comment_response.dart';
import 'package:flutter_cloud_music/common/model/floor_comment_model.dart';
import 'package:flutter_cloud_music/common/model/login_response.dart';
import 'package:flutter_cloud_music/common/model/mine_playlist.dart';
import 'package:flutter_cloud_music/common/model/rcmd_song_daily_model.dart';
import 'package:flutter_cloud_music/common/model/simple_play_list_model.dart';
import 'package:flutter_cloud_music/common/model/singer_albums_model.dart';
import 'package:flutter_cloud_music/common/model/singer_detail_model.dart';
import 'package:flutter_cloud_music/common/model/singer_videos_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/songs_model.dart';
import 'package:flutter_cloud_music/common/model/top_album_cover_info.dart';
import 'package:flutter_cloud_music/common/model/user_detail_model.dart';
import 'package:flutter_cloud_music/common/net/init_dio.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/found/model/found_ball_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:flutter_cloud_music/pages/music_calendar/content/calender_model.dart';
import 'package:flutter_cloud_music/pages/new_song_album/album/top_album_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/list_more_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MusicApi {
  ///首页内容
  static Future<FoundData?> getFoundRec(
      {bool refresh = false, Map<String, dynamic>? cacheData}) async {
    FoundData? oldData;
    if (cacheData != null) {
      oldData = FoundData.fromJson(cacheData);
    }
    final response = await httpManager.get("/homepage/block/page", {
      'refresh': refresh,
      'cursor': oldData?.cursor,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });
    if (response.result) {
      try {
        final recmData = FoundData.fromJson(response.data['data']);
        final responseBall =
            await httpManager.get("/homepage/dragon/ball", null);
        //缓存数字专辑Url
        final url = box.read(CACHE_ALBUM_POLY_DETAIL_URL);
        if (GetUtils.isNullOrBlank(url) == true) {
          (responseBall.data['data'] as List)
              .map((e) => Ball.fromJson(e))
              .toList()
              .forEach((element) {
            if (element.id == 13000) {
              box.write(CACHE_ALBUM_POLY_DETAIL_URL, element.url);
            }
          });
        }
        recmData.blocks.insert(
            1,
            Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, responseBall.data['data'],
                null, null, false));
        return _diffData(recmData, oldData);
      } catch (e) {
        e.printError();
      }
    }
    return null;
  }

  static Future<FoundData?> _diffData(
      FoundData recmData, FoundData? oldData) async {
    if (oldData == null || recmData.blocks.length > oldData.blocks.length) {
      box.write(CACHE_HOME_FOUND_DATA, recmData.toJson());
      return Future.value(recmData);
    } else {
      ///有缓存过数据 进行比较差量更新
      final List<Blocks> diffList = List.empty(growable: true);

      final newBlocks = recmData.blocks;

      for (final old in oldData.blocks) {
        final index = newBlocks
            .indexWhere((element) => element.blockCode == old.blockCode);
        if (index != -1) {
          //新的数据包含旧的数据 替换旧的数据
          diffList.add(newBlocks.elementAt(index));
        } else {
          //新的数据不包含旧的数据 用换旧的数据
          diffList.add(old);
        }
      }
      //组装新的展示数据
      final newData = FoundData(recmData.cursor, diffList, recmData.pageConfig);
      box.write(CACHE_HOME_FOUND_DATA, newData.toJson());
      return Future.value(newData);
    }
  }

  ///热门歌单标签
  static Future<List<PlayListTagModel>?> getHotTags() async {
    List<PlayListTagModel>? data;
    final response = await httpManager.get('/playlist/hot', null);
    if (response.result) {
      data = (response.data['tags'] as List)
          .map((e) => PlayListTagModel.fromJson(e))
          .toList();
    }
    return data;
  }

  ///推荐歌单列表不支持分页
  static Future<PlayListHasMoreModel?> getRcmPlayList() async {
    final response = await httpManager.get('/personalized',
        {"limit": 99, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    PlayListHasMoreModel? data;
    if (response.result) {
      final list = (response.data['result'] as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data = PlayListHasMoreModel(datas: list, totalCount: response.total);
    }
    return data;
  }

  ///获取网友精选碟歌单
  static Future<PlayListHasMoreModel?> getPlayListFromTag(
    String tag,
    int limit,
    int offset,
  ) async {
    final response = await httpManager.get('/top/playlist', {
      "cat": tag,
      "limit": limit,
      "offset": offset,
    });
    PlayListHasMoreModel? data;
    if (response.result) {
      final list = (response.data['playlists'] as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data =
          PlayListHasMoreModel(datas: list, totalCount: response.data['total']);
    }
    return data;
  }

  ///获取精品歌单标签列表
  static Future<List<String>?> getHighqualityTags() async {
    final response = await httpManager.get('/playlist/highquality/tags', null);
    List<String>? tags;
    if (response.result) {
      tags = (response.data['tags'] as List)
          .map((e) => e['name'].toString())
          .toList();
    }
    return tags;
  }

  ///获取精品歌单
  static Future<PlayListHasMoreModel?> getHighqualityList(
    String? tag,
    int limit,
    int? before,
  ) async {
    Get.log('tag = $tag  before = $before');
    final par = {"limit": limit.toString()};
    par.addIf(before != null, 'before', before.toString());
    par.addIf(tag != null, "cat", tag.toString());
    final response = await httpManager.get('/top/playlist/highquality', par);
    PlayListHasMoreModel? data;
    if (response.result) {
      final list = (response.data['playlists'] as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data =
          PlayListHasMoreModel(datas: list, totalCount: response.data['total']);
    }
    return data;
  }

  ///歌单详情
  static Future<PlaylistDetailModel?> getPlaylistDetail(String id) async {
    final response = await httpManager.get('/playlist/detail', {
      'id': id,
      's': '5',
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });
    PlaylistDetailModel? data;
    if (response.result) {
      data = PlaylistDetailModel.fromJson(response.data);
    }
    return data;
  }

  ///获取歌曲详情 多个逗号隔开
  static Future<List<Song>?> getSongsInfo(String ids) async {
    final response =
        await httpManager.get('/song/detail', Map.of({'ids': ids}));
    SongsModel? data;
    if (response.result) {
      data = SongsModel.fromJson(response.data);
      for (final song in data.songs) {
        song.privilege =
            data.privileges.firstWhere((element) => element.id == song.id);
      }
    }
    return data?.songs;
  }

  ///获取歌曲播放地址
  static Future<String> getPlayUrl(int id, {int br = 320000}) async {
    logger.d('request url id = $id');
    String url = '';
    final his = box.read('${id}url');
    if (his != null) {
      logger.i('url has cache $his');
      final endTime = int.parse(his['time']);
      final curTime =
          int.parse(DateFormat('yyyyMMddHHmmss').format(DateTime.now()));
      if (curTime < endTime) {
        return his['url'].toString();
      } else {
        //过期
        box.remove('${id}url');
      }
    }

    final response = await httpManager.get('/song/url', {'id': id});
    if (response.result) {
      final list = response.data['data'] as List;
      if (list.isNotEmpty && list.first['url'] != null) {
        url = list.first['url'].toString();
        box.write('${id}url',
            {'url': url, 'time': Uri.parse(url).path.split('/').elementAt(1)});
        return url;
      }
    }
    if (url.isEmpty) {
      url = id.playUrl();
    }
    return url;
  }

  ///根据音乐id获取歌词
  static Future<String?> lyric(int id) async {
    ///有缓存 直接返回
    final cached = box.read<String>(id.toString());
    if (cached != null) {
      return cached;
    }
    final result = await httpManager.get('/lyric', {"id": id});
    final lrcData = result.data['lrc'];
    if (!result.result) {
      return Future.error(lrcData);
    }
    final lyc = Map.from(lrcData);
    //歌词内容
    final content = lyc["lyric"].toString();
    //更新缓存
    await box.write(id.toString(), content);
    return content;
  }

  ///给歌曲加红心
  static Future<bool?> like(int? musicId, {required bool like}) async {
    final response =
        await httpManager.get("/like", {"id": musicId, "like": like});
    if (response.isSuccess()) {
      final favorites = box.read<List>(CACHE_FAVORITE_SONG_IDS)?.cast<int>();
      if (favorites != null) {
        if (like) {
          favorites.add(musicId!);
        } else {
          favorites.remove(musicId);
        }

        box.write(CACHE_FAVORITE_SONG_IDS, favorites);
      }
      return true;
    }
    return null;
  }

  ///获取用户红心歌曲id列表
  static Future<List<int>?> likedList() async {
    final favorites = box.read<List>(CACHE_FAVORITE_SONG_IDS)?.cast<int>();
    if (favorites != null) {
      return Future.value(favorites);
    }
    final response =
        await httpManager.get("/likelist", {"uid": AuthService.to.userId});
    if (response.isSuccess()) {
      final list = (response.data['ids'] as List)
          .map((e) => int.parse(e.toString()))
          .toList();
      box.write(CACHE_FAVORITE_SONG_IDS, list);
      return Future.value(list);
    }
    return Future.value(null);
  }

  ///获取歌曲评论
  static Future<CommentResponse?> getMusicComment(int id,
      {int limit = 20, int offset = 0, int? time}) async {
    final response = await httpManager.get('/comment/music',
        {'id': id, 'limit': limit, 'offset': offset, 'before': time});
    if (response.result) {
      return CommentResponse.fromJson(response.data);
    }
    return null;
  }

  ///获取歌曲评论数量
  static Future<int> getMusicCommentCouunt(int id) async {
    final count = box.read<int>('$id$CACHE_MUSIC_COMMENT_COUNT');
    if (count != null) {
      return count;
    }
    final coment = await getMusicComment(id, limit: 0);
    if (coment != null) {
      box.write('$id$CACHE_MUSIC_COMMENT_COUNT', coment.total);
      return coment.total;
    }
    return 0;
  }

  ///获取每日推荐
  static Future<RcmdSongDailyModel?> getRcmdSongs() async {
    final response = await httpManager.get('/recommend/songs', null);

    if (response.result) {
      return RcmdSongDailyModel.fromJson(response.data['data']);
    }
    return null;
  }

  ///获取FM 音乐列表 需要登录
  static Future<List<Song>?> getFmMusics() async {
    final response = await httpManager.get(
        '/personal_fm', {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      return (response.data['data'] as List)
          .map((e) => SongData.fromJson(e).buildSong())
          .toList();
    }
    return null;
  }

  /// 音乐从私人 FM 中移除至垃圾桶
  static Future<bool> trashMusic(dynamic id) async {
    final response = await httpManager.get('/fm_trash', {'id': id});
    return response.isSuccess();
  }

  ///获取推荐新歌
  static Future<List<Song>?> getRecmNewSongs() async {
    final response =
        await httpManager.get('/personalized/newsong', {'limit': 50});
    if (response.result) {
      final list = response.data['result'] as List;
      return list.map((e) => SongData.fromJson(e['song']).buildSong()).toList();
    }
    return null;
  }

  ///根据tag获取新歌
  static Future<List<Song>?> getNewSongFromTag(int tag) async {
    final response = await httpManager.get('/top/song', {'type': tag});
    if (response.result) {
      return (response.data['data'] as List)
          .map((e) => SongData.fromJson(e).buildSong())
          .toList();
    }
    return null;
  }

  ///获取最新数字专辑
  static Future<List<AlbumCoverInfo>?> getNewAlbum({int limit = 3}) async {
    final response = await httpManager.get('/album/list', {'limit': limit});
    if (response.result) {
      return (response.data['products'] as List)
          .map((e) => AlbumCoverInfo.fromJson(e))
          .toList();
    }
    return null;
  }

  ///获取新碟上架列表
  static Future<List<TopAlbumModel>> getTopAlbum(int year, int month,
      {List<TopAlbumModel>? oldData}) async {
    final response =
        await httpManager.get('/top/album', {'year': year, 'month': month});
    final resultData = List<TopAlbumModel>.empty(growable: true);
    if (oldData != null) {
      resultData.addAll(oldData);
    }
    if (response.result) {
      final weekData = response.data['weekData'];
      final monthData = response.data['monthData'];
      if (weekData != null) {
        final list = (weekData as List)
            .map((e) => TopAlbumCoverInfo.fromJson(e))
            .toList();
        resultData.add(TopAlbumModel(label: '本周新碟', data: list));
      }
      if (monthData != null) {
        final list = (monthData as List)
            .map((e) => TopAlbumCoverInfo.fromJson(e))
            .toList();
        resultData
            .add(TopAlbumModel(dateTime: DateTime(year, month), data: list));
      }
    }
    return resultData;
  }

  ///获取专辑内容
  static Future<AlbumDetail?> getAlbumDetail(String albumId) async {
    final response = await httpManager.get('/album', {'id': albumId});
    if (response.result) {
      if (response.data['resourceState'] as bool) {
        return AlbumDetail.fromJson(response.data);
      }
    }
    return null;
  }

  ///可获得专辑动态信息,如是否收藏,收藏数,评论数,分享数
  static Future<AlbumDynamicInfo> getAlbumDynamicInfo(String albumId) async {
    final response =
        await httpManager.get('/album/detail/dynamic', {'id': albumId});
    if (response.result) {
      return AlbumDynamicInfo.fromJson(response.data);
    }
    return AlbumDynamicInfo(0, 0, 0, false, 0);
  }

  ///音乐日历
  static Future<List<CalenderModel>> getCalendarEvents(
      DateTime startTime, DateTime endTime) async {
    final response = await httpManager.get('/calendar', {
      'startTime': startTime.millisecondsSinceEpoch,
      'endTime': endTime.millisecondsSinceEpoch
    });
    final resultList = List<CalenderModel>.empty(growable: true);
    if (response.result) {
      final originalList = (response.data['data']['calendarEvents'] as List)
          .map((e) => CalendarEvents.fromJson(e))
          .toList();
      for (final value in originalList) {
        if (resultList.isNotEmpty) {
          final data = resultList.last;
          final isSameDay = DateUtils.isSameDay(
              data.time, DateTime.fromMillisecondsSinceEpoch(value.onlineTime));
          if (isSameDay) {
            //同一天的日历
            data.events.add(value);
          } else {
            //不是同一天的日历
            resultList.add(CalenderModel(
                DateTime.fromMillisecondsSinceEpoch(value.onlineTime),
                [value]));
          }
        } else {
          resultList.add(CalenderModel(
              DateTime.fromMillisecondsSinceEpoch(value.onlineTime), [value]));
        }
      }
    }
    return resultList;
  }

  ///歌手分类列表
  static Future<ArtistsModel> getArtists(
      int page, String initial, int type, int area) async {
    const limit = 20;

    final response = await httpManager.get('/artist/list', {
      'limit': limit,
      'offset': limit * page,
      'initial': initial,
      'type': type,
      'area': area
    });
    if (response.isSuccess()) {
      return ArtistsModel.fromJson(response.data);
    }
    return ArtistsModel(List.empty(), false);
  }

  /// 收藏/取消收藏歌手
  /// t:操作,1 为收藏,其他为取消收藏
  static Future<bool> subArtist(String id, int t) async {
    final response = await httpManager.post('/artist/sub',
        {'id': id, 't': t, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    return response.isSuccess();
  }

  /// 收藏/取消收藏用户
  /// t:操作,1 为收藏,其他为取消收藏
  static Future<bool> subUser(String id, int t) async {
    final response = await httpManager.post('/follow',
        {'id': id, 't': t, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    return response.isSuccess();
  }

  ///获取歌手信息
  static Future<SingerDetailModel?> getSingerInfo(String id) async {
    final response = await httpManager.get('/artist/detail',
        {'id': id, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      final model = SingerDetailModel.fromJson(response.data['data']);
      if (model.user == null) {
        //如果user为空 则获取不到是否关注
        //目前需要单独获取其他接口
        final artist = await getArtistsInfo(id);
        if (artist != null) {
          model.artist.followed = artist.followed;
        }
      } else {
        //是入驻歌手
        model.userDetailModel = await getUserDetail(
            model.user!.userId.toString(),
            haveSingerInfo: true);
      }
      return model;
    }
    return null;
  }

  ///歌手部分信息
  static Future<Artists?> getArtistsInfo(String id) async {
    final artistResponse = await httpManager.get('/artists',
        {'id': id, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (artistResponse.result) {
      return Artists.fromJson(artistResponse.data['artist']);
    }
    return null;
  }

  ///获取用户信息
  static Future<UserDetailModel?> getUserDetail(String id,
      {bool haveSingerInfo = false}) async {
    final response = await httpManager.get('/user/detail',
        {'uid': id, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      final user = UserDetailModel.fromJson(response.data);
      //如果是歌手 并且没有歌手信息
      if (user.isSinger() && user.singerModel == null && !haveSingerInfo) {
        user.singerModel =
            await getSingerInfo(user.profile.artistId!.toString());
      }
      return user;
    }
    return null;
  }

  ///获取用户等级
  static Future<int> getUserLevel() async {
    final response = await httpManager.get('/user/level', null);
    if (response.result) {
      return int.parse(response.data['data']['level'].toString());
    }
    return 0;
  }

  ///获取相似歌手
  static Future<List<Ar>?> getSimiArtist(String artistId) async {
    final response = await httpManager.get('/simi/artist', {'id': artistId});
    if (response.result) {
      return (response.data['artists'] as List)
          .map((e) => Ar.fromJson(e))
          .toList();
    }
    return null;
  }

  ///获取歌手全部歌曲
  static Future<List<Song>?> getArtistSongs(
      {required int artistId, String order = 'hot', int offset = 0}) async {
    final response = await httpManager.get('/artist/songs',
        {'id': artistId, 'order': order, 'limit': 50, 'offset': offset});
    if (response.result) {
      return (response.data['songs'] as List)
          .map((e) => Song.fromJson(e))
          .toList();
    } else {
      toast('获取失败');
    }
    return List.empty();
  }

  ///获取歌手专辑 分页
  static Future<SingerAlbumsModel?> getArtistAlbums(
      {required int artistId, int offset = 0}) async {
    final response = await httpManager
        .get('/artist/album', {'id': artistId, 'limit': 50, 'offset': offset});

    if (response.result) {
      return SingerAlbumsModel.fromJson(response.data);
    }
    return null;
  }

  ///获取歌手全部视频 包含MV
  static Future<SingerVideosModel?> getArtistVideos(
      {required int artistId, required String cursor}) async {
    final response = await httpManager
        .get('/artist/video', {'id': artistId, 'cursor': cursor});
    if (response.result) {
      return SingerVideosModel.fromJson(response.data['data']);
    }
    return null;
  }

  ///获取用户歌单
  static Future<List<MinePlaylist>> getMinePlaylist(dynamic uid) async {
    final response = await httpManager.get('/user/playlist',
        {'uid': uid, 'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      return (response.data['playlist'] as List)
          .map((e) => MinePlaylist.fromJson(e))
          .toList();
    }
    return List.empty();
  }

  ///获取歌单所有歌曲
  static Future<List<Song>?> getPlayListAllTrack(dynamic id) async {
    final response =
        await httpManager.get('/playlist/track/all', {'id': id}, noTip: true);
    SongsModel? data;
    if (response.result) {
      data = SongsModel.fromJson(response.data);
      for (final song in data.songs) {
        song.privilege =
            data.privileges.firstWhere((element) => element.id == song.id);
      }
    }
    return data?.songs;
  }

  ///心动模式
  static Future<List<Song>?> startIntelligence(
      {required dynamic songId, required dynamic pid}) async {
    final response = await httpManager.get(
        '/playmode/intelligence/list', {'id': songId, 'pid': pid},
        noTip: true);
    if (response.result) {
      final listData = response.data['data'] as List;
      logger.d('listData size : ${listData.length}');
      final infos = listData.map((e) => e['songInfo']);
      logger.d('infos size : ${infos.length}');
      return infos.map((e) => Song.fromJson(e)).toList();
    }
    return null;
  }

  ///删除歌单
  static Future<bool> deletePlaylist(List<int> ids) async {
    final response =
        await httpManager.post('/playlist/delete', {'id': ids.join(',')});
    return response.isSuccess();
  }

  ///根据歌单id顺序 调整歌单顺序
  static Future<bool> updatePlaylistOrder(List<int> ids) async {
    final response =
        await httpManager.post('/playlist/order/update', {'ids': ids});
    return response.isSuccess();
  }

  ///创建歌单
  static Future<MinePlaylist?> createPlaylist(
      {required String name, required String type, String? privacy}) async {
    final map = {'name': name, 'type': type};
    if (privacy != null) {
      map['privacy'] = privacy;
    }
    final response = await httpManager.post('/playlist/create', map);
    if (response.result) {
      final pl = response.data['playlist'];
      return MinePlaylist(
          pl['trackCount'],
          pl['specialType'],
          pl['name'],
          pl['coverImgUrl'],
          pl['id'],
          pl['privacy'],
          AuthService.to.loginData.value!.profile!.userinfo());
    }
    return null;
  }

  ///最近播放-歌曲
  static Future<List<Song>> getRecentPlay() async {
    final response = await httpManager.get('/record/recent/song',
        {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      final list = response.data['data']['list'] as List;
      return list.map((e) => Song.fromJson(e['data'])).toList();
    }
    return List.empty();
  }

  /// 对歌单添加或删除歌曲
  /// op: 从歌单增加单曲为 add, 删除为 del
  /// pid: 歌单 id tracks: 歌曲 id,可多个,用逗号隔开
  static Future<bool> addOrDelTracks(
      {required String op,
      required String pid,
      required List<int> trackIds}) async {
    final response = await httpManager.get('/playlist/tracks', {
      'op': op,
      'pid': pid,
      'tracks': trackIds.join(',')
      // 'timestamp': DateTime.now().millisecondsSinceEpoch
    });
    if (response.result) {
      final code = response.data['body']['code'];
      if (code == 200) {
        return true;
      } else {
        final errorStr = response.data['body']['message'] as String?;
        EasyLoading.showError(errorStr ?? '添加失败');
        return false;
      }
    }
    EasyLoading.dismiss();
    return false;
  }

  ///获取资源的评论
  /// pageNo:分页参数,第 N 页,默认为 1
  /// pageSize:分页参数,每页多少条数据,默认 20
  /// sortType: 排序方式, 1:按推荐排序, 2:按热度排序, 3:按时间排序
  /// cursor: 当sortType为 3 时且页数不是第一页时需传入,值为上一条数据的 time
  /// type: 0: 歌曲 1: mv 2: 歌单  3: 专辑 4: 电台 5: 视频 6: 动态
  static Future<CommentModel?> getResourceComment({
    required String id,
    required int type,
    int pageNo = 1,
    int pageSize = 20,
    int sortType = 1, // 排序方式, 1:按推荐排序, 2:按热度排序, 3:按时间排序
    String? cursor, //当 sortType==3 && 页数不是第一页时需传入 值为上一条数据的time
  }) async {
    final par = <String, dynamic>{
      'id': id,
      'type': type,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'sortType': sortType
    };
    if (cursor != null) {
      par['cursor'] = cursor;
    }
    final response = await httpManager.get('/comment/new', par);
    if (response.isSuccess()) {
      return CommentModel.fromJson(response.dataData());
    }
    return null;
  }

  ///楼层评论
  static Future<FloorCommentModel?> getFloorComment({
    required String parentCommentId, //楼层评论 id
    required String resId, //资源id
    required int type, //资源类型
  }) async {
    final response = await httpManager.get('/comment/floor', {
      'parentCommentId': parentCommentId,
      'id': resId,
      'type': type,
      'limit': 10000 //楼层评论不会太多 不分页
    });
    if (response.isSuccess()) {
      return FloorCommentModel.fromJson(response.dataData());
    }
    return null;
  }

  ///给评论点赞
  ///id : 资源 id
  ///cid : 评论 id
  ///t : 是否点赞 , 1 为点赞 ,0 为取消点赞
  ///type:资源类型
  static Future<bool> likeComment({
    String? id,
    String? threadId,
    required int type,
    required int cid,
    required int t,
  }) async {
    if (id == null && threadId == null) {
      throw ArgumentError('id/threadId must satisfy one');
    }
    final map = <String, dynamic>{
      'type': type,
      'cid': cid,
      't': t,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    if (id != null) {
      map['id'] = id;
    }
    if (threadId != null) {
      map['threadId'] = threadId;
    }
    final response = await httpManager.get('/comment/like', map);
    return response.isSuccess();
  }

  static Future comment() async {}
}
