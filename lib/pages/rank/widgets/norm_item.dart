import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/rank_item_model.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../common/res/gaps.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/image_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/5/6 5:20 下午
/// Des:

class RankNormItemWidget extends StatelessWidget {
  final RankItemModel itemModel;
  final double imageSize;
  final int maxLines;

  const RankNormItemWidget(
      {required this.itemModel, required this.imageSize, this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PLAYLIST_DETAIL_ID(itemModel.id.toString()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: ImageUtils.getImageUrlFromSize(itemModel.coverImgUrl,
                Size(Dimens.gap_dp100, Dimens.gap_dp100)),
            placeholder: placeholderWidget,
            errorWidget: errorWidget,
            // width: Dimens.gap_dp96,
            height: imageSize + Dimens.gap_dp4,
            imageBuilder: (context, image) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Dimens.gap_dp4,
                    width: (imageSize + Dimens.gap_dp4) * 0.77,
                    decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? Colors.white.withOpacity(0.05)
                            : Colours.color_242,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimens.gap_dp4),
                            topRight: Radius.circular(Dimens.gap_dp4))),
                  ),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp7)),
                    child: Stack(
                      children: [
                        Image(
                          image: image,
                          height: imageSize,
                          fit: BoxFit.fitHeight,
                        ),
                        Positioned(
                          top: Dimens.gap_dp4,
                          right: Dimens.gap_dp4,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Dimens.gap_dp1,
                              bottom: Dimens.gap_dp1,
                              left: Dimens.gap_dp6,
                              right: Dimens.gap_dp6,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                    BorderRadius.circular(Dimens.gap_dp20)),
                            alignment: Alignment.center,
                            child: Text(
                              itemModel.updateFrequency,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: Dimens.font_sp10),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          Gaps.vGap8,
          Text(
            itemModel.name,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: body1Style(),
          )
        ],
      ),
    );
  }
}
