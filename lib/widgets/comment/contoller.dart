import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/api/video_api.dart';
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/6 7:39 下午
/// Des:
//评论类型
//REC 不能分页直接请求1000条
//HOT 正常分页
//NEW cursor 值为上一条数据的 time
enum CommentType {
  REC, //推荐
  HOT, //最热
  NEW //最新
}

class CommentController extends GetxController {
  late RefreshController refreshController;
  late ScrollController scrollController;

  final comments = Rx<List<Comment>?>(null);

  //默认推荐
  final commentType = Rx<CommentType>(CommentType.REC);

  final String id;
  final int type;

  //如果 type==RESOURCE_MLOG 需要吧ID转换成videoID
  String? mVideoId;

  //第几页
  int pageNo = 1;

  int? totalCount;

  CommentController({required this.id, required this.type});

  @override
  void onInit() {
    refreshController = RefreshController();
    scrollController = ScrollController();
    super.onInit();
    commentType.listen((type) {
      _onRefresh(type);
    });
  }

  @override
  void onReady() {
    super.onReady();
    _onRefresh(commentType.value);
  }

  Future<void> _onRefresh(CommentType commentType) async {
    pageNo = 1;
    comments.value = null;
    if (RESOURCE_MLOG == type && mVideoId == null) {
      mVideoId = await VideoApi.mlogToVideo(id);
    }
    MusicApi.getResourceComment(
            id: mVideoId ?? id,
            type: mVideoId == null ? type : RESOURCE_VIDEO,
            pageNo: pageNo,
            sortType: commentType.index + 1,
            pageSize: commentType == CommentType.REC ? 1000 : 20)
        .then((value) {
      totalCount = value?.totalCount;
      comments.value = value?.comments;
      if (commentType != CommentType.REC) {
        if (value?.hasMore == true) {
          refreshController.loadComplete();
        } else {
          if (value?.hasMore != null) {
            refreshController.loadNoData();
          }
        }
      }
    });
  }

  Future<void> onLoadMore() async {
    if (commentType.value == CommentType.REC || comments.value == null) {
      //推荐不分页
      return;
    }
    if (RESOURCE_MLOG == type && mVideoId == null) {
      mVideoId = await VideoApi.mlogToVideo(id);
    }
    pageNo++;
    MusicApi.getResourceComment(
            id: mVideoId ?? id,
            type: mVideoId == null ? type : RESOURCE_VIDEO,
            pageNo: pageNo,
            sortType: commentType.value.index + 1,
            cursor: commentType.value == CommentType.NEW
                ? comments.value?.last.time.toString()
                : null)
        .then((value) {
      if (value?.comments != null) {
        final oldList = comments.value!;
        oldList.addAll(value!.comments);
        comments.value = List.of(oldList);
      }
      if (value?.hasMore == true) {
        refreshController.loadComplete();
      } else {
        if (value?.hasMore != null) {
          refreshController.loadNoData();
        }
      }
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
