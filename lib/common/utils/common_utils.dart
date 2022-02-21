/*
 * @Author: XingWei 
 * @Date: 2021-08-20 09:04:59 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-08-20 20:56:18
 */
// 播放量格式化
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player/music_player.dart';

final box = GetStorage();

void afterLogin(ParamVoidCallback callback) {
  AuthService.to.isLoggedInValue.yes(() {
    callback.call();
  }).no(() {
    Get.toNamed(Routes.LOGIN);
  });
}

Future<void> toUserDetail({dynamic accountId, dynamic artistId}) async {
  return Get.toNamed(Routes.SINGER_DETAIL,
      arguments: {'accountId': accountId, 'artistId': artistId},
      preventDuplicates: false);
}

Future toast(dynamic message) async {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG);
}

String getPlayCountStrFromInt(int count) {
  if (count < 100000) {
    return '$count';
  } else if (count >= 100000 && count <= 99999999) {
    return '${count ~/ 10000}万';
  } else {
    return '${(count / 100000000).toStringAsFixed(1)}亿';
  }
}

String getFansCountStr(int? count) {
  if (count == null) return '0';
  if (count < 100000) {
    return '$count';
  } else if (count >= 100000 && count <= 99999999) {
    return '${(count / 10000).toStringAsFixed(1)}万';
  } else {
    return '${(count / 100000000).toStringAsFixed(1)}亿';
  }
}

String getCommentStrFromInt(int count) {
  if (count < 1000) {
    return count.toString();
  } else if (1000 <= count && count < 10000) {
    return '999+';
  } else if (10000 <= count && count < 100000) {
    return '1w+';
  } else {
    return '10w+';
  }
}

TextStyle headlineStyle() {
  return Get.theme.textTheme.subtitle1 ?? const TextStyle();
}

TextStyle headline1Style() {
  return Get.theme.textTheme.headline1 ?? const TextStyle();
}

TextStyle headline2Style() {
  return Get.theme.textTheme.headline2 ?? const TextStyle();
}

TextStyle body1Style() {
  return Get.theme.textTheme.bodyText1 ?? const TextStyle();
}

TextStyle body2Style() {
  return Get.theme.textTheme.bodyText2 ?? const TextStyle();
}

TextStyle captionStyle() {
  return Get.theme.textTheme.caption ?? const TextStyle();
}

List<Widget> getSongTags(Song song,
    {bool needOriginType = true,
    bool needNewType = true,
    bool needCopyright = true}) {
  final List<Widget> tags = List.empty(growable: true);
  final List<String> res = List.empty(growable: true);

  if (song.fee == 1) {
    res.add(ImageUtils.getImagePath('d2d'));
    if (song.privilege?.fee == 0) {
      res.add(ImageUtils.getImagePath('dx1'));
    }
  }
  if (song.copyright == 1 && needCopyright) {
    res.add(ImageUtils.getImagePath('dwg'));
  }
  if (song.originCoverType == 1 && needOriginType) {
    res.add(ImageUtils.getImagePath('dwr'));
  }
  if (song.v <= 3 && needNewType) {
    res.add(ImageUtils.getImagePath('dwp'));
  }
  if (song.privilege?.preSell == true) {
    res.add(ImageUtils.getImagePath('dwv'));
  }
  if (song.privilege?.payed == 1) {
    res.add(ImageUtils.getImagePath('dw7'));
  }
  if (song.privilege?.getMaxPlayBr() == 999000) {
    res.add(ImageUtils.getImagePath('dwz'));
  }
  if (song.privilege?.freeTrialPrivilege?.resConsumable == true ||
      song.privilege?.freeTrialPrivilege?.userConsumable == true) {
    res.add(ImageUtils.getImagePath('ck4'));
  }
  // Get.log('ressize ${res.length}');
  for (final element in res) {
    tags.add(Image.asset(
      element,
      width: Adapt.px(19.0),
      height: Adapt.px(10.0),
      fit: BoxFit.contain,
    ));
  }

  return tags;
}

///验证中文
bool isChinese(String value) {
  return RegExp(r"[\u4e00-\u9fa5]").hasMatch(value);
}

Widget buildUserAvatar(String url, Size size) {
  return SizedBox.fromSize(
    size: size,
    child: CircleAvatar(
      radius: size.height / 2,
      backgroundColor: Colors.transparent,
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) {
          return _buildAvaterHolder(size);
        },
        errorWidget: (context, url, e) {
          return _buildAvaterHolder(size);
        },
        imageBuilder: (context, provider) {
          return ClipOval(
            child: Image(image: provider),
          );
        },
      ),
    ),
  );
}

Widget _buildAvaterHolder(Size size) {
  return SizedBox(
    width: size.width,
    height: size.height,
    child: Image.asset(
      ImageUtils.getImagePath('ce2'),
      fit: BoxFit.cover,
      color: Colours.pink,
    ),
  );
}

bool isSoftKeyboardDisplay(MediaQueryData data) {
  return data.viewInsets.bottom / data.size.height > 0.3;
}

Widget padingBottomBox(MusicPlayerValue? value, {double append = 0}) {
  final bottom = Adapt.bottomPadding() + append;
  return SizedBox(
      height: value?.current == null ? bottom : bottom + Dimens.gap_dp58);
}

///根据月份和天数来获取星座
String getSignWithMd({required int m, required int d}) {
  String res = "格式错误！";
  final date = [20, 19, 21, 20, 21, 22, 23, 23, 23, 24, 23, 22];
  final int index = m; //索引
  final luckyData = [
    '摩羯座',
    '水瓶座',
    '双鱼座',
    '白羊座',
    '金牛座',
    '双子座',
    '巨蟹座',
    '狮子座',
    '处女座',
    '天秤座',
    '天蝎座',
    '射手座',
    '摩羯座'
  ];

  if (m >= 1 && m <= 12) {
    if (d >= 1 && d <= 31) {
      if (d < date[m - 1]) {
        res = luckyData[index - 1];
      } else {
        res = luckyData[index];
      }
    } else {
      res = '天数格式错误!';
    }
  } else {
    res = '月份格式错误!';
  }
  return res;
}

Widget placeholderWidget(BuildContext context, String url) => Container(
      color: Colours.load_image_placeholder(),
    );
