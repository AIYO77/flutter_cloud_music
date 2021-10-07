import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/simple_play_list_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/songs_model.dart';
import 'package:flutter_cloud_music/common/net/init_dio.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/found/model/default_search_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_ball_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/list_more_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:music_player/music_player.dart';

class MusicApi {
  //首页内容
  static Future<FoundData?> getFoundRec() async {
    FoundData? data;
    Get.log("time ${DateTime.now().millisecondsSinceEpoch}");
    final response = await httpManager.post("/homepage/block/page",
        {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      try {
        data = FoundData.fromJson(response.data);
        final responseBall =
            await httpManager.get("/homepage/dragon/ball", null);
        final List<Ball> balls =
            (responseBall.data as List).map((e) => Ball.fromJson(e)).toList();

        data.blocks.insert(1,
            Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, balls, null, null, false));
      } catch (e) {
        e.printError();
      }
    }
    return data;
  }

  //默认搜索
  static Future<DefaultSearchModel?> getDefaultSearch() async {
    DefaultSearchModel? data;
    final response = await httpManager.post('/search/default',
        {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      data = DefaultSearchModel.fromJson(response.data);
    }
    return data;
  }

  //热门歌单标签
  static Future<List<PlayListTagModel>?> getHotTags() async {
    List<PlayListTagModel>? data;
    final response = await httpManager.get('/playlist/hot', null);
    if (response.result) {
      data = (response.data as List)
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
      final list = (response.data as List)
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
      final list = (response.data as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data = PlayListHasMoreModel(datas: list, totalCount: response.total);
    }
    return data;
  }

  //获取精品歌单标签列表
  static Future<List<String>?> getHighqualityTags() async {
    final response = await httpManager.get('/playlist/highquality/tags', null);
    List<String>? tags;
    if (response.result) {
      tags = (response.data as List).map((e) => e['name'].toString()).toList();
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
      final list = (response.data as List)
          .map((e) => SimplePlayListModel.fromJson(e))
          .toList();
      data = PlayListHasMoreModel(datas: list, totalCount: response.total);
    }
    return data;
  }

  //歌单详情
  static Future<PlaylistDetailModel?> getPlaylistDetail(String id) async {
    final response =
        await httpManager.get('/playlist/detail', {'id': id, 's': '5'});
    PlaylistDetailModel? data;
    if (response.result) {
      data = response.data as PlaylistDetailModel;
    }
    return data;
  }

  //获取歌曲详情 多个逗号隔开
  static Future<List<Song>?> getSongsInfo(String ids) async {
    final response =
        await httpManager.get('/song/detail', Map.of({'ids': ids}));
    SongsModel? data;
    if (response.result) {
      data = response.data as SongsModel;
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

    final response = await httpManager
        .get('/song/url', {'id': id, 'realIP': '116.25.146.177'});
    if (response.result) {
      final list = response.data as List;
      if (list.isNotEmpty && list.first['url'] != null) {
        url = list.first['url'].toString();
        box.write('${id}url',
            {'url': url, 'time': Uri.parse(url).path.split('/').elementAt(1)});
        return url;
      }
    }
    if (url.isEmpty) {
      Fluttertoast.showToast(msg: '播放异常');
    }
    return url;
  }

  //获取FM 音乐列表
  static Future<List<MusicMetadata>?> getFmMusics() async {
    final response = await httpManager.get('/personal_fm', null);
  }
}
