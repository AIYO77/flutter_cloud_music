/*
 * @Author: XingWei 
 * @Date: 2021-08-19 11:03:18 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-08-20 20:54:47
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/ui_element_model.dart'
    hide ElementImage;
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

import 'element_button_widget.dart';

class ElementTitleWidget extends StatelessWidget {
  final UiElementModel elementModel;

  const ElementTitleWidget({required this.elementModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: Dimens.gap_dp5),
        height: Dimens.gap_dp48,
        margin: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!GetUtils.isNull(elementModel.subTitle))
              Expanded(
                  child: Row(
                children: [
                  if (GetUtils.isNullOrBlank(
                          elementModel.subTitle!.titleImgUrl) !=
                      true)
                    Wrap(
                      children: [
                        CachedNetworkImage(
                          imageUrl: elementModel.subTitle!.titleImgUrl!,
                          color: headlineStyle().color,
                          width: Adapt.px(18),
                          height: Adapt.px(18),
                        ),
                        Gaps.hGap4
                      ],
                    ),
                  SizedBox(
                    width: Adapt.px(240),
                    child: Text(
                      elementModel.subTitle!.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: headlineStyle(),
                    ),
                  )
                ],
              )),
            if (!GetUtils.isNull(elementModel.button))
              Expanded(flex: 0, child: elementButtonWidget(elementModel.button))
          ],
        ));
  }
}
