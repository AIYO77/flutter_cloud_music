import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:flutter_cloud_music/pages/found/widget/element_title_widget.dart';
import 'package:flutter_cloud_music/widgets/general_song_two.dart';
import 'package:get/get.dart';

class FoundSlideSongListAlign extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  const FoundSlideSongListAlign(this.blocks, {required this.itemHeight});

  @override
  Widget build(BuildContext context) {
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
                  songInfo: FoundNewSong.fromJson(element.resourceExtInfo)
                      .buildSong(element.action),
                  uiElementModel: element.uiElement),
            )
          ],
        ),
      ));
    }
    return widgets;
  }
}
