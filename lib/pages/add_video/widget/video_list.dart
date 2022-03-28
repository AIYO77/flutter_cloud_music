import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/add_video/widget/video_list_controller.dart';
import 'package:flutter_cloud_music/pages/found/model/shuffle_log_model.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';

import '../../../common/res/gaps.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/time.dart';
import '../logic.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/16 11:11 上午
/// Des:

class AddVideoListView extends StatelessWidget {
  final String tag;
  late AddVideoController controller;

  final _pController = GetInstance().find<AddVideoLogic>();

  AddVideoListView(this.tag) : super(key: Key(tag)) {
    controller =
        GetInstance().putOrFind(() => AddVideoController(tag), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.videos.value == null
        ? Padding(
            padding: EdgeInsets.only(top: Dimens.gap_dp50),
            child: MusicLoading(
              axis: Axis.horizontal,
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
            itemBuilder: (context, index) {
              final video = controller.videos.value!.elementAt(index);
              return _item(video);
            },
            separatorBuilder: (context, index) {
              return Gaps.vGap5;
            },
            itemCount: controller.videos.value!.length,
          ));
  }

  Widget _item(MLogResource video) {
    return GestureDetector(
      onTap: () {
        _pController.addVideoToPl(video.mlogBaseData.id);
      },
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
          height: Dimens.gap_dp61,
          width: double.infinity,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  toast('play');
                },
                behavior: HitTestBehavior.translucent,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp5)),
                  child: CachedNetworkImage(
                    imageUrl: video.mlogBaseData.coverUrl,
                    placeholder: placeholderWidget,
                    errorWidget: errorWidget,
                    height: Dimens.gap_dp51,
                    width: Dimens.gap_dp75,
                    imageBuilder: (context, image) {
                      return Container(
                        height: Dimens.gap_dp84,
                        width: Dimens.gap_dp150,
                        color: Colors.black,
                        child: Stack(
                          children: [
                            Image(
                              image: image,
                              height: Dimens.gap_dp51,
                              width: Dimens.gap_dp75,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: Dimens.gap_dp30,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                        Colors.transparent,
                                        Colors.black38
                                      ])),
                                  alignment: Alignment.bottomRight,
                                  padding: EdgeInsets.only(
                                      right: Dimens.gap_dp3,
                                      bottom: Dimens.gap_dp3),
                                  child: Text(
                                    getTimeStamp(video.mlogBaseData.duration),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimens.font_sp9),
                                  ),
                                )),
                            Center(
                              child: Image.asset(
                                ImageUtils.getImagePath('icon_play_small'),
                                color: Colors.white70,
                                width: Dimens.gap_dp28,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Gaps.hGap10,
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  video.mlogBaseData.buildNameView(maxLine: 1),
                  Gaps.vGap2,
                  Text(
                    video.mlogExtVO.song?.getArString() ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: captionStyle().copyWith(fontSize: Dimens.font_sp12),
                  )
                ],
              )),
            ],
          )),
    );
  }
}
