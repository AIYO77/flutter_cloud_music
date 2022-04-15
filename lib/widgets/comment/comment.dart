import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/delegate/general_sliver_delegate.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/comment/cell.dart';
import 'package:flutter_cloud_music/widgets/comment/contoller.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/6 7:33 下午
/// Des: 评论通用组件

class CommentPage extends StatelessWidget {
  final CommentController controller;

  // final String id;
  // final int type;
  final ParamSingleCallback<int>? totalCallback;
  final ParamSingleCallback<Comment>? replayCall;
  final Widget? headerWidget;

  const CommentPage(
      {required this.controller,
      this.headerWidget,
      this.totalCallback,
      this.replayCall});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        enablePullDown: false,
        enablePullUp: controller.commentType.value != CommentType.REC,
        controller: controller.refreshController,
        onLoading: () => controller.onLoadMore(),
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            if (headerWidget != null)
              SliverToBoxAdapter(
                child: headerWidget,
              ),
            if (controller.comments.value != null ||
                controller.totalCount != null)
              SliverPersistentHeader(
                pinned: true,
                delegate: GeneralSliverDelegate(
                  child: _buildType(context),
                ),
              ),
            if (controller.comments.value == null)
              _buildLoading(context)
            else
              _buildComments(context, controller.comments.value),
            // SmartRefresher(controller: controller)
          ],
        ),
      ),
    );
  }

  ///推荐 热门 时间
  PreferredSizeWidget _buildType(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Dimens.gap_dp40),
      child: Container(
        color: context.theme.cardColor,
        height: Dimens.gap_dp40,
        child: Row(
          children: [
            Gaps.hGap16,
            if (totalCallback == null)
              Text(
                '评论(${controller.totalCount})',
                style: headline2Style().copyWith(fontSize: Dimens.font_sp14),
              )
            else
              Text(
                '评论区',
                style: headline2Style().copyWith(fontSize: Dimens.font_sp14),
              ),
            const Expanded(child: Gaps.empty),
            _buildTypeAction(context, CommentType.REC),
            Container(
              width: 1,
              height: Dimens.gap_dp14,
              color: headline2Style().color!.withOpacity(0.4),
            ),
            _buildTypeAction(context, CommentType.HOT),
            Container(
              width: 1,
              height: Dimens.gap_dp14,
              color: headline2Style().color!.withOpacity(0.4),
            ),
            _buildTypeAction(context, CommentType.NEW),
            Gaps.hGap8,
          ],
        ),
      ),
    );
  }

  ///评论列表
  Widget _buildComments(BuildContext context, List<Comment>? comments) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      final comment = comments!.elementAt(index);
      return CommentCell(
        Key(comment.commentId.toString()),
        comment: comment,
        replayCall: replayCall,
      );
    }, childCount: comments?.length ?? 0));
  }

  Widget _buildTypeAction(BuildContext context, CommentType type) {
    return GestureDetector(
      onTap: () {
        controller.commentType.value = type;
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: Dimens.gap_dp46,
        height: Dimens.gap_dp40,
        alignment: Alignment.center,
        child: Obx(() => Opacity(
              opacity: controller.commentType.value == type ? 1.0 : 0.4,
              child: Text(
                type == CommentType.REC
                    ? '推荐'
                    : type == CommentType.HOT
                        ? '最热'
                        : '最新',
                style: headline2Style().copyWith(
                    fontSize: Dimens.font_sp13,
                    fontWeight: controller.commentType.value == type
                        ? FontWeight.w600
                        : FontWeight.normal),
              ),
            )),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: context.theme.cardColor,
        width: Adapt.screenW(),
        padding: EdgeInsets.only(top: Dimens.gap_dp52),
        child: MusicLoading(),
      ),
    );
  }
}
