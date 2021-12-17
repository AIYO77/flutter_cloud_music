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
  return Get.isDarkMode
      ? TextStyle(
          color: Colours.dark_headline4_color,
          fontSize: Dimens.font_sp17,
          fontWeight: FontWeight.w600)
      : TextStyle(
          color: Colours.headline4_color,
          fontSize: Dimens.font_sp17,
          fontWeight: FontWeight.w600);
}

TextStyle headline1Style() {
  return Get.isDarkMode
      ? TextStyle(
          color: Colours.dark_headline1_color,
          fontSize: Dimens.font_sp13,
          fontWeight: FontWeight.w500)
      : TextStyle(
          color: Colours.headline1_color,
          fontSize: Dimens.font_sp13,
          fontWeight: FontWeight.w500);
}

TextStyle headline2Style() {
  return Get.isDarkMode
      ? TextStyle(
          color: Colours.dark_headline1_color,
          fontSize: Dimens.font_sp15,
          fontWeight: FontWeight.w500)
      : TextStyle(
          color: Colours.headline1_color,
          fontSize: Dimens.font_sp15,
          fontWeight: FontWeight.w500);
}

TextStyle captionStyle() {
  return Get.isDarkMode
      ? TextStyle(
          color: Colours.dark_caption_txt_color, fontSize: Dimens.font_sp13)
      : TextStyle(color: Colours.caption_txt_color, fontSize: Dimens.font_sp13);
}

TextStyle subtitle1Style() {
  return Get.isDarkMode
      ? TextStyle(color: Colours.dark_subtitle_text, fontSize: Dimens.font_sp12)
      : TextStyle(color: Colours.subtitle_text, fontSize: Dimens.font_sp12);
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
  if (song.privilege?.playMaxbr == 999000) {
    res.add(ImageUtils.getImagePath('dwz'));
  }
  if (song.privilege?.freeTrialPrivilege.resConsumable == true ||
      song.privilege?.freeTrialPrivilege.userConsumable == true) {
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
