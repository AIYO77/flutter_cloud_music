import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/ui_element_model.dart'
    hide ElementImage;
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:get/get.dart';
import 'package:keframe/frame_separate_widget.dart';
// import 'package:palette_generator/palette_generator.dart';

import 'element_title_widget.dart';

class FoundSliedPlaylist extends StatelessWidget {
  final UiElementModel uiElementModel;
  final List<CreativeModel> creatives;
  final int curIndex;
  final double itemHeight;

  const FoundSliedPlaylist(
      {required this.uiElementModel,
      required this.creatives,
      required this.curIndex,
      required this.itemHeight});

  Widget _buildItem(CreativeModel model, ThemeData thme) {
    if (GetUtils.isNullOrBlank(model.resources) == true) return Gaps.empty;
    final resource = model.resources![0];
    final extInfo = ResourceExtInfoModel.fromJson(resource.resourceExtInfo);
    return SizedBox(
      width: Dimens.gap_dp109,
      child: Column(
        children: [
          //突出的背景
          Container(
            height: Dimens.gap_dp4,
            margin:
                EdgeInsets.only(left: Dimens.gap_dp12, right: Dimens.gap_dp12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.gap_dp12),
                  topRight: Radius.circular(Dimens.gap_dp12)),
            ),
          ),
          //图片
          CachedNetworkImage(
            width: Dimens.gap_dp105,
            height: Dimens.gap_dp105,
            placeholder: (context, url) {
              return Container(
                color: Colours.load_image_placeholder,
              );
            },
            imageUrl: ImageUtils.getImageUrlFromSize(
                resource.uiElement.image?.imageUrl,
                Size(Dimens.gap_dp105, Dimens.gap_dp105)),
            imageBuilder: (image, provider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.gap_dp10),
                child: Stack(
                  children: [
                    Image(
                      image: provider,
                      fit: BoxFit.cover,
                    ),
                    //额外的样式 播放量等
                    _buildExtWidget(extInfo, provider),
                  ],
                ),
              );
            },
          ),
          Gaps.vGap5,
          //标题
          Text(
            resource.uiElement.mainTitle?.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: captionStyle(),
          )
        ],
      ),
    );
  }

  Widget _buildExtWidget(ResourceExtInfoModel extInfo, ImageProvider provider) {
    switch (extInfo.specialType) {
      case 200:
        // 视频封面渐变
        return Positioned.fill(
            child: Stack(
          children: [
            //模糊背景
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(),
            ),

            //播放量 不需要背景
            _buildPlaycountWidget(extInfo.playCount, provider, needBg: false),

            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.gap_dp5),
                    child: Image(
                      image: provider,
                      width: Adapt.px(90),
                      height: Adapt.px(64),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Image.asset(
                    ImageUtils.getImagePath('xkd'),
                    width: Adapt.px(90),
                    height: Adapt.px(64),
                    fit: BoxFit.fill,
                  )
                ],
              ),
            )
          ],
        ));
      case 300:
        if (GetUtils.isNullOrBlank(extInfo.users) == false) {
          final userInfo = extInfo.users![0];
          return Positioned.fill(
            child: Stack(
              children: [
                _buildPlaycountWidget(extInfo.playCount, provider),
                Positioned(
                  right: Dimens.gap_dp3,
                  bottom: Dimens.gap_dp3,
                  child: _buildUser(userInfo),
                )
              ],
            ),
          );
        }
    }
    //只有播放量
    return _buildPlaycountWidget(extInfo.playCount, provider);
  }

  Widget _buildUser(userInfo) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colours.white.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8))),
          width: Dimens.gap_dp15,
          height: Dimens.gap_dp15,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimens.gap_dp3),
          decoration: BoxDecoration(
              color: Colours.white.withOpacity(0.6),
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8))),
          width: Dimens.gap_dp15,
          height: Dimens.gap_dp15,
        ),
        CachedNetworkImage(
          imageUrl: userInfo.avatarUrl,
          imageBuilder: (context, provider) {
            return ClipOval(
              child: Container(
                margin: EdgeInsets.only(left: Dimens.gap_dp6),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colours.white, width: Dimens.gap_dp1)),
                child: Image(
                  image: provider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildPlaycountWidget(int count, ImageProvider<Object> provider,
      {bool needBg = true}) {
    if (needBg) {
      return Positioned(
          right: Dimens.gap_dp4,
          top: Dimens.gap_dp4,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.gap_dp8),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp7, right: Dimens.gap_dp7),
                height: Dimens.gap_dp16,
                color: Colors.black.withOpacity(0.2),
                child: _playcount(count),
              ),
            ),
          ));
    } else {
      return Positioned(
          right: Dimens.gap_dp4,
          top: Dimens.gap_dp4,
          child: Container(
            padding:
                EdgeInsets.only(left: Dimens.gap_dp7, right: Dimens.gap_dp7),
            height: Dimens.gap_dp16,
            child: _playcount(count),
          ));
    }
  }

  Widget _playcount(int count) {
    return Row(
      children: [
        Image.asset(
          ImageUtils.getImagePath('icon_playcount'),
          width: Dimens.gap_dp8,
          height: Dimens.gap_dp8,
        ),
        Gaps.hGap1,
        Text(
          getPlayCountStrFromInt(count),
          style: TextStyle(
              color: Colors.white.withOpacity(0.9), fontSize: Dimens.font_sp10),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final thme = Get.theme;
    return Container(
        decoration: BoxDecoration(
            color: thme.cardColor,
            borderRadius: BorderRadius.only(
                //第三个item 上边的圆角保留
                topLeft: curIndex == 2
                    ? const Radius.circular(0)
                    : Radius.circular(Dimens.gap_dp10),
                topRight: curIndex == 2
                    ? const Radius.circular(0)
                    : Radius.circular(Dimens.gap_dp10),
                bottomLeft: Radius.circular(Dimens.gap_dp10),
                bottomRight: Radius.circular(Dimens.gap_dp10))),
        child: SizedBox(
          height: itemHeight,
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: ElementTitleWidget(
                  elementModel: uiElementModel,
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                  itemBuilder: (context, index) {
                    final model = creatives[index];
                    return FrameSeparateWidget(
                      index: index,
                      placeHolder: SizedBox(
                        width: Dimens.gap_dp109,
                        height: Dimens.gap_dp109,
                      ),
                      child: _buildItem(model, thme),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap9;
                  },
                  itemCount: creatives.length,
                ),
              ),
            ],
          ),
        ));
  }
}
