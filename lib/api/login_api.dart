import 'package:flutter_cloud_music/common/model/login_response.dart';
import 'package:flutter_cloud_music/common/net/init_dio.dart';
import 'package:flutter_cloud_music/common/utils/encipher.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/model/country_list_model.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/model/phone_exist.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';

class LoginApi {
  //获取国家和地区code
  static Future<List<CountryListModel>?> getCountries() async {
    final response = await httpManager.get('/countries/code/list', null);
    if (response.result) {
      return (response.data as List)
          .map((e) => CountryListModel.fromJson(e))
          .toList();
    }
    return null;
  }

  //检查手机号是否已注册
  static Future<PhoneExist?> checkPhoneExistence(
      String phone, String countrycode) async {
    final response = await httpManager.get('/cellphone/existence/check',
        {'phone': phone, 'countrycode': countrycode});
    if (response.result) {
      return response.data as PhoneExist;
    }
    return null;
  }

  //发送验证码
  static Future<bool> sendCode(String phone, String ctcode) async {
    final response = await httpManager
        .get('/captcha/sent', {'phone': phone, 'ctcode': ctcode});
    return response.result;
  }

  //验证码的正确性
  static Future<bool> verCode(
      String phone, String ctcode, String captcha) async {
    final response = await httpManager.get('/captcha/verify',
        {'phone': phone, 'ctcode': ctcode, 'captcha': captcha});
    return response.result;
  }

  //手机号登陆 可以是密码或者验证码
  static Future<bool> phoneLogin(String phone, String countrycode,
      {String? password, String? captcha}) async {
    final data = {'phone': phone, 'countrycode': countrycode};
    if (password != null) {
      data['md5_password'] = Encipher.generateMd5(password);
    } else if (captcha != null) {
      data['captcha'] = captcha;
    }
    final resonse = await httpManager.post('/login/cellphone', data);
    if (resonse.result) {
      final loginData = resonse.data as LoginResponse;
      AuthService.to.login(loginData);
    }
    return resonse.result;
  }
}
