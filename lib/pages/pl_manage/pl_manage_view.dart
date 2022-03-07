import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/mine_playlist.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/mine/widget/pl_cell.dart';
import 'package:get/get.dart';

import '../../widgets/round_checkbox.dart';
import 'pl_manage_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/7 5:15 下午
/// Des:

class PlManagePage extends GetView<PlManageController> {
  const PlManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        toolbarHeight: Dimens.gap_dp48,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: Dimens.gap_dp58,
        leading: _buildLeading(),
        title: _buildTitle(context),
        actions: [
          GestureDetector(
            onTap: () {
              controller.finish();
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: Dimens.gap_dp48,
              width: Dimens.gap_dp58,
              alignment: Alignment.center,
              child: Text(
                '完成',
                style: body2Style(),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ReorderableListView.builder(
                  itemBuilder: (context, index) {
                    final item = controller.playlist.elementAt(index);
                    return _buildItem(item);
                  },
                  itemCount: controller.playlist.length,
                  onReorder: (oldIndex, newIndex) {})),
          Container(
            height: Dimens.gap_dp48 + Adapt.bottomPadding(),
            padding: EdgeInsets.only(bottom: Adapt.bottomPadding()),
            color: Colors.red,
          )
        ],
      ),
    );
  }

  Widget _buildLeading() {
    return Obx(
      () => GestureDetector(
        onTap: () {},
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: Dimens.gap_dp48,
          alignment: Alignment.center,
          child: Text(
            controller.playlist.length == controller.selectedPl.value?.length
                ? '取消全选'
                : '全选',
            style: body2Style(),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Obx(() => Text(
          GetUtils.isNullOrBlank(controller.selectedPl.value) == true
              ? '管理歌单'
              : '已选中${controller.selectedPl.value!.length}个歌单',
          style: context.theme.appBarTheme.titleTextStyle
              ?.copyWith(fontSize: Dimens.font_sp18),
        ));
  }

  Widget _buildItem(MinePlaylist item) {
    return Container(
      key: Key('${item.id}${item.name}'),
      width: double.infinity,
      padding: EdgeInsets.only(top: Dimens.gap_dp3, bottom: Dimens.gap_dp3),
      child: Row(
        children: [
          Obx(() {
            final isChecked = (controller.selectedPl.value
                        ?.indexWhere((element) => element.id == item.id) ??
                    -1) !=
                -1;
            return SizedBox(
              width: Dimens.gap_dp58,
              height: Dimens.gap_dp52,
              child: RoundCheckBox(null, value: isChecked),
            );
          }),
          Expanded(
              child: MinePlaylistCell(Key(item.id.toString()), playlist: item)),
          Container(
            width: Dimens.gap_dp58,
            height: Dimens.gap_dp52,
            alignment: Alignment.center,
            child: Image.asset(
              ImageUtils.getImagePath('icn_multi'),
              color: body2Style().color?.withOpacity(0.6),
              width: Dimens.gap_dp20,
            ),
          )
        ],
      ),
    );
  }
}
