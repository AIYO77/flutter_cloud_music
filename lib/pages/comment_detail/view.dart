import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/album_detail.dart';
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/comment_detail/controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:flutter_cloud_music/widgets/comment/comment.dart';
import 'package:flutter_cloud_music/widgets/comment/floor/floor_comment.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/15 3:47 下午
/// Des: 评论详情

class CommentDetailPage extends StatefulWidget {
  static void startSong(Song song) {
    Get.toNamed(Routes.COMMENT_DETAIL, arguments: song);
  }

  static void startAlbum(Album album) {
    Get.toNamed(Routes.COMMENT_DETAIL, arguments: album);
  }

  static void startPlayList(Playlist playlist) {
    Get.toNamed(Routes.COMMENT_DETAIL, arguments: playlist);
  }

  @override
  _State createState() => _State();
}

class _State extends State<CommentDetailPage> {
  /// bottomSheet嵌套scrollview 下拉关闭事件冲突 用下面的方式解决
  final _streamController = StreamController<double>.broadcast();
  final _totalHeight = Adapt.screenH() - Adapt.topPadding() - Dimens.gap_dp44;
  double _pointerDy = 0;
  final _scrollController = ScrollController();

  final controller = Get.put(CommentDetailController(),
      tag: Get.arguments.hashCode.toString());

  int commentTotal = 0;

  @override
  void initState() {
    super.initState();
    controller.commentController.totalCount.listen((total) {
      setState(() {
        commentTotal = total ?? 0;
      });
    });
  }

  Widget _buildSheet(BuildContext context, Comment comment) {
    return StreamBuilder<double>(
        stream: _streamController.stream,
        initialData: _totalHeight,
        builder: (context, snapshot) {
          final currentHeight = snapshot.data ?? _totalHeight;
          return AnimatedContainer(
              duration: const Duration(milliseconds: 30),
              height: currentHeight,
              child: Listener(
                onPointerMove: (event) {
                  // 触摸事件过程 手指一直在屏幕上且发生距离滑动
                  if (_scrollController.offset != 0) {
                    return;
                  }
                  final distance = event.position.dy - _pointerDy;
                  if (distance.abs() > 0) {
                    // 获取手指滑动的距离，计算弹框实时高度，并发送事件
                    final _currentHeight = _totalHeight - distance;
                    if (_currentHeight > _totalHeight) {
                      return;
                    }
                    _streamController.sink.add(_currentHeight);
                  }
                },
                onPointerUp: (event) {
                  // 触摸事件结束 手指离开屏幕
                  // 这里认为滑动超过一半就认为用户要退出了，值可以根据实际体验修改
                  if (currentHeight < (_totalHeight * 0.5)) {
                    Navigator.pop(context);
                  } else {
                    _streamController.sink.add(_totalHeight);
                  }
                },
                onPointerDown: (event) {
                  // 触摸事件开始 手指开始接触屏幕
                  _pointerDy = event.position.dy + _scrollController.offset;
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimens.gap_dp20),
                      topLeft: Radius.circular(Dimens.gap_dp20)),
                  child: FloorCommentWidget(
                      parentComment: comment,
                      scrollController: _scrollController,
                      resId: controller.resId,
                      type: controller.type),
                ),
              ));
        });
  }

  Widget buildHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: context.theme.cardColor,
          width: double.infinity,
          padding: EdgeInsets.only(
              left: Dimens.gap_dp16,
              bottom: Dimens.gap_dp10,
              top: Dimens.gap_dp10,
              right: Dimens.gap_dp16),
          child: controller.getTypeHeader(),
        ),
        Container(
          color: context.theme.scaffoldBackgroundColor,
          width: double.infinity,
          height: Dimens.gap_dp8,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: MyAppBar(
        centerTitle: '评论($commentTotal)',
      ),
      body: CommentPage(
        controller: controller.commentController,
        headerWidget: buildHeader(context),
        showTotalCount: false,
        replayCall: (comment) {
          Get.bottomSheet(
            _buildSheet(context, comment),
            isScrollControlled: true,
            backgroundColor: context.theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimens.gap_dp20),
                  topLeft: Radius.circular(Dimens.gap_dp20)),
            ),
          );
        },
      ),
    );
  }
}
