import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cloud_music/common/physics/auicker_physics.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/video/controller/video_list_controller.dart';
import 'package:flutter_cloud_music/pages/video/widget/video_content.dart';
import 'package:flutter_cloud_music/pages/video/widget/video_right_buttons.dart';
import 'package:flutter_cloud_music/pages/video/widget/video_scaffold.dart';
import 'package:flutter_cloud_music/pages/video/widget/video_user_info.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../common/res/gaps.dart';
import '../../routes/app_routes.dart';
import 'logic.dart';
import 'state.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();

  ///固定的列表，不需要无限加载
  static void startWithList(List<VideoModel> list, {int index = 0}) {
    Get.toNamed(Routes.VIDEO_PLAY, arguments: {
      'type': VideoState.TYPE_LIST,
      'data': list,
      'index': index
    });
  }

  ///单个视频，无限获取相似推荐
  static void startWithSingle(VideoModel video) {
    Get.toNamed(Routes.VIDEO_PLAY,
        arguments: {'type': VideoState.TYPE_SINGLE, 'data': video});
  }

  ///分页列表
  static void startWithOffset(List<VideoModel> list, {int index = 0}) {
    Get.toNamed(Routes.VIDEO_PLAY, arguments: {
      'type': VideoState.TYPE_OFFSET,
      'data': list,
      'index': index,
    });
  }
}

class _VideoPageState extends State<VideoPage> {
  final logic = Get.find<VideoLogic>();
  final VideoState state = Get.find<VideoLogic>().videoState;

  @override
  void initState() {
    state.videoListController.addListener(_listener);

    state.videoController.addListener(() {
      if (state.videoController.value == VideoPagePosition.middle) {
        state.videoListController.currentPlayer.play();
      } else {
        state.videoListController.currentPlayer.pause();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    state.videoListController.removeListener(_listener);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    logger.i('didChangeDependencies');
    super.didChangeDependencies();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: VideoScaffold(
        controller: state.videoController,
        header: _buildHeader(),
        rightPage: Container(),
        enableGesture: true,
        page: PageView.builder(
          key: const Key('video'),
          physics: const QuickerScrollPhysics(),
          controller: state.pageController,
          scrollDirection: Axis.vertical,
          itemCount: state.videoListController.videoCount,
          itemBuilder: (context, index) {
            final player = state.videoListController.playerOfIndex(index);
            final rightButtons = VideoRightButtons(
              controller: player,
              onComment: () {
                logic.showComment(player!.videoModel.id, false);
              },
              onFavorite: () {
                logic.addFavorite(player!.videoModel.id, unalterable: false);
              },
            );
            // video
            final content = player?.controllerValue == null
                ? Center(
                    child: _buildCover(player),
                  )
                : Center(
                    child: AspectRatio(
                      aspectRatio: player!.controllerValue!.value.aspectRatio,
                      child: VideoPlayer(player.controllerValue!),
                    ),
                  );
            //userInfo
            final userInfo = VideoUserInfoWidget(player!);
            return VideoContent(
              videoController: player,
              video: content,
              isBuffering: player.controllerValue?.value.isBuffering ?? true,
              rightButtonColumn: rightButtons,
              userInfoWidget: userInfo,
              onSingleTap: () async {
                if (player.controllerValue != null) {
                  if (player.controllerValue!.value.isPlaying) {
                    await player.pause();
                  } else {
                    await player.play();
                  }
                  setState(() {});
                }
              },
              onAddFavorite: () {
                logic.addFavorite(player.videoModel.id);
              },
              onCommentTap: () {
                logic.showComment(player.videoModel.id, true);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp14),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.back();
            },
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: Colors.white,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
          const Expanded(child: Gaps.empty),
          IconButton(
            onPressed: () async {},
            icon: Image.asset(
              ImageUtils.getImagePath('cb'),
              color: Colors.white,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCover(VPVideoController? player) {
    return CachedNetworkImage(
      imageUrl: player?.videoModel.coverUrl ??
          player?.videoModel.resource?.mlogBaseData.coverUrl ??
          '',
      width: Adapt.screenW(),
      fit: BoxFit.fitWidth,
      placeholder: (context, url) {
        return Image.asset(
          ImageUtils.getImagePath('img_defult_video'),
          width: Adapt.screenW(),
          fit: BoxFit.fitWidth,
        );
      },
      errorWidget: (context, url, e) {
        return Image.asset(
          ImageUtils.getImagePath('img_defult_video'),
          width: Adapt.screenW(),
          fit: BoxFit.fitWidth,
        );
      },
    );
  }
}
