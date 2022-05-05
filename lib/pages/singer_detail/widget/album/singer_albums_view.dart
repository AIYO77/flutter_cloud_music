import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/singer_albums_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/album/singer_albums_controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/18 4:47 下午
/// Des:歌手专辑列表

class SingerAlbumsView extends StatelessWidget {
  final int id;

  SingerAlbumsView(this.id);

  late SingerAlbumsController controller;

  @override
  Widget build(BuildContext context) {
    controller = GetInstance().putOrFind(() => SingerAlbumsController(id));
    return controller.obx(
      (state) {
        controller.refreshController.refreshCompleted();
        if (state?.more == true) {
          controller.refreshController.loadComplete();
        } else {
          controller.refreshController.loadNoData();
        }
        return SmartRefresher(
          controller: controller.refreshController,
          onLoading: () async {
            controller.loadMore();
          },
          onRefresh: () async {
            controller.refreshData();
          },
          enablePullUp: true,
          enablePullDown: false,
          child: _buildContent(state?.hotAlbums),
        );
      },
      onEmpty: const Text("empty"),
      onError: (err) {
        Get.log('refresh error $err');
        toast(err.toString());
        controller.refreshController.refreshFailed();
        return Gaps.empty;
      },
      onLoading: _buildLoading(controller.state?.hotAlbums == null),
    );
  }

  Widget _buildContent(List<HotAlbums>? hotAlbums) {
    return ListView.separated(
      padding: EdgeInsets.only(top: Dimens.gap_dp16),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final album = hotAlbums!.elementAt(index);
        return Bounce(
          onPressed: () {
            Get.toNamed(Routes.ALBUM_DETAIL_ID(album.id.toString()));
          },
          child: _buildItem(album),
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.vGap14;
      },
      itemCount: hotAlbums?.length ?? 0,
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

  Widget _buildItem(HotAlbums album) {
    return Container(
      height: Dimens.gap_dp66,
      width: Adapt.screenW(),
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      child: Row(
        children: [
          //logo
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageUtils.getImagePath('ck5'),
                height: Dimens.gap_dp8,
                width: Dimens.gap_dp48,
                fit: BoxFit.fill,
              ),
              ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
                child: CachedNetworkImage(
                  imageUrl: ImageUtils.getImageUrlFromSize(
                      album.picUrl, Size(Dimens.gap_dp60, Dimens.gap_dp60)),
                  width: Dimens.gap_dp58,
                  height: Dimens.gap_dp58,
                  placeholder: placeholderWidget,
                ),
              )
            ],
          ),
          Gaps.hGap10,
          //title
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                album.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: headlineStyle().copyWith(fontWeight: FontWeight.w500),
              ),
              Gaps.vGap5,
              Text(
                '${album.getPublishTimeStr()} ${album.size}首',
                style: captionStyle(),
              )
            ],
          ))
        ],
      ),
    );
  }
}
