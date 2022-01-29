import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/artists_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/singer_list/widget/filter_header.dart';
import 'package:flutter_cloud_music/widgets/follow/follow_widget.dart';
import 'package:flutter_cloud_music/widgets/footer_loading.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'logic.dart';

class SingerListPage extends StatelessWidget {
  final logic = Get.put(SingerListLogic());
  final state = Get.find<SingerListLogic>().singerListState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterHeader(),
        Expanded(
          child: logic.obx((model) {
            return SmartRefresher(
              controller: state.refreshController,
              footer: const FooterLoading(
                noMoreTxt: "",
              ),
              onLoading: () async {
                logic.loadMore();
              },
              enablePullUp: true,
              enablePullDown: false,
              child: ListView.builder(
                  controller: state.scrollController,
                  itemCount: model?.length ?? 0,
                  itemBuilder: (context, index) {
                    return StickyHeader(
                        header: Container(
                          color: Get.isDarkMode
                              ? const Color(0xff292929)
                              : Colours.color_248,
                          height: Dimens.gap_dp25,
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            model!.elementAt(index).getIndexName(),
                            style: headlineStyle().copyWith(
                                fontSize: Dimens.font_sp12,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        content: Column(
                          children: _buildGroup(model.elementAt(index).artists),
                        ));
                  }),
            );
          },
              onLoading:
                  _buildLoading(GetUtils.isNullOrBlank(logic.state) == true)),
        )
      ],
    );
  }

  Widget _buildLoading(bool isNull) {
    if (isNull) {
      return Container(
        margin: EdgeInsets.only(top: Adapt.px(100)),
        child: MusicLoading(
          axis: Axis.horizontal,
        ),
      );
    } else {
      return Gaps.empty;
    }
  }

  List<Widget> _buildGroup(List<Artists> artists) {
    return artists
        .map(
          (ar) => Material(
            color: Get.theme.cardColor,
            child: InkWell(
              onTap: () {
                toUserDetail(accountId: ar.accountId, artistId: ar.id);
              },
              child: SizedBox(
                height: Dimens.gap_dp70,
                width: double.infinity,
                child: Row(
                  children: [
                    Gaps.hGap16,
                    ClipOval(
                      child: CachedNetworkImage(
                        width: Dimens.gap_dp50,
                        height: Dimens.gap_dp50,
                        imageUrl: ImageUtils.getImageUrlFromSize(
                          ar.img1v1Url,
                          Size(Dimens.gap_dp70, Dimens.gap_dp70),
                        ),
                        placeholder: (context, url) {
                          return Container(
                            color: Colours.load_image_placeholder(),
                          );
                        },
                        errorWidget: (context, url, e) => Container(
                          color: Colours.load_image_placeholder(),
                        ),
                      ),
                    ),
                    Gaps.hGap10,
                    Expanded(
                        child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                            text: ar.name,
                            style: headline2Style()
                                .copyWith(fontWeight: FontWeight.normal)),
                        if (ar.getExtraStr() == null)
                          WidgetSpan(child: Gaps.hGap4),
                        if (ar.getExtraStr() != null)
                          TextSpan(
                              text: ar.getExtraStr(),
                              style: headline2Style().copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colours.color_109)),
                        if (ar.accountId != null)
                          WidgetSpan(
                              child: ClipOval(
                            child: Container(
                              width: Dimens.gap_dp15,
                              height: Dimens.gap_dp15,
                              color: Colours.app_main,
                              alignment: Alignment.center,
                              child: Image.asset(
                                ImageUtils.getImagePath('icn_account'),
                                height: Dimens.gap_dp10,
                                color: Colors.white,
                              ),
                            ),
                          ))
                      ]),
                    )),
                    Container(
                      height: Dimens.gap_dp26,
                      width: Dimens.gap_dp64,
                      margin: EdgeInsets.only(
                          right: Dimens.gap_dp16, left: Dimens.gap_dp8),
                      child: FollowWidget(
                        Key('${ar.id}'),
                        id: ar.id.toString(),
                        isFollowed: ar.followed,
                        isSolidWidget: false,
                      ),
                    ),

                    // CupertinoButton(child: child, onPressed: onPressed)
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}
