import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/play_queue_with_music.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/general_album_item.dart';
import 'package:flutter_cloud_music/widgets/general_song_one.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

import '../../../common/utils/image_utils.dart';
import 'element_button_widget.dart';

class FoundNewSongAlbum extends StatelessWidget {
  final List<CreativeModel> creatives;

  final double itemHeight;

  final bool bottomRadius;

  PlayQueue? _playQueue;

  FoundNewSongAlbum(this.creatives,
      {required this.itemHeight, required this.bottomRadius});

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
                creative.uiElement!.mainTitle!.title.toString(),
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
          final song = FoundNewSong.fromJson(element.resourceExtInfo)
              .buildSong(element.action);
          childView = GeneralSongOne(
            songInfo: song,
            uiElementModel: element.uiElement,
            onPressed: () {
              if (_playQueue == null) {
                final listMusic = List<MusicMetadata>.empty(growable: true);
                for (final creative in creatives) {
                  if (creative.creativeType == 'NEW_SONG_HOMEPAGE') {
                    creative.resources?.forEach((resource) {
                      listMusic.add(
                          FoundNewSong.fromJson(resource.resourceExtInfo)
                              .buildSong(null)
                              .metadata);
                    });
                  }
                }
                _playQueue = PlayQueue(
                    queueId: 'NEW_SONG_HOMEPAGE',
                    queueTitle: '新歌',
                    queue: listMusic);
              }
              RouteUtils.routeFromActionStr(element.action,
                  data: PlayQueueWithMusic(
                      playQueue: _playQueue!, music: song.metadata));
            },
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
        case 'voice':
          //热门博客
          childView = _buildVoice(element);
          break;
        case 'voiceList':
          //有声书
          childView = _buildVoice(element, isVoice: false);
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

  Widget _buildVoice(Resources resources, {bool isVoice = true}) {
    final uiElement = resources.uiElement;
    return Bounce(
        onPressed: () {
          RouteUtils.routeFromActionStr(resources.action);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.gap_dp10),
              child: CachedNetworkImage(
                imageUrl: uiElement.image?.imageUrl ?? '',
                width: Dimens.gap_dp50,
                height: Dimens.gap_dp50,
                placeholder: placeholderWidget,
                errorWidget: errorWidget,
                imageBuilder: (context, provider) {
                  return Stack(
                    children: [
                      Positioned.fill(
                          child: Image(
                        image: provider,
                        fit: BoxFit.cover,
                      )),
                      if (isVoice)
                        Positioned(
                          right: Dimens.gap_dp2,
                          bottom: Dimens.gap_dp2,
                          child: Image.asset(
                            ImageUtils.getImagePath('icon_play_small'),
                            width: Dimens.gap_dp20,
                            height: Dimens.gap_dp20,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
            Gaps.hGap10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    uiElement.mainTitle?.title ?? '',
                    style: headline1Style(),
                  ),
                  Gaps.vGap4,
                  Row(
                    children: [
                      Container(
                        height: Dimens.gap_dp14,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: Dimens.gap_dp2),
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimens.gap_dp2),
                        decoration: BoxDecoration(
                          color: uiElement.labelType?.toLowerCase() == 'yellow'
                              ? Colors.orange.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(Dimens.gap_dp2),
                          border: uiElement.labelType?.toLowerCase() != 'yellow'
                              ? Border.all(
                                  width: Dimens.gap_dp1,
                                  color: captionStyle().color!.withOpacity(0.4))
                              : null,
                        ),
                        child: Text(
                          uiElement.labelTexts?.join('/') ?? '',
                          style: TextStyle(
                              fontSize: Dimens.font_sp10,
                              color:
                                  uiElement.labelType?.toLowerCase() == 'yellow'
                                      ? Colors.orange
                                      : captionStyle().color!.withOpacity(0.8)),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        uiElement.subTitle?.title ?? '',
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: captionStyle(),
                      ))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
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
              bottomLeft: Radius.circular(bottomRadius ? Dimens.gap_dp10 : 0),
              bottomRight: Radius.circular(bottomRadius ? Dimens.gap_dp10 : 0)),
        ),
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
