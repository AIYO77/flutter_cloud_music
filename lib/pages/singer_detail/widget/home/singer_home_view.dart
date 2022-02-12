import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/singer_detail/logic.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:get/get.dart';

///歌手详情主页tab
class SingerHomeView extends StatelessWidget {
  final SingerDetailState state;
  final SingerDetailLogic logic;

  const SingerHomeView(this.state, this.logic);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _buildBriefCard(),
        ),
        if (state.isSinger())
          SliverToBoxAdapter(
            child: _buildSimiListView(),
          )
      ],
    );
  }

  ///相识艺人
  Widget _buildSimiListView() {
    return Container(
      margin: EdgeInsets.all(Dimens.gap_dp16),
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp18),
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
          boxShadow: [
            BoxShadow(
                color: Get.theme.shadowColor,
                offset: const Offset(0, 2),
                blurRadius: 6.0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: Dimens.gap_dp16),
            child: Text(
              '相似艺人',
              style: headlineStyle().copyWith(
                  fontSize: Dimens.font_sp18, fontWeight: FontWeight.w600),
            ),
          ),
          Obx(() => Container(
                width: double.infinity,
                height: Adapt.px(137 + 15),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: Dimens.gap_dp15),
                child: logic.simiListView(state.simiItems.value),
              ))
        ],
      ),
    );
  }

  ///简介卡片
  Widget _buildBriefCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      padding: EdgeInsets.fromLTRB(
          Dimens.gap_dp16, Dimens.gap_dp18, Dimens.gap_dp16, Dimens.gap_dp18),
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
          boxShadow: [
            BoxShadow(
                color: Get.theme.shadowColor,
                offset: const Offset(0, 2),
                blurRadius: 6.0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.isSinger() ? '艺人百科' : '基本信息',
            style: headlineStyle().copyWith(
                fontSize: Dimens.font_sp18, fontWeight: FontWeight.w600),
          ),
          Gaps.vGap14,
          if (state.getIdentify()?.imageUrl != null)
            RichText(
                text: TextSpan(children: [
              if (GetUtils.isNullOrBlank(state.getIdentify()!.imageUrl) != true)
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: CachedNetworkImage(
                      imageUrl: state.getIdentify()!.imageUrl ?? '',
                      width: Dimens.gap_dp20,
                    )),
              if (GetUtils.isNullOrBlank(state.getIdentify()!.imageUrl) != true)
                WidgetSpan(child: Gaps.hGap8),
              TextSpan(
                  text: '${state.getIdentify()!.imageDesc}',
                  style: captionStyle().copyWith(fontSize: Dimens.font_sp13))
            ])),
          if (state.getIdentify()?.imageUrl != null) Gaps.vGap10,
          if (state.isSinger())
            _buildKeyValue(key: '艺人名', value: state.getName()),
          if (GetUtils.isNullOrBlank(state.getSecondaryIdentity()) != true)
            _buildKeyValue(key: '身份', value: state.getSecondaryIdentity()!),
          if (GetUtils.isNullOrBlank(state.getGender()) != true)
            _buildKeyValue(key: '性别', value: state.getGender()),
          if (GetUtils.isNullOrBlank(state.getBirthday()) != true)
            _buildKeyValue(key: '生日', value: state.getBirthday()),
          if (GetUtils.isNullOrBlank(state.getDes()) != true)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    state.isSinger() ? '歌手简介: ' : '个人简介: ',
                    style: captionStyle().copyWith(fontSize: Dimens.font_sp13),
                  ),
                ),
                Expanded(
                    child: Text(
                  state.getDes(),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: captionStyle().copyWith(fontSize: Dimens.font_sp13),
                ))
              ],
            )
        ],
      ),
    );
  }

  Widget _buildKeyValue({required String key, required String value}) {
    final caption = captionStyle();
    final style = caption.copyWith(fontSize: Dimens.font_sp13);
    return Column(
      children: [
        RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(children: [
              TextSpan(
                text: '$key: ',
                style: style.copyWith(
                  color: caption.color!.withOpacity(0.7),
                ),
              ),
              TextSpan(
                text: value,
                style: style,
              )
            ])),
        Gaps.vGap12
      ],
    );
  }
}
