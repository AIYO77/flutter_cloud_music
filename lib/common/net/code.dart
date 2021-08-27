import 'package:flutter_cloud_music/common/event/http_error_event.dart';
import 'package:flutter_cloud_music/common/event/index.dart';

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  static const SUCCESS = 200;

  static String errorHandleFunction(int code, String message, bool noTip) {
    if (noTip) {
      return message;
    }
    eventBus.fire(HttpErrorEvent(code, message));
    return message;
  }
}
