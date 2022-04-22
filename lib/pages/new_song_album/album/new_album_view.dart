import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/album_cover_info.dart';
import 'package:flutter_cloud_music/common/model/top_album_cover_info.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/new_song_album/album/new_album_controller.dart';
import 'package:flutter_cloud_music/pages/new_song_album/album/top_album_model.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

class NewAlbumPage extends GetView<NewAlbumController> {
  @override
  NewAlbumController get controller =>
      GetInstance().putOrFind(() => NewAlbumController());

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) {
      if (GetUtils.isNullOrBlank(controller.newAlbums) == true ||
          GetUtils.isNullOrBlank(state) == true) {
        return MusicLoading(
          axis: Axis.horizontal,
        );
      } else {
        controller.refreshController ??= RefreshController();
        controller.refreshController!.refreshCompleted();
        if (GetUtils.isNullOrBlank(state) == true) {
          controller.refreshController!.loadNoData();
        } else {
          controller.refreshController!.loadComplete();
        }
        return SmartRefresher(
          controller: controller.refreshController!,
          footer: CustomFooter(builder: (context, mode) {
            Widget body;
            if (mode == LoadStatus.idle || mode == LoadStatus.loading) {
              //加载状态
              body = MusicLoading(
                axis: Axis.horizontal,
              );
            } else if (mode == LoadStatus.failed) {
              //加载数据失败
              body = Text(
                "加载失败，稍后重试",
                style: body1Style().copyWith(fontSize: Dimens.font_sp14),
              );
            } else {
              //没有数据
              body = Text(
                "暂无更多专辑",
                style: body1Style().copyWith(fontSize: Dimens.font_sp14),
              );
            }
            return Container(
              width: Adapt.screenW(),
              height: Dimens.gap_dp105,
              padding: EdgeInsets.only(bottom: Dimens.gap_dp50),
              child: Center(child: body),
            );
          }),
          onLoading: () async {
            controller.loadMore();
          },
          enablePullUp: true,
          enablePullDown: false,
          child: _buildListContent(context, controller.newAlbums!, state!),
        );
      }
    },
        onLoading: Container(
          margin: EdgeInsets.only(top: Dimens.gap_dp105),
          child: MusicLoading(
            axis: Axis.horizontal,
          ),
        ));
  }

  Widget _buildListContent(BuildContext context, List<AlbumCoverInfo> list,
      List<TopAlbumModel> state) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildTopAlbum(list),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                color: Get.theme.scaffoldBackgroundColor,
                width: Adapt.screenW(),
                height: Dimens.gap_dp8,
              ),
              Container(
                color: Get.theme.cardColor,
                width: Adapt.screenW(),
                height: Dimens.gap_dp8,
              ),
            ],
          ),
        ),
        SliverExpandableList(
            builder:
                SliverExpandableChildDelegate<TopAlbumCoverInfo, TopAlbumModel>(
                    sectionList: state,
                    sectionBuilder: _buildSection,
                    itemBuilder: (context, sectionIndex, itemIndex, index) {
                      final item =
                          state[sectionIndex].getItems().elementAt(itemIndex);
                      return _buildItem(item);
                    })),
        //pading bottom
        SliverToBoxAdapter(
          child: padingBottomBox(),
        )
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, ExpandableSectionContainerInfo containerInfo) {
    containerInfo
      ..header = _buildHeader(context, containerInfo)
      ..content = _buildContent(context, containerInfo);
    return ExpandableSectionContainer(
      info: containerInfo,
    );
  }

  Widget _buildHeader(
      BuildContext context, ExpandableSectionContainerInfo containerInfo) {
    final section = controller.state![containerInfo.sectionIndex];
    return Container(
      color: Get.theme.cardColor,
      height: Dimens.gap_dp38,
      padding: EdgeInsets.only(left: Dimens.gap_dp16, top: Dimens.gap_dp5),
      alignment: Alignment.centerLeft,
      child: section.label != null
          ? Text(
              section.label!,
              style: headlineStyle(),
            )
          : RichText(
              text: TextSpan(
                text: '${section.dateTime?.month}月',
                style: headlineStyle(),
                children: [
                  TextSpan(
                      text: ' /${section.dateTime?.year}',
                      style:
                          captionStyle().copyWith(fontSize: Dimens.font_sp15))
                ],
              ),
            ),
    );
  }

  Widget? _buildContent(
      BuildContext context, ExpandableSectionContainerInfo containerInfo) {
    return Container(
      color: Get.theme.cardColor,
      padding: EdgeInsets.symmetric(
          horizontal: Dimens.gap_dp15, vertical: Dimens.gap_dp8),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: Dimens.gap_dp26,
          crossAxisSpacing: Dimens.gap_dp15,
          childAspectRatio: 0.9,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: containerInfo.childDelegate!.builder as Widget Function(
            BuildContext, int),
        itemCount: containerInfo.childDelegate!.childCount,
      ),
    );
  }

  Widget _buildTopAlbum(List<AlbumCoverInfo> list) {
    final url = box.read<String>(CACHE_ALBUM_POLY_DETAIL_URL);
    return Container(
      color: Get.theme.cardColor,
      width: Adapt.screenW(),
      height: Dimens.gap_dp240,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                '数字专辑',
                textAlign: TextAlign.start,
                style: headlineStyle(),
              )),
              if (GetUtils.isNullOrBlank(url) != true)
                MaterialButton(
                    focusElevation: 0,
                    color: Colors.transparent,
                    highlightColor: Get.theme.hintColor,
                    elevation: 0,
                    height: Dimens.gap_dp26,
                    padding: const EdgeInsets.all(0),
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.gap_dp13),
                        side: BorderSide(
                          color: Get.theme.hintColor,
                        )),
                    child: SizedBox(
                      height: Dimens.gap_dp26,
                      width: Dimens.gap_dp105,
                      child: Center(
                        child: Text(
                          '更多热销专辑',
                          style: captionStyle()
                              .copyWith(fontSize: Dimens.font_sp14),
                        ),
                      ),
                    ),
                    onPressed: () {
                      RouteUtils.routeFromActionStr(url);
                    }),
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(top: Dimens.gap_dp10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Dimens.gap_dp10,
                childAspectRatio: 0.67,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = list.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    //
                    Get.toNamed(
                        "${Routes.WEB}?url=https://music.163.com/octave/m/album/detail?id=${item.albumId}");
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        ImageUtils.getImagePath('cqb'),
                        width: Dimens.gap_dp108,
                        height: Dimens.gap_dp10,
                        fit: BoxFit.fill,
                      ),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                        child: CachedNetworkImage(
                          imageUrl: ImageUtils.getImageUrlFromSize(
                            item.coverUrl,
                            Size(Dimens.gap_dp140, Dimens.gap_dp140),
                          ),
                          height: Dimens.gap_dp108,
                          placeholder: (context, url) {
                            return Container(
                              color: Colours.load_image_placeholder(),
                            );
                          },
                        ),
                      ),
                      Gaps.vGap6,
                      Text(
                        item.albumName,
                        style:
                            body1Style().copyWith(fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(item.artistName,
                          style: captionStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis)
                    ],
                  ),
                );
              },
              itemCount: list.length,
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildItem(TopAlbumCoverInfo item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ALBUM_DETAIL_ID(item.id.toString()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                ImageUtils.getImagePath(GetPlatform.isAndroid
                    ? 'ic_cover_alb_android'
                    : 'ic_cover_alb_ios'),
                width: Dimens.gap_dp164,
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp6)),
                    child: CachedNetworkImage(
                      height: Adapt.px(142),
                      imageUrl: ImageUtils.getImageUrlFromSize(
                        item.picUrl,
                        Size(Dimens.gap_dp140, Dimens.gap_dp140),
                      ),
                      placeholder: (context, url) {
                        return Container(
                          color: Colours.load_image_placeholder(),
                        );
                      },
                    ),
                  ))
            ],
          ),
          Gaps.vGap5,
          Text(
            item.getAlbumName(),
            style: body1Style().copyWith(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          // Gaps.vGap4,
          Text(item.getArName(),
              style: captionStyle(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
          // Text(data)
        ],
      ),
    );
  }
}
