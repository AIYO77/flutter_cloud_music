import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/rank_item_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../routes/app_routes.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/5/6 5:55 下午
/// Des:

class OfficialRank extends StatelessWidget {
  final Color bgColor;
  final List<RankItemModel> items;

  const OfficialRank({required this.bgColor, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          top: Dimens.gap_dp4,
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          bottom: Dimens.gap_dp17),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(Dimens.gap_dp12),
              bottomLeft: Radius.circular(Dimens.gap_dp12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(children: [
            WidgetSpan(
                child: Image.asset(
              ImageUtils.getImagePath('erq'),
              width: Dimens.gap_dp20,
            )),
            WidgetSpan(child: Gaps.hGap5),
            TextSpan(text: '官方榜', style: headlineStyle())
          ])),
          Gaps.vGap2,
          ...items.map((e) => _OfficialCell(Key(e.id.toString()), e)),
        ],
      ),
    );
  }
}

class _OfficialCell extends StatefulWidget {
  final RankItemModel itemModel;

  const _OfficialCell(Key key, this.itemModel) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<_OfficialCell> {
  Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PLAYLIST_DETAIL_ID(widget.itemModel.id.toString()));
      },
      child: Container(
        height: Dimens.gap_dp126,
        margin: EdgeInsets.only(top: Dimens.gap_dp10),
        padding: EdgeInsets.only(
          left: Dimens.gap_dp20,
          top: Dimens.gap_dp8,
          right: Dimens.gap_dp8,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(Dimens.gap_dp12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.itemModel.updateFrequency,
              style: TextStyle(
                  fontSize: Dimens.font_sp10,
                  color: captionStyle().color?.withOpacity(0.5)),
            ),
            Gaps.vGap3,
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl: ImageUtils.getImageUrlFromSize(
                    widget.itemModel.coverImgUrl,
                    Size(Dimens.gap_dp100, Dimens.gap_dp100),
                  ),
                  placeholder: placeholderWidget,
                  errorWidget: errorWidget,
                  height: Dimens.gap_dp90,
                  width: Dimens.gap_dp80,
                  imageBuilder: (context, image) {
                    _getColorFromImage(image);
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.gap_dp7),
                      child: Image(
                        image: image,
                        height: Dimens.gap_dp90,
                        width: Dimens.gap_dp80,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                Gaps.hGap20,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _tracks(widget.itemModel.tracks),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getColorFromImage(ImageProvider image) {
    PaletteGenerator.fromImageProvider(image).then((value) {
      setState(() {
        bgColor = value.dominantColor?.color.withOpacity(0.08);
      });
    });
  }

  List<Widget> _tracks(List<RankTracks> tracks) {
    final list = <Widget>[];
    for (int i = 0; i < tracks.length; i++) {
      final track = tracks.elementAt(i);
      if (list.isNotEmpty) {
        list.add(Gaps.vGap15);
      }
      list.add(
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${i + 1}. ${track.first}', style: body1Style()),
              TextSpan(
                  text: ' - ${track.second}',
                  style: captionStyle()
                      .copyWith(color: captionStyle().color?.withOpacity(0.6)))
            ],
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return list;
  }
}
