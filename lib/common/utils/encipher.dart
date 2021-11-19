import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class Encipher {
  static String generateMd5(String data) {
    final content = const Utf8Encoder().convert(data);
    final digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
