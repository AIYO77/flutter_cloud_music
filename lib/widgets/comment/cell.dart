import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/time.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/user_avatar.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/11 8:16 下午
/// Des: 评论cell

class CommentCell extends StatefulWidget {
  final Comment comment;
  final ParamSingleCallback<Comment>? replayCall;
  final String resourceId;
  final int resourceType;

  const CommentCell(
    Key? key, {
    required this.comment,
    this.replayCall,
    required this.resourceId,
    required this.resourceType,
  }) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CommentCell> {
  late bool isLiked;

  @override
  void initState() {
    isLiked = widget.comment.liked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        afterLogin(() {});
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.only(left: Dimens.gap_dp16, top: Dimens.gap_dp9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                toUserDetail(accountId: widget.comment.user.userId);
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: Dimens.gap_dp36 * 1.2,
                    height: Dimens.gap_dp36,
                    alignment: Alignment.center,
                    child: UserAvatar(
                      avatar: widget.comment.user.avatarUrl,
                      size: Dimens.gap_dp36,
                      identityIconUrl:
                          widget.comment.user.avatarDetail?.identityIconUrl,
                    ),
                  ),
                  Gaps.hGap3,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.comment.user.nickname,
                        style: TextStyle(
                            color: headline2Style().color!.withOpacity(0.7),
                            fontSize: Dimens.font_sp13),
                      ),
                      Gaps.vGap5,
                      Text(
                        getCommentTimeStr(widget.comment.time),
                        style: TextStyle(
                            color: Colours.subtitle_color,
                            fontSize: Dimens.font_sp10),
                      )
                    ],
                  )),
                  //like
                  GestureDetector(
                    onTap: () {
                      afterLogin(() {
                        _likeComment(widget.comment.commentId, isLiked);
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Text.rich(
                      TextSpan(children: [
                        if (widget.comment.likedCount > 0)
                          TextSpan(
                            text:
                                getCommentStrFromInt(widget.comment.likedCount),
                            style: TextStyle(
                                color: isLiked
                                    ? Colours.app_main_light
                                    : Colours.subtitle_color,
                                fontSize: Dimens.font_sp10),
                          ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageUtils.getImagePath(
                                isLiked ? 'event_liked' : 'even_like'),
                            color: isLiked
                                ? null
                                : context.isDarkMode
                                    ? Colors.white70
                                    : Colours.color_128,
                            width: Dimens.gap_dp32,
                          ),
                        )
                      ]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.hGap5,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp45,
                  top: Dimens.gap_dp7,
                  bottom: Dimens.gap_dp9,
                  right: Dimens.gap_dp16),
              child: Text(
                widget.comment.content,
                style: headline2Style().copyWith(
                    fontSize: Dimens.font_sp14, fontWeight: FontWeight.normal),
              ),
            ),
            if (!GetUtils.isNullOrBlank(
                widget.comment.showFloorComment?.comments)!)
              GestureDetector(
                onTap: () {
                  widget.replayCall?.call(widget.comment);
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                      left: Dimens.gap_dp45, right: Dimens.gap_dp16),
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp10,
                      right: Dimens.gap_dp10,
                      top: Dimens.gap_dp11,
                      bottom: Dimens.gap_dp11),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.gap_dp8),
                      color: context.isDarkMode
                          ? Colors.white12
                          : Colours.color_242),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildReplay(widget.comment.showFloorComment!),
                  ),
                ),
              ),
            if (widget.comment.showFloorComment?.showReplyCount == true &&
                GetUtils.isNullOrBlank(
                    widget.comment.showFloorComment?.comments)!)
              GestureDetector(
                onTap: () {
                  widget.replayCall?.call(widget.comment);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: Dimens.gap_dp45),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text:
                            '${widget.comment.showFloorComment!.replyCount}条回复',
                        style: TextStyle(
                            color: context.theme.highlightColor,
                            fontSize: Dimens.font_sp13)),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.asset(
                          ImageUtils.getImagePath(
                            'icon_more',
                          ),
                          color: context.theme.highlightColor,
                          height: Dimens.gap_dp13,
                        ))
                  ])),
                ),
              ),
            Padding(
              padding:
                  EdgeInsets.only(left: Dimens.gap_dp45, top: Dimens.gap_dp12),
              child: Gaps.line,
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildReplay(ShowFloorComment floorComment) {
    final widgets = List<Widget>.empty(growable: true);
    for (final replied in floorComment.comments!) {
      widgets.add(Text.rich(TextSpan(children: [
        TextSpan(
          text: replied.user.nickname,
          style: TextStyle(
              color: Get.theme.highlightColor, fontSize: Dimens.font_sp14),
        ),
        TextSpan(
            text: '：${replied.content}',
            style: headline2Style().copyWith(fontSize: Dimens.font_sp14))
      ])));
      widgets.add(Gaps.vGap4);
    }
    if (floorComment.showReplyCount) {
      widgets.add(Padding(
          padding: EdgeInsets.only(top: Dimens.gap_dp10),
          child: Text.rich(
            TextSpan(children: [
              TextSpan(
                  text: '${floorComment.replyCount}条回复',
                  style: TextStyle(
                      color: Get.theme.highlightColor,
                      fontSize: Dimens.font_sp13)),
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Image.asset(
                    ImageUtils.getImagePath(
                      'icon_more',
                    ),
                    color: Get.theme.highlightColor,
                    height: Dimens.gap_dp13,
                  ))
            ]),
          )));
    }
    return widgets;
  }

  Future _likeComment(int commentId, bool liked) async {
    setState(() {
      isLiked = !isLiked;
    });
    final result = await MusicApi.likeComment(
        id: widget.resourceId,
        type: widget.resourceType,
        cid: commentId,
        t: liked ? 0 : 1);
    if (result) {
      //操作成功
      widget.comment.liked = !liked;
    } else {
      //操作失败 返回之前的状态
      setState(() {
        isLiked = !isLiked;
      });
    }
  }
}
