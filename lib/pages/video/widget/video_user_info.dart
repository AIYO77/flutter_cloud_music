import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/model/mv_detail_model.dart';
import 'package:flutter_cloud_music/common/model/video_detail_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/widgets/user_avatar.dart';
import 'package:get/get.dart';

import '../controller/video_list_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/31 5:07 下午
/// Des:

class VideoUserInfoWidget extends StatefulWidget {
  final VPVideoController controller;

  const VideoUserInfoWidget(this.controller);

  @override
  _State createState() => _State();
}

class _State extends State<VideoUserInfoWidget> {
  MvDetailModel? _mvDetailModel;
  VideoDetailModel? _videoDetailModel;

  bool requestFollow = false;

  late bool isMv;

  String title = '';

  String? des;
  bool hasMoreDes = false;
  bool showMoreDes = false;

  @override
  void initState() {
    super.initState();
    isMv = widget.controller.videoModel.id.isMv();
    _initData(widget.controller.info.value);
    widget.controller.info.listen((info) {
      _initData(info);
      Future.delayed(const Duration(milliseconds: 100)).whenComplete(() {
        setState(() {});
      });
    });
  }

  void _initData(dynamic info) {
    if (info is MvDetailModel) {
      _mvDetailModel = info;
      title = info.name + info.briefDesc;
      des = info.desc;
    } else if (info is VideoDetailModel) {
      _videoDetailModel = info;
      title = info.title;
      des = info.description;
    }
    hasMoreDes = GetUtils.isNullOrBlank(des)! != true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp80),
      decoration: showMoreDes
          ? const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black26, Colors.black87],
            ))
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMv)
            _buildListUser(_mvDetailModel?.artists)
          else
            _buildSingleUser(_videoDetailModel?.creator),
          GestureDetector(
            onTap: () {
              if (hasMoreDes) {
                setState(() {
                  showMoreDes = !showMoreDes;
                });
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp13),
              constraints: BoxConstraints(maxHeight: Adapt.screenH() * 2 / 3),
              child: SingleChildScrollView(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: showMoreDes ? title + ('\n$des') : title,
                      style: TextStyle(
                          color: Colours.color_237, fontSize: Dimens.font_sp16),
                    ),
                    if (hasMoreDes && !showMoreDes)
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: Dimens.gap_dp20,
                          )),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListUser(List<MvArtists>? artists) {
    if (artists == null || artists.length == 1) {
      return _buildSingleUser(artists?.first.toVideoCreator());
    } else {
      //多个歌手
      return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: _buildListAvatar(artists.map((e) => e.img1v1Url).toList()),
            ),
            WidgetSpan(
              child: Gaps.hGap5,
            ),
            TextSpan(
              text: artists.map((e) => e.name).join('/'),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimens.font_sp14,
                  fontWeight: FontWeight.w500),
            ),
            WidgetSpan(
              child: Gaps.hGap5,
            ),
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _buildFollowWidget(
                    artists.first.id, artists.first.followed))
          ],
        ),
      );
    }
  }

  Widget _buildSingleUser(VideoCreator? user) {
    return Row(
      children: [
        UserAvatar(
          avatar: user?.avatarUrl ?? '',
          size: Dimens.gap_dp35,
          identityIconUrl: user?.avatarDetail?.identityIconUrl,
          holderAsset: ImageUtils.getImagePath('img_singer_pl', format: 'jpg'),
        ),
        Gaps.hGap5,
        Text(
          user?.nickname ?? '...',
          style: TextStyle(
              color: Colors.white,
              fontSize: Dimens.font_sp14,
              fontWeight: FontWeight.w500),
        ),
        Gaps.hGap5,
        _buildFollowWidget(user?.userId, user?.followed)
      ],
    );
  }

  Widget _buildListAvatar(List<String?> list) {
    final listWidget = List<Widget>.empty(growable: true);
    List<String?> newList = list;
    if (list.length >= 4) {
      newList = list.sublist(0, 4);
    }
    for (int i = 0; i < newList.length; i++) {
      final avatar = newList.elementAt(i);
      listWidget.add(Positioned(
          left: i * (Dimens.gap_dp35 / 2),
          child: Container(
            width: Dimens.gap_dp35,
            height: Dimens.gap_dp35,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: Dimens.gap_dp1),
              borderRadius: BorderRadius.circular(Dimens.gap_dp35 / 2),
            ),
            child: UserAvatar(
              avatar: avatar ?? '',
              size: Dimens.gap_dp34,
              holderAsset:
                  ImageUtils.getImagePath('img_singer_pl', format: 'jpg'),
            ),
          )));
    }
    return SizedBox(
      height: Dimens.gap_dp35,
      width: Dimens.gap_dp35 * (newList.length + 1) / 2,
      child: Stack(
        children: listWidget,
      ),
    );
  }

  Widget _buildFollowWidget(int? userId, bool? followed) {
    return followed == true
        ? Gaps.empty
        : GestureDetector(
            onTap: () {
              if (userId != null) {}
            },
            child: Container(
              width: Dimens.gap_dp30,
              height: Dimens.gap_dp20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colours.app_main_light,
                borderRadius: BorderRadius.circular(Dimens.gap_dp10),
              ),
              child: requestFollow
                  ? Theme(
                      data: ThemeData(
                          cupertinoOverrideTheme: const CupertinoThemeData(
                              brightness: Brightness.dark)),
                      child: Padding(
                        padding: EdgeInsets.only(right: Dimens.gap_dp4),
                        child: CupertinoActivityIndicator(
                          radius: Dimens.gap_dp6,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.add,
                      color: Colors.white,
                      size: Dimens.gap_dp13,
                    ),
            ),
          );
  }
}
