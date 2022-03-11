import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/model/mine_playlist.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/7 5:15 下午
/// Des:

class PlManageController extends GetxController {
  //原始列表
  late List<MinePlaylist> oldPlaylist;

  //改变后的列表
  final changedPlaylist = Rx<List<MinePlaylist>>(List.empty());

  List<MinePlaylist> get changedPlaylistValue => changedPlaylist.value;

  //选中的歌单
  final selectedPl = Rx<List<MinePlaylist>?>(null);

  @override
  void onInit() {
    super.onInit();
    oldPlaylist = Get.arguments as List<MinePlaylist>;
    changedPlaylist.value = List.from(oldPlaylist);
  }

  Future<void> finish() async {
    if (isChanged()) {
      EasyLoading.show(status: '加载中...');
      final result = await MusicApi.updatePlaylistOrder(
          changedPlaylistValue.map((e) => e.id).toList());
      if (result) {
        EasyLoading.dismiss();
        Get.back(result: changedPlaylistValue);
      } else {
        EasyLoading.showError('调整失败');
      }
    } else {
      Get.back();
    }
  }

  //列表是否有改变
  bool isChanged() {
    for (int i = 0; i < changedPlaylistValue.length; i++) {
      final b =
          oldPlaylist.elementAt(i).id == changedPlaylistValue.elementAt(i).id;
      if (!b) {
        return true;
      }
    }
    return false;
  }

  void selectedAll() {
    if (selectedPl.value?.length == changedPlaylistValue.length) {
      selectedPl.value = null;
    } else {
      selectedPl.value = List.from(changedPlaylistValue);
    }
  }

  void switchItem(int oldIndex, int newIndex) {
    logger.i('switchItem oldIndex = $oldIndex  newIndex = $newIndex');
    final list = changedPlaylistValue;
    final tmp = list[oldIndex];
    list.removeAt(oldIndex);
    if (newIndex >= list.length) {
      list.insert(newIndex - 1, tmp);
    } else {
      list.insert(newIndex, tmp);
    }
    changedPlaylist.value = List.from(list);
  }

  void checkItem(bool isChecked, MinePlaylist item) {
    List<MinePlaylist>? list = selectedPl.value;
    if (isChecked) {
      //选中状态
      list!.removeWhere((element) => element.id == item.id);
    } else {
      //未选中状态
      list ??= List.empty(growable: true);
      list.add(item);
    }
    selectedPl.value = List.from(list);
  }

  //删除选中歌单
  Future<void> deleteSelectedPl() async {
    if (GetUtils.isNullOrBlank(selectedPl.value) == true) return;
    Get.dialog(
        CupertinoAlertDialog(
          content: const Text('确定要删除该歌单吗?'),
          actions: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                color: Colors.transparent,
                height: Dimens.gap_dp50,
                alignment: Alignment.center,
                child: Text(
                  '取消',
                  style: body2Style().copyWith(
                      color: Colours.blue, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Get.back();
                _confirmDelete();
              },
              child: Container(
                color: Colors.transparent,
                height: Dimens.gap_dp50,
                alignment: Alignment.center,
                child: Text(
                  '删除',
                  style: body2Style().copyWith(color: Colours.app_main_light),
                ),
              ),
            )
          ],
        ),
        barrierColor: Colors.black12);
  }

  Future<void> _confirmDelete() async {
    EasyLoading.show(status: '加载中...');
    final result = await MusicApi.deletePlaylist(
        selectedPl.value!.map((e) => e.id).toList());
    if (result) {
      final tmpList = changedPlaylistValue;
      for (final pl in selectedPl.value!) {
        tmpList.removeWhere((element) => element.id == pl.id);
      }
      changedPlaylist.value = List.from(tmpList);
      eventBus.fire(selectedPl.value!.map((e) => e.id).toList());
      selectedPl.value = null;
      EasyLoading.dismiss();
      toast('删除成功');
    } else {
      EasyLoading.showError('删除失败');
    }
  }
}
