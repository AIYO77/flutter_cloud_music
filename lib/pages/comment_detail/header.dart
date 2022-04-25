import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/album_detail.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/model/playlist_detail_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/selector.dart';
import 'package:get/get.dart';

import '../../common/utils/adapt.dart';
import '../../common/utils/image_utils.dart';
import '../../routes/app_routes.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/18 3:13 下午
/// Des:

class CommentDetailSongHeader extends StatefulWidget {
  final Song song;

  const CommentDetailSongHeader({required this.song});

  @override
  _SongState createState() => _SongState();
}

class _SongState extends State<CommentDetailSongHeader> {
  late TapGestureRecognizer _arTapGesture;
  late TapGestureRecognizer _followTapGesture;

  @override
  void initState() {
    super.initState();
    _arTapGesture = TapGestureRecognizer();
    _followTapGesture = TapGestureRecognizer();
  }

  @override
  void dispose() {
    _arTapGesture.dispose();
    _followTapGesture.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (context.curPlayRx.value?.id == widget.song.id) {
          toPlaying();
        } else {
          Get.bottomSheet(
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimens.gap_dp49,
                  padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '歌曲:${widget.song.name}',
                    style: body1Style().copyWith(
                        fontSize: Dimens.font_sp14,
                        color: body1Style().color!.withOpacity(0.7)),
                  ),
                ),
                Gaps.line,
                GestureDetector(
                  onTap: () {
                    context.insertAndPlay(widget.song, openPlayingPage: true);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: double.infinity,
                    height: Dimens.gap_dp50,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                    child: Row(
                      children: [
                        Image.asset(
                          ImageUtils.getImagePath('radio_icn_play'),
                          width: Dimens.gap_dp24,
                          color: context.theme.iconTheme.color,
                        ),
                        Gaps.hGap12,
                        Text(
                          '播放歌曲',
                          style:
                              body1Style().copyWith(fontSize: Dimens.font_sp15),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: context.theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimens.gap_dp16),
                  topLeft: Radius.circular(Dimens.gap_dp16)),
            ),
          );
        }
      },
      child: Row(
        children: [
          SizedBox(
            width: Dimens.gap_dp42,
            height: Dimens.gap_dp42,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                    child: Image.asset(ImageUtils.getImagePath('play_disc'))),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.gap_dp6),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.song.al.picUrl ?? '',
                        placeholder: (context, url) => Image.asset(
                            ImageUtils.getImagePath('default_cover_play')),
                        errorWidget: (context, url, e) => Image.asset(
                            ImageUtils.getImagePath('default_cover_play')),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Gaps.hGap7,
          Expanded(
            child: RichText(
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                      text: widget.song.name + widget.song.alia.join('/'),
                      style: headline2Style()
                          .copyWith(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: ' - ${widget.song.arString()}',
                      recognizer: _arTapGesture
                        ..onTap = () {
                          if (widget.song.ar.length == 1) {
                            toUserDetail(
                                artistId: widget.song.ar.first.id,
                                accountId: widget.song.ar.first.accountId);
                          } else {
                            launchArtistDetailPage(context, widget.song.ar);
                          }
                        },
                      style: headline2Style().copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: Dimens.font_sp13,
                          color: headline2Style().color!.withOpacity(0.7))),
                  if (widget.song.ar.length == 1)
                    TextSpan(
                        text: ' · ',
                        style: headline2Style().copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.font_sp13,
                            color: headline2Style().color!.withOpacity(0.7))),
                  if (widget.song.ar.length == 1)
                    TextSpan(
                        text: '关注',
                        recognizer: _followTapGesture
                          ..onTap = () {
                            toast('关注');
                          },
                        style: headline2Style().copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: Dimens.font_sp13,
                            color: Colours.app_main_light)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CommentDetailAlHeader extends StatelessWidget {
  final Album album;

  const CommentDetailAlHeader({required this.album});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ALBUM_DETAIL_ID(album.id.toString()));
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          Stack(
            children: [
              Image.asset(
                ImageUtils.getImagePath(GetPlatform.isAndroid
                    ? 'ic_cover_alb_android'
                    : 'ic_cover_alb_ios'),
                width: Adapt.px(82),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp5)),
                    child: CachedNetworkImage(
                      height: Dimens.gap_dp70,
                      imageUrl: ImageUtils.getImageUrlFromSize(
                        album.picUrl,
                        Size(Dimens.gap_dp70, Dimens.gap_dp70),
                      ),
                      placeholder: placeholderWidget,
                    ),
                  ))
            ],
          ),
          Gaps.hGap10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(album.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: body1Style().copyWith(fontSize: Dimens.font_sp15)),
                Gaps.vGap8,
                GestureDetector(
                  onTap: () {
                    toUserDetail(
                        accountId: album.artist.accountId,
                        artistId: album.artist.id);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Text(album.artist.name ?? '',
                      style: TextStyle(
                          color: context.theme.highlightColor,
                          fontSize: Dimens.font_sp12)),
                )
              ],
            ),
          ),
          Gaps.hGap10,
          Image.asset(
            ImageUtils.getImagePath('icon_more'),
            height: Dimens.gap_dp22,
            color: Colours.color_163,
          )
        ],
      ),
    );
  }
}

class CommentDetailPlHeader extends StatelessWidget {
  final Playlist playlist;

  const CommentDetailPlHeader({required this.playlist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PLAYLIST_DETAIL_ID(playlist.id.toString()));
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.gap_dp5),
            child: CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                  playlist.coverImgUrl, Size(Dimens.gap_dp70, Dimens.gap_dp70)),
              placeholder: placeholderWidget,
              errorWidget: errorWidget,
              width: Dimens.gap_dp70,
              height: Dimens.gap_dp70,
            ),
          ),
          Gaps.hGap10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                            width: Dimens.gap_dp24,
                            height: Dimens.gap_dp14,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colours.btn_border_color,
                                  width: Dimens.gap_dp1),
                            ),
                            child: Text(
                              '歌单',
                              style: TextStyle(
                                  color: Colours.btn_border_color,
                                  fontSize: Dimens.font_sp9),
                            ),
                          )),
                      WidgetSpan(child: Gaps.hGap1),
                      TextSpan(
                          text: playlist.name,
                          style:
                              body1Style().copyWith(fontSize: Dimens.font_sp15))
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gaps.vGap6,
                GestureDetector(
                  onTap: () {
                    toUserDetail(accountId: playlist.creator.userId);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'by ',
                            style: captionStyle()
                                .copyWith(fontSize: Dimens.font_sp12)),
                        TextSpan(
                            text: playlist.creator.nickname,
                            style: TextStyle(
                                color: context.theme.highlightColor,
                                fontSize: Dimens.font_sp12))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Gaps.hGap10,
          Image.asset(
            ImageUtils.getImagePath('icon_more'),
            height: Dimens.gap_dp22,
            color: Colours.color_163,
          )
        ],
      ),
    );
  }
}
