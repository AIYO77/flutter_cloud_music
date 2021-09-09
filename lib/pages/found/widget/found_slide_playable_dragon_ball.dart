import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/widget/element_title_widget.dart';
import 'package:get/get.dart';

class FoundSlideGragonBall extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  final Size coverSize = Size(Adapt.px(95), Adapt.px(95));

  FoundSlideGragonBall(this.blocks, {required this.itemHeight});

  Widget _buildItem(CreativeModel model) {
    return SizedBox(
      width: coverSize.width,
      child: Column(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                  model.uiElement?.image?.imageUrl ?? '', coverSize),
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
                      width: Adapt.px(26),
                      height: Adapt.px(30),
                      color: Colours.white.withOpacity(0.85),
                    )
                  ],
                );
              },
            ),
          ),
          Gaps.vGap10,
          Text(
            model.uiElement?.mainTitle?.title ?? '',
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
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.gap_dp6),
        ),
      ),
      child: Column(
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildItem(blocks.creatives!.elementAt(index));
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap20;
                  },
                  itemCount: blocks.creatives?.length ?? 0))
        ],
      ),
    );
  }
}
