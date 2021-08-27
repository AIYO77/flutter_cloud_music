import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';

class BaseProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = SERVER_API_URL;

    // 请求拦截
    httpClient.addRequestModifier<void>((request) {
      Get.log(
          'request url = ${request.url}, request body = ${request.bodyBytes}');
      return request;
    });

    // 响应拦截
    httpClient.addResponseModifier((request, response) {
      Get.log(response.bodyString.toString());
      return response;
    });
  }
}
