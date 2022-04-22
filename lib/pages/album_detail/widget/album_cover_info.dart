import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/album_detail/album_detail_controller.dart';
import 'package:flutter_cloud_music/widgets/text_button_icon.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AlbumCoverView extends StatelessWidget {
  final AlbumDetailController controller;

  const AlbumCoverView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
            child: CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                  controller.albumDetail.value?.album.picUrl,
                  Size(Dimens.gap_dp140, Dimens.gap_dp140)),
              width: Dimens.gap_dp122,
              height: Dimens.gap_dp122,
              placeholder: (context, url) {
                return Container(
                  color: Colours.load_image_placeholder(),
                );
              },
              errorWidget: (context, url, e) {
                return Container(
                  color: Colours.load_image_placeholder(),
                );
              },
              imageBuilder: (context, image) {
                controller.coverImage.value = image;
                return Image(image: image);
              },
            ),
          ),
          Gaps.hGap14,
          Expanded(
            child: SizedBox(
              height: Adapt.px(122),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  if (controller.albumDetail.value != null)
                    Text(
                      controller.albumDetail.value!.album.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: Dimens.font_sp16,
                          color: Get.isDarkMode
                              ? Colours.white.withOpacity(0.9)
                              : Colours.white),
                    ),
                  //creator
                  Expanded(
                      child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: Dimens.gap_dp12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '歌手：',
                          style: TextStyle(
                              fontSize: Dimens.font_sp13,
                              color: Colours.white.withOpacity(0.7)),
                        ),
                        //creator name
                        if (controller.albumDetail.value != null)
                          SizedBox(
                            height: Dimens.gap_dp18,
                            child: MyTextButtonWithIcon(
                                onPressed: () {
                                  //作者详情
                                  notImplemented(context);
                                },
                                icon: Image.asset(
                                  ImageUtils.getImagePath('icon_more'),
                                  height: Dimens.gap_dp15,
                                  width: Dimens.gap_dp15,
                                  color: Colours.white.withOpacity(0.8),
                                ),
                                axisDirection: AxisDirection.right,
                                gap: Dimens.gap_dp1,
                                label: Text(
                                  controller.albumDetail.value!.album.artist
                                          .name ??
                                      '',
                                  style: TextStyle(
                                      fontSize: Dimens.font_sp13,
                                      color: Colours.white.withOpacity(0.9)),
                                )),
                          )
                      ],
                    ),
                  )),
                  Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        Text(
                          '发行时间：',
                          style: TextStyle(
                              fontSize: Dimens.font_sp12,
                              color: Colours.white.withOpacity(0.7)),
                        ),
                        if (controller.albumDetail.value != null)
                          Text(
                            DateFormat('y-M-d').format(
                                DateTime.fromMillisecondsSinceEpoch(controller
                                    .albumDetail.value!.album.publishTime)),
                            style: TextStyle(
                                fontSize: Dimens.font_sp12,
                                color: Colours.white.withOpacity(0.7)),
                          ),
                      ],
                    ),
                  ),
                  //description
                  Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: Adapt.px(160)),
                            child: Text(
                              //所有的空白和换行 换成默认空白
                              controller.albumDetail.value?.album.description
                                      .replaceAll(
                                          RegExp(r'\s+\b|\b\s|\n'), ' ') ??
                                  '暂无简介',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: Dimens.font_sp12,
                                  color: Colours.white.withOpacity(0.7)),
                            )),
                        Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          height: Dimens.gap_dp13,
                          width: Dimens.gap_dp13,
                          color: Colours.white.withOpacity(0.65),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
