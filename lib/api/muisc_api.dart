import 'package:flutter_cloud_music/common/model/comment_response.dart';
import 'package:flutter_cloud_music/common/model/simple_play_list_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/songs_model.dart';
import 'package:flutter_cloud_music/common/net/init_dio.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/found/model/default_search_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/list_more_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:music_player/music_player.dart';

class MusicApi {
  //首页内容
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
    if (oldData == null) {
      box.write(CACHE_HOME_FOUND_DATA, recmData.toJson());
      return Future.value(recmData);
    } else {
      //有缓存过数据 进行比较差量更新
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

  //默认搜索
  static Future<DefaultSearchModel?> getDefaultSearch() async {
    DefaultSearchModel? data;
    final response = await httpManager.get('/search/default',
        {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      data = DefaultSearchModel.fromJson(response.data['data']);
    }
    return data;
  }

  //热门歌单标签
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

  //推荐歌单列表不支持分页
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

  //获取网友精选碟歌单
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

  //获取精品歌单标签列表
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

  //获取精品歌单
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

  //歌单详情
  static Future<PlaylistDetailModel?> getPlaylistDetail(String id) async {
    final response =
        await httpManager.get('/playlist/detail', {'id': id, 's': '5'});
    PlaylistDetailModel? data;
    if (response.result) {
      data = PlaylistDetailModel.fromJson(response.data);
    }
    return data;
  }

  //获取歌曲详情 多个逗号隔开
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

  //获取歌曲播放地址
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
      //部分音乐可能获取不到播放地址 可以通过这种方式直接播放
      url = 'https://music.163.com/song/media/outer/url?id=$id.mp3';
    }
    return url;
  }

  ///根据音乐id获取歌词
  static Future<String?> lyric(int id) async {
    //有缓存 直接返回
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
    if (response.isSucesse()) {
      final favorites = box.read<List>(CACHE_FAVORITESONGIDS)?.cast<int>();
      if (favorites != null) {
        if (like) {
          favorites.add(musicId!);
        } else {
          favorites.remove(musicId);
        }

        box.write(CACHE_FAVORITESONGIDS, favorites);
      }
      return true;
    }
    return null;
  }

  ///获取用户红心歌曲id列表
  static Future<List<int>?> likedList() async {
    final favorites = box.read<List>(CACHE_FAVORITESONGIDS)?.cast<int>();
    if (favorites != null) {
      return Future.value(favorites);
    }
    final response =
        await httpManager.get("/likelist", {"uid": AuthService.to.userId});
    if (response.isSucesse()) {
      final list = (response.data['ids'] as List)
          .map((e) => int.parse(e.toString()))
          .toList();
      box.write(CACHE_FAVORITESONGIDS, list);
      return Future.value(list);
    }
    return Future.value(null);
  }

  //获取歌曲评论
  static Future<CommentResponse?> getMusicComment(int id,
      {int limit = 20, int offset = 0, int? time}) async {
    final response = await httpManager.get('/comment/music',
        {'id': id, 'limit': limit, 'offset': offset, 'before': time});
    if (response.result) {
      return CommentResponse.fromJson(response.data);
    }
    return null;
  }

  //获取歌曲评论数量
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

  //获取FM 音乐列表 需要登录
  static Future<List<MusicMetadata>?> getFmMusics() async {
    final response = await httpManager.get('/personal_fm', null);
    if (response.result) {}
    return null;
  }
}
