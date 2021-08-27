import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cloud_music/common/net/code.dart';
import 'package:flutter_cloud_music/common/net/result_data.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    //没有网络
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(
        ResultData(Code.errorHandleFunction(Code.NETWORK_ERROR, "", false),
            false, Code.NETWORK_ERROR),
      );
    }
    return super.onRequest(options);
  }
}
