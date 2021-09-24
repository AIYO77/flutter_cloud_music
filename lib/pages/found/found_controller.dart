import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/services/home_top_service.dart';
import 'package:get/get.dart';

class FoundController extends SuperController<FoundData?> {
  final Map<String, double> itemHeightFromType = {
    SHOWTYPE_BANNER: Dimens.gap_dp140,
    SHOWTYPE_BALL: Dimens.gap_dp95,
    SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST: Dimens.gap_dp213,
    SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM: Adapt.px(238),
    SHOWTYPE_SLIDE_SINGLE_SONG: Adapt.px(88),
    SHOWTYPE_SHUFFLE_MUSIC_CALENDAR: Adapt.px(206),
    SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN: Adapt.px(245),
    SHOWTYPE_SHUFFLE_MLOG: Adapt.px(245),
    HOMEPAGE_SLIDE_PLAYABLE_MLOG: Adapt.px(245),
    SHOWTYPE_SLIDE_VOICELIST: Adapt.px(220),
    SHOWTYPE_SLIDE_PLAYABLE_DRAGON_BALL: Adapt.px(200),
    SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB: Adapt.px(200),
    SLIDE_RCMDLIKE_VOICELIST: Adapt.px(220)
  };

  //刷新过期时间
  int expirationTime = -1;

  Future<void> getFoundRecList() async {
    append(() => MusicApi.getFoundRec);
  }

  Future<void> getDefaultSearch() async {
    final data = await MusicApi.getDefaultSearch();
    HomeTopService.to.defuleSearch.value = data;
  }

  @override
  void onReady() {
    super.onReady();
    getFoundRecList();
    getDefaultSearch();
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onResumed() {
    Get.log('onResumed');
    getDefaultSearch();
    if (expirationTime > 0) {
      if (DateTime.now().millisecondsSinceEpoch > expirationTime) {
        //当前时间大于失效时间 刷新
        Get.log("首页刷新时间到期，重新获取数据");
        getFoundRecList();
      }
    }
  }
}
