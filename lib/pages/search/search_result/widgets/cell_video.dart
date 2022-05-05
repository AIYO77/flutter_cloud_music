import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/search_videos.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/pages/video/state.dart';
import 'package:flutter_cloud_music/pages/video/view.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:get/get.dart';

import '../../../../common/res/gaps.dart';
import '../../../../common/utils/common_utils.dart';
import '../../../../common/utils/time.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/5/5 4:23 下午
/// Des:

class SearchVideoCell extends StatelessWidget {
  final Videos video;
  final String keywords;

  const SearchVideoCell({required this.video, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Bounce(
        onPressed: () {
          VideoPage.startWithSingle(
              VideoModel(id: video.vid, coverUrl: video.coverUrl));
        },
        child: Container(
          margin: EdgeInsets.only(right: Dimens.gap_dp16, top: Dimens.gap_dp12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                child: CachedNetworkImage(
                  imageUrl: video.coverUrl,
                  placeholder: placeholderWidget,
                  errorWidget: errorWidget,
                  height: Dimens.gap_dp84,
                  width: Dimens.gap_dp150,
                  imageBuilder: (context, image) {
                    return Container(
                      height: Dimens.gap_dp84,
                      width: Dimens.gap_dp150,
                      color: Colors.black,
                      child: Stack(
                        children: [
                          Image(
                            image: image,
                            height: Dimens.gap_dp84,
                            width: Dimens.gap_dp150,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: Dimens.gap_dp30,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                      Colors.transparent,
                                      Colors.black38
                                    ])),
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.only(
                                    right: Dimens.gap_dp8,
                                    bottom: Dimens.gap_dp8),
                                child: Text(
                                  getTimeStamp(video.durationms),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimens.font_sp9),
                                ),
                              ))
                        ],
                      ),
                    );
                  },
                ),
              ),
              Gaps.hGap10,
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichTextWidget(
                    Text(
                      video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: body1Style().copyWith(fontSize: Dimens.font_sp16),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    richTexts: [
                      BaseRichText(
                        keywords,
                        style: body1Style().copyWith(
                          fontSize: Dimens.font_sp16,
                          color: context.theme.highlightColor,
                        ),
                      )
                    ],
                  ),
                  Gaps.vGap8,
                  Text(
                    video.creator.map((e) => e.name).join('/'),
                    style: captionStyle().copyWith(fontSize: Dimens.font_sp12),
                  )
                ],
              )),
            ],
          ),
        ));
  }
}
