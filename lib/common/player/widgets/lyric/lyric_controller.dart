import 'package:async/async.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/lyric.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';

class LyricController extends GetxController {
  CancelableOperation? _lyricLoader;

  String? _message = '暂无歌词';

  LyricContent? _lyricContent;

  ///没有歌词时的提示
  String? get message => _message;

  LyricContent? get lyric => _lyricContent;

  bool get hasLyric => lyric != null && lyric!.size > 0;

  Song? _music;

  @override
  void onInit() {
    PlayerService.to.player.addListener(() {
      _shouldLoadLyric(PlayerService.to.player.value.current);
    });
    super.onInit();
  }

  void currentLyric() {
    _shouldLoadLyric(PlayerService.to.player.value.current);
  }

  void _shouldLoadLyric(Song? music) {
    if (_music == music) {
      return;
    }
    _music = music;
    _lyricLoader?.cancel();
    if (music == null) {
      _setLyric();
      return;
    }
    _lyricLoader = CancelableOperation<String?>.fromFuture(
      MusicApi.lyric(_music!.id),
    )..value.then((lyric) {
        _setLyric(lyric: lyric);
      }, onError: (e, s) {
        logger.e('error to load lyric: $e $s');
        _setLyric(message: e.toString());
      });
  }

  void _setLyric({String? lyric, String? message}) {
    assert(lyric == null || message == null);
    _message = message;
    if (lyric != null && lyric.isNotEmpty) {
      _lyricContent = LyricContent.from(lyric);
    } else {
      _lyricContent = null;
    }
    if (_lyricContent?.size == 0) {
      _lyricContent = null;
    }
    if (_lyricContent == null) {
      _message = '暂无歌词';
    }
    update();
  }
}
