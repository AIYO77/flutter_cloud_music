import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/event/mine_pl_content_event.dart';
import 'package:flutter_cloud_music/common/model/mine_playlist.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

import '../../services/auth_service.dart';

class MineController extends GetxController with GetTickerProviderStateMixin {
  final level = 0.obs;

  final minePlaylist = Rx<List<MinePlaylist>?>(null);

  late ScrollController scrollController;

  final barHeight = Adapt.topPadding() + Dimens.gap_dp44;

  final barBgOpacity = 0.0.obs;

  final isTop = false.obs;

  late TabController tabController;

  //key
  final GlobalKey tabKey = GlobalKey();
  final GlobalKey createKey = GlobalKey();
  final GlobalKey collectKey = GlobalKey();

  double? originOffset;

  //删除歌单的监听
  late StreamSubscription _deletedSub;

  //歌单内容变化监听
  late StreamSubscription _plContentSub;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
    tabController = TabController(length: 2, vsync: this);
    AuthService.to.isLoggedIn.listen((login) {
      if (login) _getUserInfo();
    });
    _deletedSub = eventBus.on<List<int>>().listen((event) {
      if (event.isNotEmpty) {
        //删除的Ids
        final list = minePlaylist.value;
        if (list != null) {
          for (final id in event) {
            list.removeWhere((element) => id == element.id);
          }
          minePlaylist.value = List.from(list);
        }
      }
    });
    _plContentSub = eventBus.on<MinePlContentEvent>().listen((event) {
      if (event.isChanged) _getUserPlaylist();
    });
  }

  @override
  void onReady() {
    _getUserInfo();
  }

  void _getUserInfo() {
    _getUserLevel();
    _getUserPlaylist();
  }

  void _getUserLevel() {
    if (AuthService.to.isLoggedInValue) {
      MusicApi.getUserLevel().then((value) {
        level.value = value;
      });
    }
  }

  void _getUserPlaylist() {
    if (AuthService.to.isLoggedInValue) {
      MusicApi.getMinePlaylist(AuthService.to.userId).then((value) {
        minePlaylist.value = value;
      });
    }
  }

  ///开启心动模式
  Future<void> startIntelligent(dynamic pid) async {
    final songs = await MusicApi.getPlayListAllTrack(pid);
    if (GetUtils.isNullOrBlank(songs) == true) {
      Get.back();
      EasyLoading.showError('该歌单没有歌曲');
    } else {
      final index = Random().nextInt(songs!.length);
      final intelligenceSongs = await MusicApi.startIntelligence(
          songId: songs.elementAt(index).id, pid: pid);
      if (GetUtils.isNullOrBlank(intelligenceSongs) == true) {
        Get.back();
        EasyLoading.showError('该歌单没有歌曲');
      } else {
        PlayerService.to.player.playWithQueue(PlayQueue(
            queueId: pid.toString(),
            queueTitle: '心动模式',
            queue: intelligenceSongs!.toMetadataList()));
        Future.delayed(const Duration(milliseconds: 1000)).then((value) {
          Get.back();
          toPlaying();
        });
      }
    }
  }

  void _onScroll() {
    final opacity = scrollController.offset / barHeight;
    barBgOpacity.value = opacity > 1.0
        ? 1.0
        : opacity < 0
            ? 0
            : opacity;
    // tab是否已经吸顶
    final box = tabKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      final tabOffset = box.localToGlobal(Offset.zero);
      isTop.value = tabOffset.dy <= barHeight;
    }

    if (!_isTap) {
      //是否在创建歌单的区域内
      final collectBox =
          collectKey.currentContext?.findRenderObject() as RenderBox?;
      final offset = collectBox?.localToGlobal(Offset.zero);
      if (offset != null) {
        if (offset.dy >= barHeight + Dimens.gap_dp44) {
          tabController.animateTo(0);
        } else {
          tabController.animateTo(1);
        }
      }
    }
  }

  void onTabChange(int index) {
    if (index == 0) {
      _scrollToCreatePl();
    } else {
      _scrollToCollectPl();
    }
  }

  bool _isTap = false;

  ///滚动到创建歌单
  Future<void> _scrollToCreatePl() async {
    if (originOffset != null) {
      _isTap = true;
      await scrollController.animateTo(originOffset! - Dimens.gap_dp52,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
      _isTap = false;
    }
  }

  ///滚动到收藏歌单
  Future<void> _scrollToCollectPl() async {
    if (originOffset != null) {
      _isTap = true;
      final createCardHeight = createKey.currentContext?.size?.height ?? 0;
      await scrollController.animateTo(
          originOffset! + createCardHeight - Dimens.gap_dp52,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn);
      _isTap = false;
    }
  }

  ///创建歌单
  Future<void> createPlaylist(
      String name, String plType, String? privacy) async {
    EasyLoading.show();
    final createPl = await MusicApi.createPlaylist(
        name: name, type: plType, privacy: privacy);
    if (createPl != null) {
      //创建成功
      await EasyLoading.showSuccess('新建歌单成功');
      //关闭弹窗
      Get.back();
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        final list = minePlaylist.value ??= List.empty(growable: true);
        list.insert(0, createPl);
        minePlaylist.value = List.from(list);
        Get.toNamed(Routes.PLAYLIST_DETAIL_ID(createPl.id.toString()));
      });
    } else {
      //创建失败
      EasyLoading.showError('新建歌单失败');
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _deletedSub.cancel();
    _plContentSub.cancel();
    super.onClose();
  }

  //更新顺序
  void updateOrder(List<MinePlaylist>? result) {
    if (GetUtils.isNullOrBlank(result) == true) return;
    final list = minePlaylist.value;
    if (result!.first.isMyPl()) {
      list!.removeWhere((element) => element.isMyPl());
    } else {
      list!.removeWhere((element) => !element.isMyPl());
    }
    list.addAll(result);
    minePlaylist.value = List.from(list);
  }
}

extension MinePlaylistExt on List<MinePlaylist> {
  MinePlaylist getIntelligent() {
    return firstWhere((element) => element.isIntelligent());
  }

  List<MinePlaylist> getMineCreate() {
    return where((element) => element.isMineCreate()).toList();
  }

  List<MinePlaylist> getMineCollect() {
    return where((element) => !element.isMyPl()).toList();
  }
}
