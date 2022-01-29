import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/event/user_follow_event.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:get/get.dart';

class FollowWidget extends StatefulWidget {
  final String id; //歌手ID
  final bool isFollowed; //是否已经关注
  final bool isSolidWidget; //是否是实心widget
  final bool isSinger; // 是否是歌手
  final ParamSingleCallback<bool>? isFollowedCallback;

  const FollowWidget(
    Key? key, {
    required this.id,
    required this.isFollowed,
    this.isFollowedCallback,
    this.isSolidWidget = false,
    this.isSinger = true,
  }) : super(key: key);

  @override
  _FollowWidgetState createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
  late bool isFollowed;
  late bool showLoading;
  late StreamSubscription stream;

  @override
  void initState() {
    super.initState();
    isFollowed = widget.isFollowed;
    showLoading = false;
    stream = eventBus.on<UserFollowEvent>().listen((event) {
      if (widget.id == event.id) {
        setState(() {
          isFollowed = event.isFollowed;
        });
      }
    });
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = TextStyle(
      fontSize: Dimens.font_sp13,
      color: isFollowed
          ? Colours.text_gray
          : widget.isSolidWidget
              ? Colors.white
              : Colours.app_main_light,
    );
    return Container(
      decoration: BoxDecoration(
          gradient: widget.isSolidWidget && !isFollowed
              ? const LinearGradient(colors: [
                  Color(0xffec6454),
                  Color(0xffeb5442),
                  Color(0xffea3d2c)
                ])
              : null,
          border: (widget.isSolidWidget && !isFollowed)
              ? null
              : Border.all(
                  color: txtStyle.color!.withOpacity(0.5),
                  width: Dimens.gap_dp1),
          borderRadius: BorderRadius.all(Radius.circular(Adapt.screenH()))),
      child: GestureDetector(
        onTap: () async {
          afterLogin(() {
            if (!showLoading) {
              setState(() {
                showLoading = true;
              });
              Future<bool> future;
              if (widget.isSinger) {
                future = MusicApi.subArtist(widget.id, isFollowed ? 0 : 1);
              } else {
                future = MusicApi.subUser(widget.id, isFollowed ? 0 : 1);
              }
              future.then((value) {
                setState(() {
                  showLoading = false;
                  if (value) {
                    isFollowed = !isFollowed;
                  }
                  widget.isFollowedCallback?.call(isFollowed);
                  eventBus.fire(
                      UserFollowEvent(id: widget.id, isFollowed: isFollowed));
                });
              }, onError: (_) {
                setState(() {
                  showLoading = false;
                });
              });
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLoading)
              Theme(
                data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                        brightness: widget.isSolidWidget
                            ? Brightness.dark
                            : Get.theme.brightness)),
                child: Padding(
                  padding: EdgeInsets.only(right: Dimens.gap_dp4),
                  child: CupertinoActivityIndicator(
                    radius: Dimens.gap_dp6,
                  ),
                ),
              ),
            if (!showLoading)
              Padding(
                padding:
                    EdgeInsets.only(right: isFollowed ? 0 : Dimens.gap_dp4),
                child: Image.asset(
                  ImageUtils.getImagePath(
                      isFollowed ? 'icn_check' : 'plus_icon'),
                  color: txtStyle.color,
                  width: isFollowed ? Dimens.gap_dp15 : Dimens.gap_dp12,
                ),
              ),
            Text(
              isFollowed ? '已关注' : '关注',
              style: txtStyle.copyWith(
                  fontSize: isFollowed ? Dimens.font_sp12 : Dimens.font_sp13),
            )
          ],
        ),
      ),
    );
  }
}
