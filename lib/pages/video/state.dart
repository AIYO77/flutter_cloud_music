import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/found/model/shuffle_log_model.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';
import 'package:flutter_cloud_music/pages/video/widget/video_scaffold.dart';
import 'package:get/get.dart';

class VideoState {
  static const String TYPE_LIST = 'type_list';
  static const String TYPE_SINGLE = 'type_single';
  static const String TYPE_OFFSET = 'type_offset';

  //分页需要
  String? loadMorePath;
  Map<String, dynamic>? loadMoreParams;

  ///点赞集合
  final favoriteIds = Rx<List<String>?>(null);

  late String type;

  late VideoScaffoldController videoController;

  late PageController pageController;

  late VideoListController videoListController;

  VideoState() {
    videoController = VideoScaffoldController();
    videoListController = VideoListController(preloadCount: 2);
  }
}

class VideoModel {
  final String id;

  final String? coverUrl;

  final MLogResource? resource;

  const VideoModel({required this.id, this.coverUrl, this.resource});

  @override
  String toString() {
    return 'VideoModel{id: $id, coverUrl: $coverUrl, resource: $resource}';
  }
}
