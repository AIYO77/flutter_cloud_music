import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:flutter_cloud_music/widgets/general_album_item.dart';
import 'package:flutter_cloud_music/widgets/general_song_one.dart';
import 'package:get/get.dart';

import 'element_button_widget.dart';

class FoundNewSongAlbum extends StatelessWidget {
// final CounterGetLogic logic = Get.put(CounterGetLogic());

  final List<CreativeModel> creatives;

  final double itemHeight;

  FoundNewSongAlbum(this.creatives, {required this.itemHeight});

  final List<String> types = List.empty(growable: true);
  final List<Widget> tabs = List.empty(growable: true);

  //当前选中的tab
  final curSelectedIndex = 0.obs;

  void initData() {
    final theme = Get.theme;
    if (types.isNotEmpty) types.clear();
    if (tabs.isNotEmpty) tabs.clear();
    for (final element in creatives) {
      if (!types.contains(element.creativeType)) {
        types.add(element.creativeType!);
      }
    }
    for (var i = 0; i < types.length; i++) {
      final creative =
          creatives.firstWhere((e) => e.creativeType == types.elementAt(i));
      final uielement = creative.uiElement!;
      tabs.add(Row(
        key: Key("tab_$i"),
        children: [
          if (tabs.isNotEmpty)
            Container(
              width: Dimens.gap_dp1,
              height: Dimens.gap_dp16,
              margin:
                  EdgeInsets.only(left: Dimens.gap_dp8, right: Dimens.gap_dp8),
              color: theme.dividerColor,
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
            child: Obx(() => elementButtonWidget(creatives
                .firstWhere((element) =>
                    element.creativeType ==
                    types.elementAt(curSelectedIndex.value))
                .uiElement
                ?.button)),
          )
        ],
      ),
    );
  }

  Widget _buildPage(Iterable<CreativeModel> datas) {
    return PageView.builder(
      controller: PageController(viewportFraction: 0.91),
      itemBuilder: (context, index) {
        return Column(
          children: _buildPageItems(datas.elementAt(index).resources!),
        );
      },
      itemCount: datas.length,
    );
  }

  List<Widget> _buildPageItems(List<Resources> resources) {
    if (GetUtils.isNull(resources)) return List.empty();
    final List<Widget> widgets = List.empty(growable: true);
    for (final element in resources) {
      var childView = Gaps.empty;
      switch (element.resourceType) {
        case 'song': //新歌
          childView = GeneralSongOne(
            songInfo: FoundNewSong.fromJson(element.resourceExtInfo)
                .buildSong(element.action),
            uiElementModel: element.uiElement,
          );
          break;
        case 'album': //新碟
        case 'digitalAlbum': //数字专辑
          final list = element.resourceExtInfo['artists'] as List;
          childView = GeneralAlbumItem(
              artists: list.map((e) => Ar.fromJson(e)).toList(),
              uiElementModel: element.uiElement,
              action: element.action!);
          break;
      }
      widgets.add(Container(
        padding: EdgeInsets.only(right: Dimens.gap_dp15),
        child: Column(
          children: [
            if (widgets.isNotEmpty)
              Container(
                margin: EdgeInsets.only(left: Adapt.px(58)),
                child: Gaps.line,
              ),
            SizedBox(
              height: Adapt.px(58),
              child: childView,
            )
          ],
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return Container(
        height: itemHeight,
        decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.gap_dp10),
              topRight: Radius.circular(Dimens.gap_dp10),
            )),
        child: Column(
          children: [
            //tab
            _buildTabLayout(),
            //page
            Expanded(
              child: Obx(() => _buildPage(creatives.where((element) =>
                  element.creativeType ==
                  types.elementAt(curSelectedIndex.value)))),
            )
          ],
        ));
  }
}
