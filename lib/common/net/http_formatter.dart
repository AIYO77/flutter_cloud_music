import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

typedef HttpLoggerFilter = bool Function();

class HttpFormatter extends Interceptor {
  // Logger object to pretty print the HTTP Request
  final Logger _logger;
  final bool _includeRequest;
  final bool _includeRequestHeaders;
  final bool _includeRequestBody;
  final bool _includeResponse;
  final bool _includeResponseHeaders;
  final bool _includeResponseBody;

  /// Optionally add a filter that will log if the function returns true
  final HttpLoggerFilter? _httpLoggerFilter;

  /// Optionally can add custom [LogPrinter]
  HttpFormatter(
      {bool includeRequest = true,
      bool includeRequestHeaders = true,
      bool includeRequestBody = true,
      bool includeResponse = true,
      bool includeResponseHeaders = true,
      bool includeResponseBody = true,
      Logger? logger,
      HttpLoggerFilter? httpLoggerFilter})
      : _includeRequest = includeRequest,
        _includeRequestHeaders = includeRequestHeaders,
        _includeRequestBody = includeRequestBody,
        _includeResponse = includeResponse,
        _includeResponseHeaders = includeResponseHeaders,
        _includeResponseBody = includeResponseBody,
        _logger = logger ??
            Logger(printer: PrettyPrinter(methodCount: 0, printEmojis: false)),
        _httpLoggerFilter = httpLoggerFilter;

  @override
  Future onRequest(RequestOptions options) {
    options.extra = <String, dynamic>{
      'start_time': DateTime.now().millisecondsSinceEpoch
    };
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    if (_httpLoggerFilter == null || _httpLoggerFilter!()) {
      final message = _prepareLog(response.request, response);
      if (message != '') {
        _logger.i(message);
      }
    }
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    if (_httpLoggerFilter == null || _httpLoggerFilter!()) {
      final message = _prepareLog(err.request, err.response);
      if (message != '') {
        _logger.e(message);
      }
    }
    return super.onError(err);
  }

  /// Whether to pretty print a JSON or return as regular String
  String _getBody(dynamic data, String? contentType) {
    if (contentType != null &&
        contentType.toLowerCase().contains('application/json')) {
      const encoder = JsonEncoder.withIndent('  ');
      Map jsonBody;
      if (data is String) {
        jsonBody = jsonDecode(data) as Map;
      } else {
        jsonBody = data as Map;
      }
      return encoder.convert(jsonDecode(jsonEncode(jsonBody)));
    } else {
      return data.toString();
    }
  }

  /// Extracts the headers and body (if any) from the request and response
  String _prepareLog(RequestOptions? requestOptions, Response? response) {
    var requestString = '';
    var responseString = '';

    if (_includeRequest) {
      requestString = '⤴ REQUEST ⤴\n\n';

      requestString +=
          '${requestOptions?.method ?? ''} ${requestOptions?.path ?? ''}\n';

      if (_includeRequestHeaders) {
        for (final header in (requestOptions?.headers ?? {}).entries) {
          // ignore: use_string_buffers
          requestString += '${header.key}: ${header.value}\n';
        }
      }

      if (_includeRequestBody &&
          requestOptions?.data != null &&
          requestOptions?.data?.isNotEmpty == true) {
        final str = _getBody(requestOptions?.data, requestOptions?.contentType);
        requestString += '\n\n$str';
      }

      requestString += '\n\n';
    }

    if (_includeResponse && response != null) {
      responseString =
          '⤵ RESPONSE [${response.statusCode}/${response.statusMessage}] '
          // ignore: lines_longer_than_80_chars
          '${requestOptions?.extra['start_time'] != null ? '[Time elapsed: ${DateTime.now().millisecondsSinceEpoch - requestOptions?.extra['start_time']} ms]' : ''}'
          '⤵\n\n';

      if (_includeResponseHeaders) {
        for (final header in response.headers.map.entries) {
          // ignore: use_string_buffers
          responseString += '${header.key}: ${header.value}\n';
        }
      }

      if (_includeResponseBody &&
          response.data != null &&
          response.data.isNotEmpty == true) {
        final str =
            _getBody(response.data, response.headers.value('content-type'));
        responseString += '\n\n$str';
      }
    }

    return requestString + responseString;
  }
}
