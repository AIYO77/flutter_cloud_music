import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/model/shuffle_log_model.dart';
import 'package:flutter_cloud_music/pages/found/widget/element_title_widget.dart';
import 'package:flutter_cloud_music/widgets/playcount_widget.dart';
import 'package:get/get.dart';

class FoundShuffleMLOG extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  const FoundShuffleMLOG({required this.blocks, required this.itemHeight});

  Widget _buildItem(ShuffleLogModel model) {
    final coverSize = Size(Adapt.px(105), Adapt.px(130));
    return SizedBox(
      width: coverSize.width,
      child: Column(
        children: [
          CachedNetworkImage(
            width: coverSize.width,
            height: coverSize.height,
            placeholder: (context, url) {
              return Container(
                color: Colours.load_image_placeholder,
              );
            },
            imageUrl: ImageUtils.getImageUrlFromSize(
                model.resource.mlogBaseData.coverUrl, coverSize),
            imageBuilder: (context, provider) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp6)),
                child: Stack(
                  children: [
                    Image(
                      image: provider,
                      width: coverSize.width,
                      height: coverSize.height,
                      fit: BoxFit.cover,
                    ),
                    //播放量
                    Positioned(
                        right: Dimens.gap_dp4,
                        top: Dimens.gap_dp4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimens.gap_dp8),
                          ),
                          child: PlayCountWidget(
                              playCount: model.resource.mlogExtVO.playCount),
                        )),
                    //播放图标
                    Positioned(
                        right: Dimens.gap_dp8,
                        bottom: Dimens.gap_dp8,
                        child: Container(
                            width: Dimens.gap_dp32,
                            height: Dimens.gap_dp32,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimens.gap_dp16)),
                            ),
                            child: Center(
                              child: Image.asset(
                                ImageUtils.getImagePath('icon_play_small'),
                                width: Dimens.gap_dp17,
                                height: Dimens.gap_dp17,
                                color: Colours.app_main_light,
                              ),
                            )))
                  ],
                ),
              );
            },
          ),
          Gaps.vGap8,
          Text(
            model.resource.mlogBaseData.text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: captionStyle(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listData = blocks.extInfo as List;
    final listItemData =
        listData.map((e) => ShuffleLogModel.fromJson(e)).toList();
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
      ),
      child: Column(
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          Expanded(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                  itemBuilder: (context, index) {
                    return _buildItem(listItemData.elementAt(index));
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap9;
                  },
                  itemCount: listData.length))
        ],
      ),
    );
  }
}
