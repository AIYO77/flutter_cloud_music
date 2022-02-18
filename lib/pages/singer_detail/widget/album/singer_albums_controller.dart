import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/singer_albums_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/18 5:38 下午
/// Des:

class SingerAlbumsController extends SuperController<SingerAlbumsModel> {
  int id;

  int offet = 0;

  SingerAlbumsController(this.id);

  late RefreshController refreshController;

  @override
  void onInit() {
    super.onInit();
    refreshController = RefreshController();
  }

  @override
  void onReady() {
    refreshData();
  }

  Future<void> refreshData() async {
    offet = 0;
    _requestData();
  }

  Future<void> loadMore() async {
    offet = state!.hotAlbums.length;
    _requestData();
  }

  Future<void> _requestData() async {
    MusicApi.getArtistAlbums(artistId: id, offset: offet).then((newValue) {
      if (offet == 0) {
        change(newValue, status: RxStatus.success());
      } else {
        //加载更多
        final newList = state!.hotAlbums.toList();
        newList.addAll(newValue!.hotAlbums);
        change(SingerAlbumsModel(newList, newValue.more),
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
