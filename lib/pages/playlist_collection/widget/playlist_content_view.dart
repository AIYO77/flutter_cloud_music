import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/simple_play_list_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/widget/playlist_content_controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/footer_loading.dart';
import 'package:flutter_cloud_music/widgets/generral_cover_playcount.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class PlayListContentView extends StatelessWidget {
  late PlayListContentController controller;

  final PlayListTagModel tagModel;

  final Key? mkey;

  PlayListContentView({this.mkey, required this.tagModel}) : super(key: mkey);

  final refreshController = RefreshController();

  Widget _buildContent(List<SimplePlayListModel>? datas) {
    if (tagModel.name == '精品') {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: Dimens.gap_dp10,
                  left: Dimens.gap_dp15,
                  right: Dimens.gap_dp15),
              height: Dimens.gap_dp48,
              child: _buildFiltter(),
            ),
          ),
          SliverPadding(
            padding:
                EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = datas!.elementAt(index);
                return _buildItem(item);
              }, childCount: datas?.length ?? 0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: Dimens.gap_dp10,
                  crossAxisSpacing: Dimens.gap_dp9,
                  childAspectRatio: 0.69),
            ),
          ),
        ],
      );
    } else {
      return _buildListView(datas);
    }
  }

  Widget _buildListView(List<SimplePlayListModel>? datas) {
    return GridView.builder(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp15, right: Dimens.gap_dp15, top: Dimens.gap_dp12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: Dimens.gap_dp10,
          crossAxisSpacing: Dimens.gap_dp9,
          childAspectRatio: 0.69),
      itemBuilder: (context, index) {
        final item = datas!.elementAt(index);
        return _buildItem(item);
      },
      itemCount: datas?.length,
    );
  }

  //通用item
  Widget _buildItem(SimplePlayListModel item) {
    return Bounce(
      onPressed: () {
        Get.toNamed(Routes.PLAYLIST_DETAIL_ID(item.id.toString()));
      },
      child: Column(
        children: [
          GenrralCoverPlayCount(
            imageUrl: item.getCoverUrl(),
            playCount: item.playCount,
            coverSize: Size(Dimens.gap_dp109, Dimens.gap_dp108),
            coverRadius: 10.0,
            rightTopTagIcon:
                tagModel.name == '精品' ? ImageUtils.getImagePath('c_k') : null,
          ),
          Gaps.vGap6,
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: body1Style(),
          )
        ],
      ),
    );
  }

  //精品列表筛选
  Widget _buildFiltter() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => Text(
                controller.cat.value ?? '全部精品',
                style: body1Style(),
              )),
        ),
        GestureDetector(
          onTap: () {
            if (controller.highqualityTags == null || controller.requesting) {
              return;
            }
            Get.bottomSheet(
                SizedBox(
                    height: Adapt.screenH() * 0.6,
                    child: Stack(
                      children: [
                        _buildFilterContent(),
                        Positioned(
                            top: Dimens.gap_dp16,
                            right: Dimens.gap_dp16,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: Dimens.gap_dp26,
                                height: Dimens.gap_dp26,
                                decoration: BoxDecoration(
                                    color: Get.isDarkMode
                                        ? Colors.white.withOpacity(0.2)
                                        : const Color.fromARGB(
                                            140, 229, 229, 229),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Dimens.gap_dp13))),
                                child: Center(
                                  child: Image.asset(
                                    ImageUtils.getImagePath('brx'),
                                    color: body1Style().color,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    )),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimens.gap_dp8),
                        topLeft: Radius.circular(Dimens.gap_dp8))),
                backgroundColor: Get.theme.cardColor,
                enableDrag: false);
          },
          child: Container(
            padding: EdgeInsets.all(Dimens.gap_dp10),
            child: RichText(
                text: TextSpan(children: [
              WidgetSpan(
                  child: Image.asset(
                ImageUtils.getImagePath('cf'),
                width: Dimens.gap_dp15,
                color: body1Style().color,
              )),
              TextSpan(text: '筛选', style: body1Style())
            ])),
          ),
        )
      ],
    );
  }

  Widget _buildFilterContent() {
    return Column(
      children: [
        Gaps.vGap16,
        Text(
          '所有精品歌单',
          style: body1Style().copyWith(
              fontSize: Dimens.font_sp18, fontWeight: FontWeight.w500),
        ),
        Gaps.vGap20,
        Expanded(
            child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Container(
              margin: EdgeInsets.only(
                  left: Dimens.gap_dp15, right: Dimens.gap_dp15),
              child: _buildFilterItem(null),
            )),
            SliverPadding(
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp15,
                  bottom: Dimens.gap_bottom_play_height,
                  right: Dimens.gap_dp15,
                  top: Dimens.gap_dp20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.highqualityTags!.elementAt(index);
                  return _buildFilterItem(item);
                }, childCount: controller.highqualityTags?.length ?? 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: Dimens.gap_dp20,
                    crossAxisSpacing: Dimens.gap_dp9,
                    childAspectRatio: 78 / 40),
              ),
            )
          ],
        ))
      ],
    );
  }

  Widget _buildFilterItem(String? label) {
    return Obx(() {
      final isSelected = label == null
          ? controller.cat.value == null
          : controller.cat.value == label;
      return GestureDetector(
        onTap: () {
          controller.cat.value = label;
          controller.refreshData();
          Get.back();
        },
        child: Container(
          height: Dimens.gap_dp40,
          padding: EdgeInsets.only(left: Dimens.gap_dp9, right: Dimens.gap_dp9),
          decoration: BoxDecoration(
              color: _getLabelBgColor(isSelected),
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp20))),
          child: Center(
            child: Text(
              label ?? '全部精品',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: isSelected
                  ? body1Style().copyWith(
                      fontSize: Dimens.font_sp14,
                      color:
                          Get.isDarkMode ? Colours.white_dark : Colours.white)
                  : body1Style().copyWith(fontSize: Dimens.font_sp14),
            ),
          ),
        ),
      );
    });
  }

  Color _getLabelBgColor(bool isSelected) {
    if (isSelected) {
      //选中
      if (Get.isDarkMode) {
        return Colours.btn_selectd_color_dark;
      } else {
        return Colours.btn_selectd_color;
      }
    } else {
      if (Get.isDarkMode) {
        return Colours.label_bg_dark;
      } else {
        return Colours.label_bg;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(PlayListContentController(), tag: mkey.toString());
    controller.tagModel = tagModel;
    return controller.obx(
      (state) {
        refreshController.refreshCompleted();
        if ((state?.totalCount ?? 0) > state!.datas.length) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
        return Container(
            color: Get.theme.cardColor,
            child: SmartRefresher(
              controller: refreshController,
              footer: const FooterLoading(
                noMoreTxt: "暂无更多歌单",
              ),
              onLoading: () async {
                controller.loadMore();
              },
              onRefresh: () async {
                controller.refreshData();
              },
              enablePullUp: true,
              enablePullDown: false,
              child: _buildContent(state.datas),
            ));
      },
      onEmpty: const Text("empty"),
      onError: (err) {
        Get.log('refresh error $err');
        toast(err.toString());
        refreshController.refreshFailed();
        return Gaps.empty;
      },
      onLoading: _buildLoading(controller.state?.datas == null),
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
