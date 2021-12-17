import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/ui_element_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:get/get.dart';

Widget elementButtonWidget(ElementButton? elementButton,
    {ParamVoidCallback? onPressed}) {
  if (elementButton == null) return Gaps.empty;
  final theme = Get.theme;
  return MaterialButton(
    onPressed: () {
      if (onPressed == null) {
        RouteUtils.routeFromActionStr(elementButton.action);
      } else {
        onPressed.call();
      }
    },
    height: Dimens.gap_dp24,
    color: Colors.transparent,
    highlightColor: theme.highlightColor,
    elevation: 0,
    padding: const EdgeInsets.all(0),
    minWidth: Dimens.gap_dp40,
    focusElevation: 0,
    highlightElevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.gap_dp12),
        side: BorderSide(
          color: theme.highlightColor,
        )),
    child: Row(children: [
      Gaps.hGap12,
      if (elementButton.actionType == "client_customized")
        Image.asset(ImageUtils.getImagePath('icon_play_small'),
            color: theme.iconTheme.color,
            width: Dimens.gap_dp12,
            height: Dimens.gap_dp12),
      Text(
        elementButton.text.toString(),
        style: subtitle1Style().copyWith(fontSize: Dimens.font_sp12),
      ),
      if (elementButton.actionType == APP_ROUTER_TAG)
        Image.asset(ImageUtils.getImagePath('icon_more'),
            color: theme.iconTheme.color,
            width: Dimens.gap_dp12,
            height: Dimens.gap_dp12),
      Gaps.hGap10,
    ]),
  );
}
