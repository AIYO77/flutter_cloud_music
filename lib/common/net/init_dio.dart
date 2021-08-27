import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/common/net/code.dart';
import 'package:flutter_cloud_music/common/net/cookie_interceptor.dart';
import 'package:flutter_cloud_music/common/net/error_interceptor.dart';
import 'package:flutter_cloud_music/common/net/response_interceptor.dart';
import 'package:flutter_cloud_music/common/net/result_data.dart';
import 'package:flutter_cloud_music/common/values/server.dart';

import 'http_formatter.dart';

class HttpManager {
  final Dio _dio = Dio(BaseOptions(baseUrl: SERVER_API_URL));

  HttpManager() {
    _dio.interceptors.add(CookieInterceptors());

    _dio.interceptors.add(ErrorInterceptors(_dio));

    _dio.interceptors.add(HttpFormatter(logger: logger));

    _dio.interceptors.add(ResponseInterceptors());
  }

  Future<ResultData> get(String path, dynamic params, {bool noTip = false}) {
    return _netFetch(path, params,
        option: Options(method: 'get'), noTip: noTip);
  }

  Future<ResultData> post(String path, dynamic params, {bool noTip = false}) {
    return _netFetch(path, params,
        option: Options(method: 'post'), noTip: noTip);
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ option] 配置
  Future<ResultData> _netFetch(String path, dynamic params,
      {bool noTip = false, required Options option}) async {
    ResultData resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response!;
      } else {
        errorResponse =
            Response(statusCode: 666, request: RequestOptions(path: path));
      }
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return ResultData(
          Code.errorHandleFunction(errorResponse.statusCode!, e.message, noTip),
          false,
          errorResponse.statusCode!);
    }

    Response response;
    try {
      response = await _dio.request(path, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return response.data as ResultData;
  }
}

final HttpManager httpManager = HttpManager();
