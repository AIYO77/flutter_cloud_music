import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/model/search_videos.dart';
import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../common/res/gaps.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/image_utils.dart';
import '../../../common/utils/time.dart';
import '../../../widgets/footer_loading.dart';
import '../../add_video/logic.dart';
import '../logic.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/15 5:15 下午
/// Des:
class ResultVideos extends StatelessWidget {
  final controller = GetInstance().find<SingleSearchLogic>();

  final pController = GetInstance().find<AddVideoLogic>();

  final List<Videos> videos;

  ResultVideos(this.videos);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: controller.refreshController,
        footer: FooterLoading(),
        onLoading: () {
          controller.loadMoreResult();
        },
        enablePullUp: true,
        enablePullDown: false,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
          itemBuilder: (context, index) {
            final video = videos.elementAt(index);
            return _item(video);
          },
          separatorBuilder: (context, index) {
            return Gaps.vGap5;
          },
          itemCount: videos.length,
        ));
  }

  Widget _item(Videos video) {
    return GestureDetector(
      onTap: () {
        pController.addVideoToPl(video.vid);
      },
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
          height: Dimens.gap_dp61,
          width: double.infinity,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  toast('play');
                },
                behavior: HitTestBehavior.translucent,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp5)),
                  child: CachedNetworkImage(
                    imageUrl: video.coverUrl,
                    placeholder: placeholderWidget,
                    errorWidget: errorWidget,
                    height: Dimens.gap_dp51,
                    width: Dimens.gap_dp75,
                    imageBuilder: (context, image) {
                      return Container(
                        height: Dimens.gap_dp84,
                        width: Dimens.gap_dp150,
                        color: Colors.black,
                        child: Stack(
                          children: [
                            Image(
                              image: image,
                              height: Dimens.gap_dp51,
                              width: Dimens.gap_dp75,
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
                                      right: Dimens.gap_dp3,
                                      bottom: Dimens.gap_dp3),
                                  child: Text(
                                    getTimeStamp(video.durationms),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimens.font_sp9),
                                  ),
                                )),
                            Center(
                              child: Image.asset(
                                ImageUtils.getImagePath('icon_play_small'),
                                color: Colors.white70,
                                width: Dimens.gap_dp28,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Gaps.hGap10,
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      if (video.type == 0)
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Container(
                              width: Dimens.gap_dp20,
                              height: Dimens.gap_dp13,
                              margin: EdgeInsets.only(right: Dimens.gap_dp3),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colours.app_main_light
                                          .withOpacity(0.4),
                                      width: Dimens.gap_dp1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Dimens.gap_dp2))),
                              child: Text(
                                'MV',
                                style: TextStyle(
                                    color: Colours.app_main_light,
                                    fontSize: Dimens.font_sp9,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      TextSpan(
                          text: video.title,
                          style: body2Style()
                              .copyWith(fontWeight: FontWeight.normal))
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gaps.vGap2,
                  Text(
                    'by ${video.creator.map((e) => e.name).join('/')}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: captionStyle().copyWith(fontSize: Dimens.font_sp12),
                  )
                ],
              )),
            ],
          )),
    );
  }
}
