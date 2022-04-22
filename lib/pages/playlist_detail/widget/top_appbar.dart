import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/enum/enum.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../../common/utils/adapt.dart';
import '../../../widgets/marquee_on_demand.dart';
import '../playlist_detail_controller.dart';

class PlaylistTopAppbar extends StatefulWidget {
  final double appBarHeight;
  final PlaylistDetailController controller;

  const PlaylistTopAppbar(
      {Key? key, required this.appBarHeight, required this.controller})
      : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PlaylistTopAppbar> {
  PlayListTitleStatus _titleStatus = PlayListTitleStatus.Normal;

  @override
  void initState() {
    super.initState();
    widget.controller.titleStatus.listen((p0) {
      Future.delayed(const Duration(milliseconds: 100)).whenComplete(() {
        setState(() {
          _titleStatus = p0;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.mediaQueryPadding.top),
      height: widget.appBarHeight,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.back();
            },
            padding: EdgeInsets.only(left: Dimens.gap_dp2),
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: Colours.white.withOpacity(0.9),
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
          Expanded(
              child: Center(
            child: Obx(() =>
                _buildTitle(_titleStatus, widget.controller.detail.value)),
          )),
          IconButton(
            onPressed: () {
              if (AuthService.to.isLoggedInValue &&
                  widget.controller.detail.value?.playlist.creator.userId ==
                      AuthService.to.userId) {
                Get.bottomSheet(
                    _buildPlManager(widget.controller.detail.value!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimens.gap_dp14),
                        topRight: Radius.circular(Dimens.gap_dp14),
                      ),
                    ),
                    backgroundColor: context.theme.cardColor,
                    enableDrag: false);
              }
            },
            padding: EdgeInsets.only(left: Dimens.gap_dp2),
            icon: Image.asset(
              ImageUtils.getImagePath('cb'),
              color: Colours.white.withOpacity(0.9),
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(
      PlayListTitleStatus value, PlaylistDetailModel? detailModel) {
    switch (value) {
      case PlayListTitleStatus.Normal:
        return RichText(
            text: TextSpan(children: [
          if (detailModel?.isOfficial() == true)
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Image.asset(
                  ImageUtils.getImagePath('capture_logo'),
                  width: Dimens.gap_dp20,
                  color: Colors.white,
                )),
          TextSpan(
              text: detailModel?.isOfficial() == true
                  ? ' 官方动态歌单'
                  : detailModel?.getTypename(),
              style: TextStyle(
                  fontSize: Dimens.font_sp17,
                  fontWeight: FontWeight.w600,
                  color: Colours.white))
        ]));
      case PlayListTitleStatus.Title:
        return MarqueeOnDemand(
          switchWidth: Adapt.screenW() * 1 / 2,
          text: detailModel?.playlist.name ?? "",
          marqueeBuilder: (context, text, textStyle) => Marquee(
            text: text,
            style: textStyle,
            velocity: 25,
            blankSpace: 30,
          ),
          textBuilder: (context, text, textStyle) => Text(
            text,
            style: textStyle,
          ),
          textStyle: const TextStyle(fontSize: 17, color: Colors.white),
        );
      case PlayListTitleStatus.TitleAndBtn:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: MarqueeOnDemand(
              switchWidth: Adapt.screenW() * 1 / 2,
              text: detailModel?.playlist.name ?? "",
              marqueeBuilder: (context, text, textStyle) => Marquee(
                text: text,
                style: textStyle,
                velocity: 25,
                blankSpace: 30,
              ),
              textBuilder: (context, text, textStyle) => Text(
                text,
                style: textStyle,
              ),
              textStyle: const TextStyle(fontSize: 17, color: Colors.white),
            )),
            Container(
              height: Dimens.gap_dp24,
              margin: EdgeInsets.only(left: Dimens.gap_dp15),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp9),
              decoration: BoxDecoration(
                  color: Colours.app_main_light,
                  borderRadius: BorderRadius.circular(Dimens.gap_dp12)),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: Dimens.font_sp13,
                  ),
                  Text(
                    '收藏',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimens.font_sp12),
                  )
                ],
              ),
            )
          ],
        );
    }
  }

  Widget _buildPlManager(PlaylistDetailModel detailModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCellBox(
            child: Text(
          '${detailModel.getTypename()}:${detailModel.playlist.name}',
          style: captionStyle().copyWith(fontSize: Dimens.font_sp15),
        )),
        Gaps.line,
        GestureDetector(
          onTap: () {
            Get.back();
            if (detailModel.isVideoPl()) {
              Get.toNamed(Routes.ADD_VIDEO,
                  arguments: detailModel.playlist.id.toString());
            } else {
              Get.toNamed(Routes.ADD_SONG,
                  arguments: detailModel.playlist.id.toString());
            }
          },
          behavior: HitTestBehavior.translucent,
          child: _buildCellBox(
              child: Row(
            children: [
              Icon(
                Icons.playlist_add,
                color: context.iconColor?.withOpacity(0.8),
                size: Dimens.gap_dp25,
              ),
              Gaps.hGap8,
              Text(
                detailModel.isVideoPl() ? '添加视频' : '添加歌曲',
                style: body2Style(),
              )
            ],
          )),
        )
      ],
    );
  }

  Widget _buildCellBox({required Widget child}) {
    return Container(
      height: Dimens.gap_dp52,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }
}
