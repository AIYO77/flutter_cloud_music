import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/list_more_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:get/get.dart';

class PlayListContentController extends SuperController<PlayListHasMoreModel?> {
  late PlayListTagModel tagModel;

  final limit = 30;
  int offet = 0;

  //精品歌单筛选列表
  List<String>? highqualityTags;

  //选中的精品type null：全部精品
  final cat = Rx<String?>(null);

  bool requesting = false;

  @override
  void onReady() {
    refreshData();
  }

  Future<void> refreshData() async {
    offet = 0;
    _requestData();
  }

  Future<void> loadMore() async {
    offet = state!.datas.length;
    _requestData();
  }

  Future<void> _requestData() async {
    switch (tagModel.name) {
      case '推荐':
        getRcmPlayList();
        break;
      case '精品':
        if (highqualityTags == null) {
          getHighqualityTags();
        }
        getHighqualityList();
        break;
      default:
        getPlayListFromTag();
        break;
    }
  }

  //分类歌单列表
  Future<void> getPlayListFromTag() async {
    MusicApi.getPlayListFromTag(tagModel.name, limit, offet).then((newValue) {
      if (offet == 0) {
        change(newValue, status: RxStatus.success());
      } else {
        //加载更多
        final newList = state!.datas.toList();
        newList.addAll(newValue!.datas);
        change(
            PlayListHasMoreModel(
                datas: newList, totalCount: newValue.totalCount),
            status: RxStatus.success());
      }
    }, onError: (err) {});
  }

  //推荐歌单列表
  Future<void> getRcmPlayList() async {
    append(() => MusicApi.getRcmPlayList);
  }

  //获取精品歌单筛选项
  Future<void> getHighqualityTags() async {
    highqualityTags = await MusicApi.getHighqualityTags();
  }

  //精品歌单列表
  Future<void> getHighqualityList() async {
    requesting = true;
    MusicApi.getHighqualityList(
            cat.value, limit, offet == 0 ? null : state?.datas.last.updateTime)
        .then((newValue) {
      requesting = false;
      if (offet == 0) {
        change(newValue, status: RxStatus.success());
      } else {
        //加载更多
        final newList = state!.datas.toList();
        newList.addAll(newValue!.datas);
        change(
            PlayListHasMoreModel(
                datas: newList, totalCount: newValue.totalCount),
            status: RxStatus.success());
      }
    }, onError: (err) {
      requesting = false;
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
