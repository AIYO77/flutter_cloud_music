import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/singer_list/model/index_artists.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state.dart';

class SingerListLogic extends SuperController<List<IndexArtists>>
    with GetTickerProviderStateMixin {
  final singerListState = SingerListState();

  @override
  void onInit() {
    singerListState.scrollController = ScrollController();
    singerListState.refreshController = RefreshController();
    super.onInit();

    singerListState.headerAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    singerListState.type.listen((p0) {
      if (singerListState.area.value.id == -1) {
        singerListState.area.value = singerListState.listArea.elementAt(0);
      } else {
        logger.d('type changed get data');
        getList();
      }
    });
    singerListState.area.listen((p0) {
      if (singerListState.type.value.id == -1) {
        singerListState.type.value = singerListState.listType.elementAt(0);
      } else {
        logger.d('area changed get data');
        getList();
      }
    });
    singerListState.isExpandFilter.listen((p0) {
      if (p0) {
        singerListState.headerAnimationController.reverse();
      } else {
        singerListState.headerAnimationController.forward();
      }
    });
    singerListState.scrollController.addListener(() {
      if (singerListState.isExpandFilter.value) {
        //展开状态
        //上滑
        if (singerListState.curScrollOffset <
                singerListState.scrollController.offset &&
            singerListState.scrollController.offset > 1.0) {
          singerListState.isExpandFilter.value = false;
        }
      } else {
        //收起状态
        if (singerListState.curScrollOffset >
            singerListState.scrollController.offset) {
          //下拉
          if (singerListState.scrollController.offset <= 1.0) {
            singerListState.isExpandFilter.value = true;
          }
        }
      }
      singerListState.curScrollOffset = singerListState.scrollController.offset;
    });
  }

  @override
  void onReady() {
    getList();
  }

  Future<void> getList() async {
    _resetData();
    _request();
  }

  Future<void> loadMore() async {
    singerListState.page += 1;
    logger.d('loadMore ${singerListState.page}');
    _request();
  }

  Future<void> _request() async {
    final model = await MusicApi.getArtists(
        singerListState.page,
        singerListState.curInitial,
        singerListState.type.value.id,
        singerListState.area.value.id);

    if (GetUtils.isNullOrBlank(state) == true) {
      //第一页
      change([
        IndexArtists(index: singerListState.curInitial, artists: model.artists)
      ], status: RxStatus.success());
      singerListState.refreshController.loadComplete();
    } else {
      final list = List.of(state!);
      final curIndex = list
          .indexWhere((element) => element.index == singerListState.curInitial);
      if (curIndex != -1) {
        list.elementAt(curIndex).artists.addAll(model.artists);
      } else {
        list.add(IndexArtists(
            index: singerListState.curInitial, artists: model.artists));
      }
      change(list, status: RxStatus.success());

      if (!model.more || (state?.last.artists.length ?? 0) >= 100) {
        //没有更多 或者已经加载了一百条 下一个initial
        if (singerListState.type.value.id == -1 ||
            singerListState.area.value.id == -1) {
          //还没有选择筛选条件
          singerListState.refreshController.loadNoData();
          return;
        }
        final initial = singerListState.getNextInitial();
        if (initial == null) {
          singerListState.refreshController.loadNoData();
        } else {
          singerListState.page = 0;
          singerListState.curInitial = initial;
          singerListState.refreshController.loadComplete();
        }
      } else {
        singerListState.refreshController.loadComplete();
      }
    }
  }

  @override
  void onClose() {
    singerListState.headerAnimationController.dispose();
    singerListState.scrollController.dispose();
    super.onClose();
  }

  void _resetData() {
    singerListState.page = 0;
    singerListState.curInitial = singerListState.initials.elementAt(0);
    change(null, status: RxStatus.loading());
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
