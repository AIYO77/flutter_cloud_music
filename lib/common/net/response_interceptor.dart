import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/common/model/songs_model.dart';
import 'package:flutter_cloud_music/common/net/code.dart';
import 'package:flutter_cloud_music/common/net/result_data.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:get/instance_manager.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final RequestOptions option = response.requestOptions;
    ResultData value;
    try {
      final header = response.headers[Headers.contentTypeHeader];

      if (header != null && header.toString().contains("text") ||
          (response.statusCode! >= 200 && response.statusCode! < 300)) {
        if (option.path.contains('/playlist/hot') ||
            option.path.contains('/playlist/highquality/tags')) {
          value = ResultData(response.data['tags'], true, Code.SUCCESS);
        } else if (option.path.contains('/personalized')) {
          value = ResultData(response.data['result'], true, Code.SUCCESS);
        } else if (option.path.contains('/top/playlist') ||
            option.path.contains('/top/playlist/highquality')) {
          value = ResultData(response.data['playlists'], true, Code.SUCCESS,
              total: response.data['total']);
        } else if (option.path.contains('/playlist/detail')) {
          value = ResultData(
              PlaylistDetailModel.fromJson(response.data), true, Code.SUCCESS);
        } else if (option.path.contains('/song/detail')) {
          value = ResultData(
              SongsModel.fromJson(response.data), true, Code.SUCCESS);
        } else if (option.path.contains('/check/music')) {
          value = ResultData(response.data['message'],
              response.data['success'] as bool, Code.SUCCESS);
        } else {
          value = ResultData(response.data['data'], true, Code.SUCCESS);
        }
      } else {
        value = ResultData(response.data, false, response.data['code']);
      }
    } catch (e) {
      Get.log(e.toString() + option.path, isError: true);
      value = ResultData(response.data, false, response.statusCode!);
    }
    response.data = value;
    super.onResponse(response, handler);
  }

  // @override
  // Future onResponse(Response response) {

  //   return Future.value(value);
  // }
}
