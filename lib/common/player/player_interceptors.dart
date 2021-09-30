import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:music_player/music_player.dart';

class PlayerInterceptors {
  // 获取播放地址
  static Future<String> playUriInterceptor(
      String? mediaId, String? fallbackUri) async {
    final result = await MusicApi.getPlayUrl(int.parse(mediaId!));
    if (result.isEmpty) {
      return fallbackUri ?? '';
    }
    logger.d('url = $result');
    return result.replaceFirst("http://", "https://");
  }

  static Future<Uint8List> loadImageInterceptor(MusicMetadata metadata) async {
    final ImageStream stream =
        CachedNetworkImageProvider(metadata.iconUri.toString())
            .resolve(ImageConfiguration(
      size: Size(Adapt.px(150), Adapt.px(150)),
      devicePixelRatio: WidgetsBinding.instance!.window.devicePixelRatio,
    ));
    final image = Completer<ImageInfo>();
    stream.addListener(ImageStreamListener((info, a) {
      image.complete(info);
    }, onError: (exception, stackTrace) {
      image.completeError(exception, stackTrace);
    }));
    final result = await image.future
        .then((image) => image.image.toByteData(format: ImageByteFormat.png))
        .then((byte) => byte!.buffer.asUint8List())
        .timeout(const Duration(seconds: 10));
    logger.d("load image for : ${metadata.title} ${result.length}");
    return result;
  }
}

class QuietPlayQueueInterceptor extends PlayQueueInterceptor {
  @override
  Future<List<MusicMetadata>> fetchMoreMusic(
      BackgroundPlayQueue queue, PlayMode playMode) async {
    if (queue.queueId == kFmPlayQueueId) {
      return await MusicApi.getFmMusics() ?? List.empty();
    }
    return super.fetchMoreMusic(queue, playMode);
  }
}
