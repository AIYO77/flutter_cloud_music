import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/hot_search_model.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/search/search_result/view.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';

import '../../common/res/colors.dart';
import '../../common/utils/common_utils.dart';
import '../../common/utils/image_utils.dart';
import '../../widgets/search/search_history.dart';
import '../single_search/widget/search_suggest.dart';
import 'logic.dart';
import 'state.dart';

class SearchPage extends StatelessWidget {
  final logic = Get.find<SearchLogic>();
  final SearchState state = Get.find<SearchLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimens.gap_dp44 + Adapt.topPadding()),
        child: Padding(
          padding: EdgeInsets.only(top: Adapt.topPadding()),
          child: _buildSearch(context),
        ),
      ),
      body: BottomPlayerController(
        Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (e) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
              _buildHisAndHot(context),
              Obx(
                () => SingleSearchSuggest(
                  showSuggests: state.showSuggests.value,
                  suggests: state.suggests.value,
                  keywords: state.keywords.value,
                  onSuggestTap: (word) {
                    logic.search(word);
                  },
                ),
              ),
              Obx(() => state.showResult.value
                  ? SearchResultPage(
                      key: Key(state.keywords.value.hashCode.toString()),
                      keywords: state.keywords.value,
                    )
                  : Gaps.empty)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (state.showResult.value) {
              state.showResult.value = false;
              state.showSuggests.value = false;
              state.editingController.text = '';
            } else {
              Get.back();
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: Dimens.gap_dp44,
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
            alignment: Alignment.center,
            child: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: context.theme.iconTheme.color,
              height: Dimens.gap_dp25,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: Dimens.gap_dp36,
            margin: EdgeInsets.only(right: Dimens.gap_dp16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.gap_dp18),
              color: Get.isDarkMode
                  ? Colors.white.withOpacity(0.2)
                  : Colours.color_245,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: Dimens.gap_dp6),
            child: TextField(
              controller: state.editingController,
              focusNode: state.focusNode,
              style: headlineStyle().copyWith(
                  fontWeight: FontWeight.normal, fontSize: Dimens.font_sp16),
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  constraints: BoxConstraints(maxHeight: Dimens.gap_dp38),
                  prefixIconConstraints: BoxConstraints(
                      minWidth: Dimens.gap_dp26, maxHeight: Dimens.gap_dp15),
                  prefixIcon: Image.asset(
                    ImageUtils.getImagePath('search'),
                    color: const Color.fromARGB(255, 155, 155, 155),
                  ),
                  hintStyle: TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: Colours.text_gray,
                      fontWeight: FontWeight.normal),
                  hintText: state.defaultSearch?.showKeyword ?? '搜索歌曲'),
              onEditingComplete: () {
                logic.search(state.keywordsValue);
              },
              textInputAction: TextInputAction.search,
              onChanged: (word) {
                logic.searchSuggest(word);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHisAndHot(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Gaps.vGap10,
        ),
        SliverToBoxAdapter(
          child: SearchHistoryView(
            onSelected: (word) {
              logic.search(word);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Gaps.vGap26,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                EdgeInsets.only(left: Dimens.gap_dp17, bottom: Dimens.gap_dp10),
            child: Text(
              '热搜榜',
              style: headline2Style(),
            ),
          ),
        ),
        Obx(
          () => SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height: state.hotSearch.value == null
                  ? Dimens.gap_dp360
                  : (state.hotSearch.value!.length / 2).ceil() *
                          Dimens.gap_dp34 +
                      Dimens.gap_dp12,
              margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(Dimens.gap_dp10),
                  border: Border.all(
                      color: context.theme.dividerColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                        color: context.theme.shadowColor,
                        blurRadius: Dimens.gap_dp10)
                  ]),
              child: state.hotSearch.value == null
                  ? Padding(
                      padding: EdgeInsets.only(top: Dimens.gap_dp40),
                      child: MusicLoading(),
                    )
                  : _buildHotSearch(context, state.hotSearch.value!),
            ),
          ),
        )
      ],
    );
  }

  //热搜列表
  Widget _buildHotSearch(BuildContext context, List<HotSearch> list) {
    return GridView.builder(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          top: Dimens.gap_dp12,
          bottom: Dimens.gap_dp12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 160 / 34),
      itemBuilder: (context, index) {
        final item = list.elementAt(index);
        return _hotItem(index, item);
      },
      itemCount: list.length,
    );
  }

  Widget _hotItem(int index, HotSearch item) {
    return Material(
      color: Get.theme.cardColor,
      child: InkWell(
          onTap: () {
            logic.search(item.searchWord);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        width: Dimens.gap_dp22,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.font_sp14,
                              color: index < 3
                                  ? Colours.app_main_light
                                  : captionStyle().color),
                        ),
                      )),
                  TextSpan(
                    text: item.searchWord,
                    style: TextStyle(
                        fontSize: Dimens.font_sp14,
                        fontWeight:
                            index < 3 ? FontWeight.w500 : FontWeight.normal,
                        color: headlineStyle().color),
                  ),
                  if (item.iconUrl != null)
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: EdgeInsets.only(left: Dimens.gap_dp5),
                        child: CachedNetworkImage(
                          imageUrl: item.iconUrl!,
                          height: Dimens.gap_dp14,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          )),
    );
  }
}
