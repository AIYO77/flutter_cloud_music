import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:get/get.dart';

class PlayingMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (PlayerService.to.curPlayId.value == null &&
        GetUtils.isNullOrBlank(
                PlayerService.to.watchPlayerValue.value?.queue.queue) ==
            true) {
      //没有正在播放的
      return null;
    }
    return super.redirectDelegate(route);
  }
}
