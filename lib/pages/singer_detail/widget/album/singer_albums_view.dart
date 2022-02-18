import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/singer_albums_model.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/album/singer_albums_controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/footer_loading.dart';
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
          footer: const FooterLoading(
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
    return ListView.builder(
      itemBuilder: (context, index) {
        final album = hotAlbums!.elementAt(index);
        return Bounce(
          onPressed: () {
            Get.toNamed(Routes.ALBUM_DETAIL_ID(album.id.toString()));
          },
          //TODO
          child: Container(),
        );
      },
      itemCount: hotAlbums?.length ?? 0,
    );
  }

  Widget _buildLoading(bool needShow) {
    if (needShow) {
      return Container(
        margin: EdgeInsets.only(top: Adapt.px(100)),
        child: MusicLoading(
          axis: Axis.horizontal,
        ),
      );
    } else {
      return Gaps.empty;
    }
  }
}
