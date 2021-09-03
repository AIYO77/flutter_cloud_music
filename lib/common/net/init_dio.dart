import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/common/net/code.dart';
import 'package:flutter_cloud_music/common/net/cookie_interceptor.dart';
import 'package:flutter_cloud_music/common/net/response_interceptor.dart';
import 'package:flutter_cloud_music/common/net/result_data.dart';
import 'package:flutter_cloud_music/common/values/server.dart';

class HttpManager {
  final Dio _dio = Dio(BaseOptions(baseUrl: SERVER_API_URL));

  Dio getDio() {
    return _dio;
  }

  HttpManager() {
    _dio.interceptors.add(CookieInterceptors());

    _dio.interceptors.add(ResponseInterceptors());
  }

  Future<ResultData> get(String path, dynamic params,
      {bool noTip = false}) async {
    Response response;
    try {
      response = await _dio.get(path, queryParameters: params);
    } on DioError catch (e) {
      return resultError(e, path, noTip);
    }
    if (response.data is DioError) {
      return resultError(response.data, path, noTip);
    }
    return response.data as ResultData;
  }

  Future<ResultData> post(String path, dynamic params,
      {bool noTip = false}) async {
    Response response;
    try {
      response = await _dio.post(path, data: params);
    } on DioError catch (e) {
      return resultError(e, path, noTip);
    }
    if (response.data is DioError) {
      return resultError(response.data, path, noTip);
    }
    return response.data as ResultData;
  }

  ResultData resultError(DioError e, String path, bool noTip) {
    Response errorResponse;
    if (e.response != null) {
      errorResponse = e.response!;
    } else {
      errorResponse =
          Response(statusCode: 666, requestOptions: RequestOptions(path: path));
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
}

final HttpManager httpManager = HttpManager();
