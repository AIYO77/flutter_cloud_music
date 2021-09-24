import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/widget/element_button_widget.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:get/get.dart';

class FoundTabMlogWidget extends StatelessWidget {
  final List<CreativeModel> creatives;
  final double itemHeight;

  FoundTabMlogWidget(
      {Key? key, required this.creatives, required this.itemHeight})
      : super(key: key);

  //当前选中的tab
  final curSelectedIndex = 0.obs;

  final Size coverSize = Size(Adapt.px(95), Adapt.px(95));

  final List<Widget> tabs = List.empty(growable: true);

  Widget _buildItem(Resources model) {
    return SizedBox(
      width: coverSize.width,
      child: GestureDetector(
        onTap: () {
          RouteUtils.routeFromActionStr(model.action);
        },
        child: Column(
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: ImageUtils.getImageUrlFromSize(
                    model.uiElement.image?.imageUrl ?? '', coverSize),
                imageBuilder: (context, provider) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(
                        image: provider,
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                          child: Container(
                        color: Colors.black.withOpacity(0.3),
                      )),
                      Image.asset(
                        ImageUtils.getImagePath('icon_play_small'),
                        width: Adapt.px(36),
                        height: Adapt.px(40),
                        color: Colours.white.withOpacity(0.85),
                      )
                    ],
                  );
                },
              ),
            ),
            Gaps.vGap10,
            Text(
              model.uiElement.mainTitle?.title ?? '',
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: captionStyle(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabLayout() {
    return Container(
      height: Dimens.gap_dp48,
      padding: EdgeInsets.only(
          left: Dimens.gap_dp15, right: Dimens.gap_dp15, top: Dimens.gap_dp5),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Row(
              children: tabs,
            ),
          ),
          Positioned(
            right: 0,
            child: Obx(() => elementButtonWidget(
                creatives.elementAt(curSelectedIndex.value).uiElement?.button)),
          )
        ],
      ),
    );
  }

  void initData() {
    if (tabs.isNotEmpty) tabs.clear();
    for (var i = 0; i < creatives.length; i++) {
      final uielement = creatives.elementAt(i).uiElement!;
      tabs.add(Row(
        key: Key("tab_$i"),
        children: [
          if (tabs.isNotEmpty)
            Container(
              width: Dimens.gap_dp1,
              height: Dimens.gap_dp16,
              margin:
                  EdgeInsets.only(left: Dimens.gap_dp8, right: Dimens.gap_dp8),
              color: Get.theme.dividerColor,
            ),
          GestureDetector(
            child: Obx(
              () => Text(
                uielement.mainTitle!.title.toString(),
                style: curSelectedIndex.value == i
                    ? headlineStyle()
                    : headlineStyle().copyWith(
                        color: Get.isDarkMode
                            ? Colors.white.withOpacity(0.6)
                            : const Color.fromARGB(200, 135, 135, 135)),
              ),
            ),
            onTap: () {
              curSelectedIndex.value = i;
            },
          )
        ],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Container(
        height: itemHeight,
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
        ),
        child: Column(
          children: [
            //tab
            _buildTabLayout(),
            //page
            Expanded(
              child: Obx(() => ListView.separated(
                  key: Key('list_${curSelectedIndex.value}'),
                  padding: EdgeInsets.only(
                      top: Dimens.gap_dp6,
                      left: Dimens.gap_dp15,
                      right: Dimens.gap_dp15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final model = creatives
                        .elementAt(curSelectedIndex.value)
                        .resources!
                        .elementAt(index);
                    return _buildItem(model);
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap20;
                  },
                  itemCount: creatives
                          .elementAt(curSelectedIndex.value)
                          .resources
                          ?.length ??
                      0)),
            )
          ],
        ));
  }
}
