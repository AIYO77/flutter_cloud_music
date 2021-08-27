import 'package:flutter_cloud_music/common/net/init_dio.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/found/model/default_search_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_ball_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/hot_play_list_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:get/get.dart';

class MusicApi {
  //首页内容
  static Future<FoundData?> getFoundRec() async {
    FoundData? data;
    Get.log("time ${DateTime.now().millisecondsSinceEpoch}");
    final response = await httpManager.post(
        "/homepage/block/page?timestamp=${DateTime.now().millisecondsSinceEpoch}",
        null);
    if (response.result) {
      data = FoundData.fromJson(response.data);
      final responseBall = await httpManager.get("/homepage/dragon/ball", null);
      final List<Ball> balls =
          (responseBall.data as List).map((e) => Ball.fromJson(e)).toList();

      data.blocks.insert(
          1, Blocks("HOMEPAGE_BALL", SHOWTYPE_BALL, balls, null, null, false));
    }
    return data;
  }

  //默认搜索
  static Future<DefaultSearchModel?> getDefaultSearch() async {
    DefaultSearchModel? data;
    final response = await httpManager.post(
        '/search/default?timestamp=${DateTime.now().millisecondsSinceEpoch}',
        null);
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
}
