import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';

class PlayingListDialog extends StatefulWidget {
  static void show(BuildContext context) {
    Get.bottomSheet(PlayingListDialog(),
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.transparent);
  }

  @override
  PlayingListDialogState createState() => PlayingListDialogState();
}

class PlayingListDialogState extends State<PlayingListDialog> {
  ScrollController? _controller;
  late List<Song> playingList;
  late Song music;
  @override
  void initState() {
    super.initState();
    playingList = context.player.value.playingList;
    music = context.player.value.current!;
    final double offset =
        playingList.indexWhere((element) => element.id == music.id) *
            _kHeightMusicTile;
    _controller = ScrollController(initialScrollOffset: offset);
    context.player.addListener(_playerChanged);
  }

  @override
  void dispose() {
    context.player.removeListener(_playerChanged);
    super.dispose();
  }

  void _playerChanged() {
    setState(() {
      playingList = context.player.value.playingList;
      music = context.player.value.current!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.screenH() * 0.7,
      width: Adapt.screenW(),
      margin: EdgeInsets.fromLTRB(
          Dimens.gap_dp15, 0, Dimens.gap_dp15, Dimens.gap_dp16),
      decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp20))),
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap20,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
            child: RichText(
                text: TextSpan(text: '当前播放', style: headlineStyle(), children: [
              WidgetSpan(child: Gaps.hGap5),
              TextSpan(
                  text: '(${playingList.length})',
                  style: TextStyle(
                      fontSize: Dimens.font_sp10,
                      color: Colours.color_150.withOpacity(0.8)))
            ])),
          ),
          Container(
            height: Dimens.gap_dp44,
            padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp9),
            child: Row(
              children: [
                Obx(() => TextButton.icon(
                    onPressed: () {
                      context.transportControls
                          .setPlayMode(context.playModelRx.value.next);
                    },
                    icon: Image.asset(
                      context.playModelRx.value.iconPath,
                      width: Dimens.gap_dp22,
                      color: Colours.color_173,
                    ),
                    label: Text(
                      context.playModelRx.value.name,
                      style: body1Style().copyWith(fontSize: Dimens.font_sp15),
                    ))),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      notImplemented(context);
                    },
                    icon: Image.asset(
                      ImageUtils.getImagePath('ad_icn_download'),
                      color: body1Style().color!.withOpacity(0.7),
                      width: Dimens.gap_dp20,
                    )),
                IconButton(
                    onPressed: () {
                      notImplemented(context);
                    },
                    icon: Image.asset(
                      ImageUtils.getImagePath('btn_add'),
                      color: body1Style().color!.withOpacity(0.7),
                      width: Dimens.gap_dp26,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      ImageUtils.getImagePath('playlist_icn_delete'),
                      color: body1Style().color!.withOpacity(0.7),
                      width: Dimens.gap_dp26,
                    )),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  controller: _controller,
                  itemCount: playingList.length,
                  itemBuilder: (context, index) {
                    final item = playingList.elementAt(index);
                    return _SongItemCell(
                      song: item,
                      isPlaying: music.id == item.id,
                    );
                  }))
        ],
      )),
    );
  }
}

class _SongItemCell extends StatelessWidget {
  const _SongItemCell({Key? key, required this.song, required this.isPlaying})
      : super(key: key);

  final Song song;
  final bool isPlaying;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (isPlaying) {
            if (context.playbackState?.isPlaying == true) {
              return;
            } else {
              context.transportControls.play();
              return;
            }
          } else {
            context.transportControls.playFromMediaId(song.id.toString());
          }
        },
        child: Container(
          padding:
              EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp3),
          height: _kHeightMusicTile,
          child: Row(
            children: [
              if (isPlaying)
                Image.asset(ImageUtils.getPlayingMusicTag(),
                    width: Dimens.gap_dp12, color: Colours.app_main_light),
              if (isPlaying) Gaps.hGap8,
              Expanded(
                  child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: song.name,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: Dimens.font_sp16,
                              color: isPlaying
                                  ? Colours.app_main_light
                                  : body1Style().color),
                          children: [
                            TextSpan(
                                text: ' - ${song.arString()}',
                                style: body1Style()
                                    .copyWith(color: Colours.color_173))
                          ]))),
              IconButton(
                  onPressed: () {
                    //删除播放列表中的某一条
                    context.player.removeMusicItem(song.metadata);
                  },
                  icon: Image.asset(
                    ImageUtils.getImagePath('login_icn_back'),
                    color: body1Style().color!.withOpacity(0.7),
                    width: Dimens.gap_dp16,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

final _kHeightMusicTile = Dimens.gap_dp48;
