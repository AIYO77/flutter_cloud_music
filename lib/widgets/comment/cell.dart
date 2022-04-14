import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/comment_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/time.dart';
import 'package:flutter_cloud_music/widgets/user_avatar.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/11 8:16 下午
/// Des: 评论cell

class CommentCell extends StatelessWidget {
  final Comment comment;

  const CommentCell(Key? key, {required this.comment}) : super(key: key);

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
                toUserDetail(accountId: comment.user.userId);
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UserAvatar(
                    avatar: comment.user.avatarUrl,
                    size: Dimens.gap_dp36,
                    identityIconUrl: comment.user.avatarDetail?.identityIconUrl,
                  ),
                  Gaps.hGap9,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        comment.user.nickname,
                        style: TextStyle(
                            color: headline2Style().color!.withOpacity(0.7),
                            fontSize: Dimens.font_sp14),
                      ),
                      Gaps.vGap5,
                      Text(
                        getCommentTimeStr(comment.time),
                        style: TextStyle(
                            color: Colours.subtitle_color,
                            fontSize: Dimens.font_sp10),
                      )
                    ],
                  )),
                  //like
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: Text.rich(
                      TextSpan(children: [
                        if (comment.likedCount > 0)
                          TextSpan(
                            text: getCommentStrFromInt(comment.likedCount),
                            style: TextStyle(
                                color: comment.liked
                                    ? Colours.app_main_light
                                    : Colours.subtitle_color,
                                fontSize: Dimens.font_sp10),
                          ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageUtils.getImagePath(
                                comment.liked ? 'event_liked' : 'even_like'),
                            color: comment.liked
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
                comment.content,
                style: headline2Style(),
              ),
            ),
            if (!GetUtils.isNullOrBlank(comment.showFloorComment.comments)!)
              GestureDetector(
                onTap: () {},
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
                          : Colours.color_248),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildReplay(comment.showFloorComment),
                  ),
                ),
              ),
            if (comment.showFloorComment.showReplyCount &&
                GetUtils.isNullOrBlank(comment.showFloorComment.comments)!)
              Padding(
                padding: EdgeInsets.only(left: Dimens.gap_dp45),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: '${comment.showFloorComment.replyCount}条回复',
                      style: TextStyle(
                          color: Colours.blue_dark,
                          fontSize: Dimens.font_sp13)),
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Image.asset(
                        ImageUtils.getImagePath(
                          'icon_more',
                        ),
                        color: Colours.blue_dark,
                        height: Dimens.gap_dp13,
                      ))
                ])),
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
          style:
              TextStyle(color: Colours.blue_dark, fontSize: Dimens.font_sp14),
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
                      color: Colours.blue_dark, fontSize: Dimens.font_sp13)),
              WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Image.asset(
                    ImageUtils.getImagePath(
                      'icon_more',
                    ),
                    color: Colours.blue_dark,
                    height: Dimens.gap_dp13,
                  ))
            ]),
          )));
    }
    return widgets;
  }
}
