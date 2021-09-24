/*
 * @Author: XingWei 
 * @Date: 2021-08-20 09:04:59 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-08-20 20:56:18
 */
// 播放量格式化
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

String getPlayCountStrFromInt(int count) {
  if (count < 100000) {
    return '$count';
  } else if (count >= 100000 && count <= 99999999) {
    return '${count ~/ 10000}万';
  } else {
    return '${(count / 100000000).toStringAsFixed(1)}亿';
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
    {bool needOriginType = true, bool needNewType = true}) {
  final List<Widget> tags = List.empty(growable: true);
  final List<String> res = List.empty(growable: true);

  if (song.fee == 1) {
    res.add(ImageUtils.getImagePath('d2d'));
    if (song.privilege?.fee == 0) {
      res.add(ImageUtils.getImagePath('dx1'));
    }
  }
  if (song.copyright == 1) {
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
