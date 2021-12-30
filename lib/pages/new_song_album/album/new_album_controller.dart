import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/album_cover_info.dart';
import 'package:flutter_cloud_music/pages/new_song_album/album/top_album_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewAlbumController extends SuperController<List<TopAlbumModel>> {
  int year = DateTime.now().year;
  int month = DateTime.now().month;

  List<AlbumCoverInfo>? newAlbums = List.empty(growable: true);

  RefreshController? refreshController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _requestData();
  }

  Future<void> _requestData() async {
    MusicApi.getNewAlbum().then((value) {
      newAlbums = value;
      refresh(); //手动通知
    });
    _requestTopAlbums();
  }

  Future<void> _requestTopAlbums() async {
    MusicApi.getTopAlbum(year, month, oldData: state).then((value) {
      change(value, status: RxStatus.success());
    });
  }

  Future<void> loadMore() async {
    if (month <= 1) {
      year -= 1;
      month = 12;
    } else {
      month -= 1;
    }
    _requestTopAlbums();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onClose() {
    refreshController?.dispose();
    super.onClose();
  }
}
