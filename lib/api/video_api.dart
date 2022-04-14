import 'package:flutter_cloud_music/common/model/video_detail_model.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/video/state.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../common/ext/ext.dart';
import '../common/model/mv_detail_model.dart';
import '../common/model/video_count_info.dart';
import '../common/net/init_dio.dart';
import '../pages/found/model/shuffle_log_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/22 2:35 下午
/// Des:

class VideoApi {
  ///获取播放地址
  ///type 0:MV 1:视频 2:MLog
  static Future<String> getVideoPlayUrl(String id) async {
    final cacheUrl = box.read<String>(id);
    if (cacheUrl != null && cacheUrl.isNotEmpty) {
      //有缓存
      final uri = Uri.parse(cacheUrl);
      final createTime = uri.queryParameters['wsTime'];
      if (createTime != null) {
        //当前时间
        final curTime = DateTime.now().millisecondsSinceEpoch;
        //过期时间 一个小时后
        final exceedTime = (double.parse(createTime) + 60 * 60) * 1000;
        if (curTime > exceedTime) {
          //地址已过期
          logger.e(
              '地址已过期 过期时间：${DateTime.fromMillisecondsSinceEpoch(exceedTime.toInt())}');
          box.remove(id);
        } else {
          //没有过期
          logger.i('缓存没有过期 直接使用');
          return cacheUrl;
        }
      }
    }
    String url = '';
    if (id.isMv()) {
      final response = await httpManager.get('/mv/url', {'id': id});
      url = response.data['data']['url'].toString();
    } else if (id.isVideo()) {
      url = await _getVideoUrl(id);
    } else if (id.isMLog()) {
      final videoId = await mlogToVideo(id);
      url = await _getVideoUrl(videoId);
    } else {
      toast('未知视频ID类型: $id');
    }
    if (url.isNotEmpty) {
      url = url.toHttps();
    }
    box.write(id, url);
    return url;
  }

  static Future<String> _getVideoUrl(String id) async {
    final response = await httpManager.get('/video/url', {'id': id});
    return (response.data['urls'] as List).first['url'].toString();
  }

  ///收藏视频到视频歌单
  static Future<bool> addVideoToPl(
      {required String pid, required List<dynamic> ids}) async {
    final response = await httpManager.get(
        '/playlist/track/add', {'pid': pid, 'ids': ids.join(',')},
        noTip: true);
    if (response.isSuccess()) {
      return true;
    } else {
      final errorStr = response.data.toString();
      EasyLoading.showError(errorStr);
      return false;
    }
  }

  ///视频点赞
  static Future<bool> likeVideo(String id, int t) async {
    if (id.isMv()) {
      return likeResource(id: id, t: t, type: 1);
    } else if (id.isVideo()) {
      return likeResource(id: id, t: t, type: 5);
    } else {
      final videoId = await mlogToVideo(id);
      return likeResource(id: videoId, t: t, type: 5);
    }
  }

  ///对 MV,电台,视频,动态点赞
  ///id: 资源 id
  ///type: 1: mv 4: 电台  5: 视频 6: 动态
  ///t: 操作,1 为点赞,其他为取消点赞
  ///如给动态点赞，不需要传入 id，需要传入 threadId
  static Future<bool> likeResource({
    required String id,
    required int t,
    required int type,
  }) async {
    final response = await httpManager
        .get('/resource/like', {'id': id, 'type': type, 't': t});
    return response.isSuccess();
  }

  ///获取我点赞过的视频
  static Future<List<MLogResource>> getMyLikeVideos() async {
    if (!AuthService.to.isLoggedInValue) return List.empty();
    final response = await httpManager.get('/playlist/mylike',
        {'timestamp': DateTime.now().millisecondsSinceEpoch});
    if (response.result) {
      return (response.data['data']['feeds'] as List)
          .map((e) => MLogResource.fromJson(e))
          .toList();
    }
    return List.empty();
  }

  ///获取看过的视频
  static Future<List<MLogResource>> getRecentVideos() async {
    final response = await httpManager.get('/playlist/video/recent', null);
    if (response.result) {
      return (response.data['data']['videos'] as List)
          .map((e) => MLogResource.fromJson(e))
          .toList();
    }
    return List.empty();
  }

  /// 视频/MV/Mlog 点赞转发评论数
  static Future<VideoCountInfo> getVideoCountInfoWIthType(String id) async {
    VideoCountInfo info = VideoCountInfo(0, 0, 0);
    if (id.isMv()) {
      final response = await httpManager.get('/mv/detail/info', {'mvid': id});
      info = VideoCountInfo.fromJson(response.data);
    } else if (id.isVideo()) {
      info = await _getVideoCountInfo(id);
    } else if (id.isMLog()) {
      final videoId = await mlogToVideo(id);
      info = await _getVideoCountInfo(videoId);
    } else {
      toast('未知视频ID类型: $id');
    }
    return info;
  }

  ///获取视频点赞转发评论数
  static Future<VideoCountInfo> _getVideoCountInfo(String id) async {
    VideoCountInfo info = VideoCountInfo(0, 0, 0);
    final response = await httpManager.get('/video/detail/info', {'vid': id});
    if (response.isSuccess()) {
      info = VideoCountInfo.fromJson(response.data);
    }
    return info;
  }

  ///获取视频详情
  static Future<dynamic> getVideoInfo(String id) async {
    if (id.isMv()) {
      final response = await httpManager.get('/mv/detail', {'mvid': id});
      return MvDetailModel.fromJson(response.data['data']);
    } else if (id.isVideo()) {
      return _getVideoInfo(id);
    } else if (id.isMLog()) {
      final videoId = await mlogToVideo(id);
      return _getVideoInfo(videoId);
    } else {
      toast('未知视频ID类型: $id');
    }
  }

  static Future<VideoDetailModel> _getVideoInfo(String id) async {
    final response = await httpManager.get('/video/detail', {'id': id});
    return VideoDetailModel.fromJson(response.data['data']);
  }

  ///相关视频
  static Future<List<VideoModel>> getRelatedVideo(String id) async {
    if (id.isMv()) {
      final response = await httpManager.get('/simi/mv', {'mvid': id});
      return (response.data['mvs'] as List)
          .map((e) => VideoModel(id: e['id'].toString(), coverUrl: e['cover']))
          .toList();
    } else if (id.isVideo()) {
      return _getRelateVideo(id);
    } else if (id.isMLog()) {
      final videoId = await mlogToVideo(id);
      return _getRelateVideo(videoId);
    } else {
      return List.empty();
    }
  }

  static Future<List<VideoModel>> _getRelateVideo(String id) async {
    final response = await httpManager.get('/related/allvideo', {'id': id});
    if (response.result) {
      return (response.data['data'] as List)
          .map((e) =>
              VideoModel(id: e['vid'].toString(), coverUrl: e['coverUrl']))
          .toList();
    }
    return List.empty();
  }

  ///通过mlog获取视频ID
  static Future<String> mlogToVideo(String id) async {
    final response = await httpManager.get('/mlog/to/video', {'id': id});
    return response.data['data'].toString();
  }
}
