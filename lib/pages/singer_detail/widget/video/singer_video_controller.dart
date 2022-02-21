import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/singer_videos_model.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/21 2:23 下午
/// Des:

class SingerVideoController extends SuperController<SingerVideosModel> {
  int id;

  String cursor = '0';

  SingerVideoController(this.id);

  late RefreshController refreshController;

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    refreshData();
  }

  Future<void> refreshData() async {
    cursor = '0';
    _requestData();
  }

  Future<void> loadMore() async {
    cursor = state!.page.cursor;
    _requestData();
  }

  Future<void> _requestData() async {
    MusicApi.getArtistVideos(artistId: id, cursor: cursor).then((newValue) {
      if (cursor == '0') {
        change(newValue, status: RxStatus.success());
      } else {
        //加载更多
        final newList = state!.records.toList(growable: true);
        newList.addAll(newValue!.records);
        change(SingerVideosModel(newList, newValue.page),
            status: RxStatus.success());
      }
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
