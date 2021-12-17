import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/new_song_tag_model.dart';
import 'package:get/get.dart';

class NewSongListView extends StatelessWidget {
  final NewSongTagModel tagModel;

  const NewSongListView(Key key, {required this.tagModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildHeader(),
        ),
        SliverToBoxAdapter(
          child: _buildPlayAll(0),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Image.asset(
          tagModel.imgPath,
          fit: BoxFit.fitWidth,
          width: Adapt.screenW(),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: Adapt.screenW(),
              height: Dimens.gap_dp15,
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colours.dark_bg_color : Colors.white,
                  // color: Colors.amber,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.gap_dp20),
                      topRight: Radius.circular(Dimens.gap_dp20))),
              // child: ,
            ))
      ],
    );
  }

  Widget _buildPlayAll(int count) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // color: Colours.blue,
        padding: EdgeInsets.only(left: Dimens.gap_dp10),
        child: Row(
          children: [
            Image.asset(
              ImageUtils.getImagePath('btn_play'),
              color: headlineStyle().color,
              width: Dimens.gap_dp28,
              height: Dimens.gap_dp28,
            ),
            Gaps.hGap4,
            RichText(
                text: TextSpan(text: '播放全部', style: headlineStyle(), children: [
              WidgetSpan(child: Gaps.hGap5),
              TextSpan(
                  text: '($count)',
                  style: TextStyle(
                      fontSize: Dimens.font_sp12,
                      color: Colours.color_150.withOpacity(0.8)))
            ])),
          ],
        ),
      ),
    );
  }
}
