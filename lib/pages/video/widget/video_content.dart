import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/pages/video/widget/video_gesture.dart';
import 'package:get/get.dart';

import '../controller/video_list_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/28 11:00 上午
/// Des: 覆盖在video上的一些元素和操作

class VideoContent extends StatelessWidget {
  final VPVideoController videoController;

  final Widget video;
  final bool isBuffering;
  final Widget rightButtonColumn;
  final Widget userInfoWidget;

  final Function? onAddFavorite;
  final Function? onSingleTap;
  final Function? onCommentTap;

  const VideoContent({
    Key? key,
    required this.videoController,
    required this.video,
    required this.rightButtonColumn,
    required this.userInfoWidget,
    this.onCommentTap,
    this.isBuffering = true,
    this.onAddFavorite,
    this.onSingleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 视频播放页
    final videoContainer = Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          alignment: Alignment.center,
          child: video,
        ),
        VideoGesture(
          onAddFavorite: onAddFavorite,
          onSingleTap: onSingleTap,
          child: Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Obx(() => videoController.showPauseIcon.value && !isBuffering
            ? IgnorePointer(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    size: 120,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              )
            : Gaps.empty)
      ],
    );
    final body = Container(
        color: Colors.black,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          child: Column(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  videoContainer,
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomRight,
                    child: rightButtonColumn,
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.bottomLeft,
                    child: userInfoWidget,
                  ),
                  if (isBuffering)
                    const Center(
                      child: CircularProgressIndicator(
                        color: Colours.app_main_light,
                      ),
                    )
                ],
              )),
              GestureDetector(
                onTap: () {
                  onCommentTap?.call();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: double.infinity,
                  height: Dimens.gap_dp49,
                  padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '千言万语，汇成评论一句',
                        style: TextStyle(
                            color: Colors.white30, fontSize: Dimens.font_sp14),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
    return body;
  }
}
