import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/widgets/comment/cell.dart';
import 'package:flutter_cloud_music/widgets/comment/floor/floor_controller.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/14 11:40 上午
/// Des: 楼层评论

class FloorCommentWidget extends StatelessWidget {
  late FloorController controller;
  final Comment parentComment;
  final String resId;
  final int type;
  final VoidCallback? backCall;
  final ScrollController? scrollController;

  FloorCommentWidget(
      {required this.parentComment,
      required this.resId,
      required this.type,
      this.backCall,
      this.scrollController});

  @override
  Widget build(BuildContext context) {
    controller = GetInstance().putOrFind(
        () => FloorController(parentComment.commentId.toString(), resId, type),
        tag: parentComment.commentId.toString());
    return Column(
      children: [
        AppBar(
          toolbarHeight: Dimens.gap_dp44,
          elevation: 0,
          title: Obx(() => Text('回复(${controller.totalCount.value})')),
          centerTitle: true,
          backgroundColor: context.theme.cardColor,
          leading: backCall != null
              ? IconButton(
                  onPressed: backCall,
                  padding: const EdgeInsets.only(left: 12.0),
                  icon: Image.asset(
                    ImageUtils.getImagePath('dij'),
                    color: context.theme.appBarTheme.titleTextStyle?.color,
                    width: Dimens.gap_dp25,
                    height: Dimens.gap_dp25,
                  ),
                )
              : null,
        ),
        Expanded(
            child: CustomScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: context.theme.scaffoldBackgroundColor,
                width: double.infinity,
                padding: EdgeInsets.only(bottom: Dimens.gap_dp8),
                child:
                    Obx(() => controller.floorModel.value?.ownerComment == null
                        ? Gaps.empty
                        : Container(
                            width: double.infinity,
                            color: context.theme.cardColor,
                            child: CommentCell(
                                Key(controller
                                    .floorModel.value!.ownerComment.commentId
                                    .toString()),
                                comment:
                                    controller.floorModel.value!.ownerComment),
                          )),
              ),
            ),
            Obx(() => SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  final data = controller.headerList.value.elementAt(index);
                  return StickyHeader(
                      header: Container(
                        width: double.infinity,
                        height: Dimens.gap_dp30,
                        color: context.theme.cardColor,
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                        child: Row(
                          children: [
                            Text(
                              data.header,
                              style: headlineStyle()
                                  .copyWith(fontSize: Dimens.font_sp12),
                            ),
                            const Expanded(child: Gaps.empty),
                            // if (data.header == allReplay) GestureDetector(),
                          ],
                        ),
                      ),
                      content: data.comments.isEmpty
                          ? MusicLoading()
                          : Column(
                              children: List<Widget>.from(data.comments.map(
                                  (e) => CommentCell(
                                      Key(e.commentId.toString()),
                                      comment: e)))
                                ..add(data.header == bestReplay
                                    ? Container(
                                        height: Dimens.gap_dp8,
                                        width: double.infinity,
                                        color: context
                                            .theme.scaffoldBackgroundColor,
                                      )
                                    : Gaps.empty),
                            ));
                }, childCount: controller.headerList.value.length)))
          ],
        ))
      ],
    );
  }
}
