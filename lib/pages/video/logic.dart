import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/video_api.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../common/utils/common_utils.dart';
import '../../common/values/constants.dart';
import 'controller/video_list_controller.dart';
import 'state.dart';

class VideoLogic extends GetxController with WidgetsBindingObserver {
  final videoState = VideoState();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addObserver(this);
    final arguments = Get.arguments;
    _initArguments(arguments);
    _requestFavoriteIds();
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
    videoState.videoListController.currentPlayer.pause();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      videoState.videoListController.currentPlayer.pause();
    }
  }

  void _initArguments(dynamic arguments) {
    videoState.type = arguments['type'].toString();
    List<VideoModel> data = List.empty();
    int index = 0;
    switch (videoState.type) {
      case VideoState.TYPE_LIST:
        data = (arguments['data'] as List).cast<VideoModel>();
        index = arguments['index'] as int;
        break;
      case VideoState.TYPE_SINGLE:
        data = [arguments['data'] as VideoModel];
        break;
      case VideoState.TYPE_OFFSET:
        data = (arguments['data'] as List).cast<VideoModel>();
        index = arguments['index'] as int;
        videoState.loadMorePath = arguments['path'].toString();
        videoState.loadMoreParams =
            Map<String, dynamic>.from(arguments['params'] as Map);
        break;
    }
    logger.d(data);
    videoState.pageController = PageController(initialPage: index);
    _initVideoController(data, index);
  }

  ///初始化播放器controller
  void _initVideoController(List<VideoModel> data, int index) {
    videoState.videoListController.init(
        pageController: videoState.pageController,
        startIndex: index,
        initialList: data.controllers(),
        videoProvider: (int index, List<VPVideoController> list) async {
          switch (videoState.type) {
            case VideoState.TYPE_SINGLE:
              final lastId = list.last.videoModel.id;
              final data = await VideoApi.getRelatedVideo(lastId);
              return data.controllers();
          }
          return List.empty();
        });
  }

  ///获取视频播放Url
  Future<String> getVideoUrl(VideoModel videoModel) async {
    return VideoApi.getVideoPlayUrl(videoModel.id);
  }

  ///请求点赞过的视频
  Future<void> _requestFavoriteIds() async {
    videoState.favoriteIds.value =
        box.read<List>(CACHE_FAVORITE_VIDEO_IDS)?.cast<String>();
    final list = await VideoApi.getMyLikeVideos();
    final ids = list.map((e) => e.mlogBaseData.id).toList();
    videoState.favoriteIds.value = ids;
    box.write(CACHE_FAVORITE_VIDEO_IDS, ids);
  }
}
