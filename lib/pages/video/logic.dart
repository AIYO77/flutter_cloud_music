import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/video_api.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/widgets/comment/comment.dart';
import 'package:get/get.dart';

import '../../common/utils/common_utils.dart';
import '../../common/values/constants.dart';
import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../widgets/comment/contoller.dart';
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
    pauseVideo();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    logger.i('didChangeAppLifecycleState $state');
    if (state != AppLifecycleState.resumed) {
      pauseVideo();
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
            case VideoState.TYPE_OFFSET:
              break;
          }
          return List.empty();
        });
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

  ///点赞
  ///unalterable : 不能取消 (双击不能取消)
  Future<void> addFavorite(String id, {bool unalterable = true}) async {
    AuthService.to.isLoggedInValue.yes(() {
      var oldList = videoState.favoriteIds.value;
      oldList ??= List.empty(growable: true);
      if (!unalterable && oldList.contains(id)) {
        //取消点赞
        oldList.remove(id);
        videoState.favoriteIds.value = List.from(oldList);
        VideoApi.likeVideo(id, 0).then((value) {
          if (!value) {
            //取消失败
            oldList!.add(id);
            videoState.favoriteIds.value = List.from(oldList);
          }
        });
      } else {
        //点赞
        if (!oldList.contains(id)) {
          oldList.add(id);
          videoState.favoriteIds.value = List.from(oldList);
          VideoApi.likeVideo(id, 1).then((value) {
            if (!value) {
              //喜欢失败
              oldList!.remove(id);
              videoState.favoriteIds.value = List.from(oldList);
            }
          });
        }
      }
    }).no(() {
      toLogin();
    });
  }

  void showComment(String id, bool toComment) {
    final controller = GetInstance().putOrFind(
        () => CommentController(
            id: id,
            type: id.isMv()
                ? RESOURCE_MV
                : id.isVideo()
                    ? RESOURCE_VIDEO
                    : RESOURCE_MLOG),
        tag: id);
    Get.bottomSheet(
        SizedBox(
          width: double.infinity,
          height: Adapt.screenH() * 0.66,
          child: CommentPage(
            controller: controller,
          ),
        ),
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: Get.theme.cardColor);
  }

  void pauseVideo() {
    videoState.videoListController.currentPlayer.pause();
  }

  void toLogin() {
    pauseVideo();
    Get.toNamed(Routes.LOGIN);
  }
}
