import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:get/get.dart';

import 'controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/24 4:13 下午
/// Des:所有歌单标签

class PlaylistTagAllPage extends GetView<TagAllController> {
  Widget _item(BuildContext context, TagTypeModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitle(context, model),
        GridView.builder(
          padding: EdgeInsets.only(
              left: Dimens.gap_dp14,
              right: Dimens.gap_dp14,
              bottom: Dimens.gap_dp24,
              top: Dimens.gap_dp16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: Dimens.gap_dp18,
            crossAxisSpacing: Dimens.gap_dp11,
            childAspectRatio: 79 / 36,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final tag = model.tags.elementAt(index);
            return _buildTag(context, model.type, tag);
          },
          itemCount: model.tags.length,
        ),
      ],
    );
  }

  Widget _buildTag(BuildContext context, int type, PlayListTagModel tag) {
    return Obx(() => GestureDetector(
          onTap: () {
            if (controller.isEditState.value) {
              //编辑状态
              if (type == -1 && tag.category >= 0) {
                controller.subTag(tag);
              }
              if (type != -1 && !tag.activity) {
                controller.addTag(tag);
              }
            }
          },
          onLongPress: () {
            controller.isEditState.value = !controller.isEditState.value;
          },
          child: Opacity(
            opacity: (tag.activity && type != -1) ||
                    (controller.isEditState.value &&
                        type < 0 &&
                        tag.category < 0)
                ? 0.4
                : 1.0,
            child: Container(
              decoration: BoxDecoration(
                  color:
                      context.isDarkMode ? Colors.white12 : Colours.color_242,
                  borderRadius: BorderRadius.circular(Dimens.gap_dp30)),
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(children: [
                  if (!controller.isEditState.value &&
                      tag.hot &&
                      tag.category >= 0)
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(right: Dimens.gap_dp3),
                          child: Image.asset(
                            ImageUtils.getImagePath('hall_hot_icon'),
                            height: Dimens.gap_dp15,
                          ),
                        )),
                  if (controller.isEditState.value && tag.category >= 0)
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: EdgeInsets.only(right: Dimens.gap_dp2),
                          child: Image.asset(
                            ImageUtils.getImagePath(tag.activity
                                ? 'hall_sub_icon'
                                : 'hall_plus_icon'),
                            height: Dimens.gap_dp14,
                          ),
                        )),
                  TextSpan(
                    text: tag.name,
                    style: headlineStyle().copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: Dimens.font_sp12),
                  )
                ]),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ));
  }

  Widget _buildTitle(BuildContext context, TagTypeModel model) {
    return Row(
      children: [
        Gaps.hGap16,
        Text(
          model.name,
          style: headline2Style(),
        ),
        if (model.type == -1)
          Expanded(
              child: Text(
            '(长按可编辑)',
            style: captionStyle(),
          )),
        if (model.type == -1)
          GestureDetector(
            onTap: () {
              controller.isEditState.value = !controller.isEditState.value;
            },
            child: Container(
              width: Dimens.gap_dp60,
              height: Dimens.gap_dp26,
              margin: EdgeInsets.only(right: Dimens.gap_dp16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colours.app_main_light,
                ),
                borderRadius: BorderRadius.circular(Dimens.gap_dp13),
              ),
              child: Obx(
                () => Center(
                  child: Text(
                    controller.isEditState.value ? '完成' : '编辑',
                    style: TextStyle(
                        color: Colours.app_main_light,
                        fontSize: Dimens.font_sp12),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: const MyAppBar(
        centerTitle: '所有歌单',
      ),
      body: BottomPlayerController(Obx(() => controller.items.value == null
          ? Padding(
              padding: EdgeInsets.only(top: Dimens.gap_dp50),
              child: MusicLoading(),
            )
          : ListView.builder(
              padding: EdgeInsets.only(
                  top: Dimens.gap_dp20,
                  bottom: context.curPlayRx.value == null
                      ? Adapt.bottomPadding()
                      : Adapt.bottomPadding() + Dimens.gap_dp58),
              itemBuilder: (context, index) {
                final model = controller.items.value!.elementAt(index);
                return _item(context, model);
              },
              itemCount: controller.items.value!.length))),
    );
  }
}
