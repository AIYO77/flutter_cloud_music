import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/get_instance.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../common/res/gaps.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/image_utils.dart';
import '../../../widgets/footer_loading.dart';
import '../../../widgets/rich_text_widget.dart';
import '../../add_song/logic.dart';
import '../logic.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/15 5:11 下午
/// Des:

class ResultSongs extends StatefulWidget {
  final List<Song> songs;

  const ResultSongs(this.songs);

  @override
  _State createState() => _State();
}

class _State extends State<ResultSongs> {
  final controller = GetInstance().find<SingleSearchLogic>();
  final addController = GetInstance().find<AddSongLogic>();

  int _curPlayId = -1;

  AudioPlayer? _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: controller.refreshController,
        footer: FooterLoading(),
        onLoading: () {
          controller.loadMoreResult();
        },
        enablePullUp: true,
        enablePullDown: false,
        child: ListView.builder(
          itemBuilder: (context, index) {
            final item = widget.songs.elementAt(index);
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  addController.addMusicToPl(item);
                },
                child: SizedBox(
                  height: Dimens.gap_dp46,
                  width: double.infinity,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _play(item.id);
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: Dimens.gap_dp16, right: Dimens.gap_dp13),
                          child: Image.asset(
                            ImageUtils.getImagePath(_curPlayId == item.id
                                ? 'list_btn_stop'
                                : 'list_btn_play'),
                            color: Colours.app_main_light,
                            height: Dimens.gap_dp20,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichTextWidget(
                            Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: body2Style(),
                            ),
                            richTexts: [
                              BaseRichText(
                                controller.keywordsValue,
                                style: TextStyle(
                                    fontSize: Dimens.font_sp16,
                                    color: context.theme.highlightColor),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: getSongTags(item,
                                    needOriginType: false,
                                    needNewType: false,
                                    needCopyright: false),
                              ),
                              Expanded(
                                  child: RichTextWidget(
                                Text(
                                  item.getSongCellSubTitle(),
                                  style: captionStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                richTexts: [
                                  BaseRichText(
                                    controller.keywordsValue,
                                    style: TextStyle(
                                        fontSize: captionStyle().fontSize,
                                        color: context.theme.highlightColor),
                                  )
                                ],
                              ))
                            ],
                          )
                        ],
                      )),
                      Gaps.hGap15
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: widget.songs.length,
        ));
  }

  Future<void> _play(int id) async {
    if (_curPlayId == id) {
      //停止
      setState(() {
        _curPlayId = -1;
      });
      _audioPlayer?.stop();
      return;
    }
    setState(() {
      _curPlayId = id;
    });
    _audioPlayer ??= AudioPlayer();
    PlayerService.to.player.transportControls.pause();
    final url = await MusicApi.getPlayUrl(id);
    final result = await _audioPlayer!.play(url);
    if (result != 1) {
      //播放失败
      toast('播放失败');
      setState(() {
        _curPlayId = -1;
      });
    }
  }

  @override
  void deactivate() {
    _audioPlayer?.release();
    super.deactivate();
  }
}
