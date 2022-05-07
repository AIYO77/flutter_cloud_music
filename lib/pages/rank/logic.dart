import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/rank_item_model.dart';
import 'package:get/get.dart';

class RankLogic extends GetxController {
  final items = Rx<List<RankItemModel>?>(null);

  @override
  void onReady() {
    super.onReady();
    _request();
  }

  void _request() {
    MusicApi.getRanks().then((value) {
      items.value = value;
    });
  }

  //推荐榜单
  List<RankItemModel> rcmdItem() {
    if (items.value == null) return [];
    //非官方榜单的更新时间列表
    final filter =
        items.value!.where((element) => element.tracks.isEmpty).toList();
    //从小到大
    filter.sort((a, b) => a.playCount.compareTo(b.playCount));
    final newFilter = filter.sublist(filter.length - 10, filter.length);
    newFilter.sort((a, b) => a.updateTime.compareTo(b.updateTime));
    //最近更新的三个
    return newFilter.sublist(newFilter.length - 3, newFilter.length);
  }
}
