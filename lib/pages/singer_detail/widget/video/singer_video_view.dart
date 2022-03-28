import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/singer_videos_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/time.dart';
import 'package:flutter_cloud_music/pages/found/model/shuffle_log_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/video/singer_video_controller.dart';
import 'package:flutter_cloud_music/pages/video/state.dart';
import 'package:flutter_cloud_music/pages/video/view.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/footer_loading.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/21 2:22 下午
/// Des:

class SingerVideoView extends StatelessWidget {
  final int id;

  SingerVideoView(this.id);

  late SingerVideoController controller;

  @override
  Widget build(BuildContext context) {
    controller = GetInstance().putOrFind(() => SingerVideoController(id));
    return controller.obx(
      (state) {
        controller.refreshController.refreshCompleted();
        if (state?.page.more == true) {
          controller.refreshController.loadComplete();
        } else {
          controller.refreshController.loadNoData();
        }
        return SmartRefresher(
          controller: controller.refreshController,
          footer: FooterLoading(
            noMoreTxt: '',
          ),
          onLoading: () async {
            controller.loadMore();
          },
          onRefresh: () async {
            controller.refreshData();
          },
          enablePullUp: true,
          enablePullDown: false,
          child: _buildContent(state?.records),
        );
      },
      onEmpty: const Text("empty"),
      onError: (err) {
        Get.log('refresh error $err');
        toast(err.toString());
        controller.refreshController.refreshFailed();
        return Gaps.empty;
      },
      onLoading: _buildLoading(controller.state?.records == null),
    );
  }

  Widget _buildContent(List<Records>? records) {
    return ListView.separated(
      padding: EdgeInsets.only(top: Dimens.gap_dp16),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = records!.elementAt(index);
        return Bounce(
          onPressed: () {
            final list = records
                .map((e) => VideoModel(
                      id: e.resource.mlogBaseData.id,
                      resource: e.resource,
                    ))
                .toList();
            VideoPage.startWithOffset(list, 'path', {}, index: index);
          },
          child: _buildItem(item),
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap12;
      },
      itemCount: records?.length ?? 0,
    );
  }

  Widget _buildItem(Records item) {
    return Container(
      height: Dimens.gap_dp84,
      width: Adapt.screenW(),
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.gap_dp10),
            ),
            child: CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                  item.resource.mlogBaseData.coverUrl,
                  Size(Dimens.gap_dp150, Dimens.gap_dp84)),
              width: Dimens.gap_dp150,
              placeholder: placeholderWidget,
              imageBuilder: (context, image) {
                return Container(
                  height: Dimens.gap_dp84,
                  width: Dimens.gap_dp150,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Image(
                        image: image,
                        fit: BoxFit.fitWidth,
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
                                right: Dimens.gap_dp8, bottom: Dimens.gap_dp8),
                            child: Text(
                              getTimeStamp(item.resource.mlogBaseData.duration),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimens.font_sp10),
                            ),
                          ))
                    ],
                  ),
                );
              },
            ),
          ),
          Gaps.hGap8,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              item.resource.mlogBaseData.buildNameView(),
              Gaps.vGap6,
              Text(
                millFormat(item.resource.mlogBaseData.pubTime),
                style: captionStyle(),
              ),
              Gaps.vGap3,
              Text(
                '${getPlayCountStrFromInt(item.resource.mlogExtVO.playCount ?? 0)}播放',
                style: captionStyle(),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildLoading(bool needShow) {
    if (needShow) {
      return Container(
        margin: EdgeInsets.only(top: Adapt.px(50)),
        child: MusicLoading(
          axis: Axis.horizontal,
        ),
      );
    } else {
      return Gaps.empty;
    }
  }
}
