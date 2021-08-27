import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/common/net/code.dart';
import 'package:flutter_cloud_music/common/net/result_data.dart';
import 'package:get/instance_manager.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  Future onResponse(Response response) {
    final RequestOptions option = response.request;
    ResultData value;
    try {
      final header = response.headers[Headers.contentTypeHeader];

      if (header != null && header.toString().contains("text") ||
          (response.statusCode! >= 200 && response.statusCode! < 300)) {
        if (response.request.path.contains('/playlist/hot')) {
          value = ResultData(response.data['tags'], true, Code.SUCCESS);
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
    return Future.value(value);
  }
}
