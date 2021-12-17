import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/play_queue_with_music.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:flutter_cloud_music/pages/found/widget/element_title_widget.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/widgets/general_song_two.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class FoundSlideSongListAlign extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  late PlayQueue _playQueue;

  FoundSlideSongListAlign(this.blocks, {required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    _playQueue = PlayQueue(
        queueId: blocks.showType,
        queueTitle: blocks.uiElement!.subTitle?.title ?? "",
        queue: blocks.getSongs());
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.gap_dp10),
        ),
      ),
      child: Column(
        children: [
          ElementTitleWidget(
            elementModel: blocks.uiElement!,
            onPressed: () {
              RouteUtils.routeFromActionStr(blocks.uiElement!.button!.action,
                  data: _playQueue);
            },
          ),
          Expanded(
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.91),
                  itemCount: blocks.creatives?.length ?? 0,
                  itemBuilder: (context, index) {
                    final creative = blocks.creatives!.elementAt(index);
                    return Column(
                      children: _buildPageItems(creative),
                    );
                  }))
        ],
      ),
    );
  }

  List<Widget> _buildPageItems(CreativeModel creative) {
    if (creative.resources?.isEmpty == true) return List.empty();
    final List<Widget> widgets = List.empty(growable: true);
    for (final element in creative.resources!) {
      final song = FoundNewSong.fromJson(element.resourceExtInfo)
          .buildSong(element.action);
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
              child: GeneralSongTwo(
                songInfo: song,
                uiElementModel: element.uiElement,
                onPressed: () {
                  //点击歌曲播放列表中的当前歌曲
                  RouteUtils.routeFromActionStr(element.action,
                      data: PlayQueueWithMusic(
                          playQueue: _playQueue, music: song.metadata));
                },
              ),
            )
          ],
        ),
      ));
    }
    return widgets;
  }
}
