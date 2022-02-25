import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/new_song_album/new_song_album_controller.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/list/new_song_list_controller.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/new_song_tag_model.dart';
import 'package:flutter_cloud_music/widgets/check_song_cell.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:flutter_cloud_music/widgets/round_checkbox.dart';
import 'package:flutter_cloud_music/widgets/text_button_icon.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player.dart';

class NewSongListView extends StatefulWidget {
  final NewSongTagModel tagModel;

  final Key mKey;

  const NewSongListView(this.mKey, {required this.tagModel}) : super(key: mKey);

  @override
  NewSongListViewState createState() => NewSongListViewState();
}

class NewSongListViewState extends State<NewSongListView> {
  //全部播放按钮初始距离顶部的距离
  final double expandedTop = Adapt.px(146);
  late ScrollController scrollController;

  late NewSongListController controller;

  late NewSongAlbumController parentController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
    controller = GetInstance().putOrFind(
        () => NewSongListController(typeId: widget.tagModel.id),
        tag: widget.mKey.toString());
    parentController = GetInstance().find<NewSongAlbumController>();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget _buildItem(Song song) {
    return CheckSongCell(
      song: song,
      parentController: parentController,
      cellClickCallback: (s) {
        if (parentController.showCheck.value) {
          //操作
          List<Song>? oldList = parentController.selectedSong.value;
          if (GetUtils.isNullOrBlank(oldList) != true &&
              oldList?.indexWhere((element) => element.id == s.id) != -1) {
            //已选中
            oldList!.removeWhere((element) => element.id == s.id);
            parentController.selectedSong.value = List.from(oldList);
          } else {
            //未选中
            if (oldList == null) {
              oldList = [s];
            } else {
              oldList.add(s);
            }
            parentController.selectedSong.value = List.from(oldList);
          }
        } else {
          _playList(song: s);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode ? Colours.dark_bg_color : Colors.white,
      child: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  width: Adapt.screenW(),
                  child: _buildHeader(),
                ),
              ),
              //占位
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Dimens.gap_dp30,
                  child: Gaps.empty,
                ),
              ),
              Obx(() => (GetUtils.isNullOrBlank(controller.items.value) == true)
                  ? SliverToBoxAdapter(
                      child: MusicLoading(
                        axis: Axis.horizontal,
                      ),
                    )
                  : SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _buildItem(
                            controller.items.value!.elementAt(index));
                      }, childCount: controller.items.value!.length),
                      itemExtent: Dimens.gap_dp60)),
              //pading bottom
              SliverToBoxAdapter(
                  child: Obx(
                () => padingBottomBox(
                    append: (parentController.showCheck.value &&
                            context.curPlayRx.value == null)
                        ? Dimens.gap_dp60
                        : 0),
              ))
            ],
          ),
          _buildPlayAll()
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Image.asset(
          widget.tagModel.imgPath,
          fit: BoxFit.fitWidth,
          width: Adapt.screenW(),
        ),
      ],
    );
  }

  Widget _buildPlayAll() {
    double top = expandedTop;
    if (scrollController.hasClients) {
      final double offset = scrollController.offset;
      top -= offset > 0 ? offset : 0;
    }
    //悬浮效果
    top = top > 0 ? top : 0;
    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Container(
        height: Dimens.gap_dp50,
        decoration: BoxDecoration(
            color: Get.isDarkMode ? Colours.dark_bg_color : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.gap_dp16),
                topRight: Radius.circular(Dimens.gap_dp16))),
        child:
            Obx(() => (GetUtils.isNullOrBlank(controller.items.value) == true)
                ? Gaps.empty
                : Row(
                    children: [
                      if (parentController.showCheck.value)
                        Padding(
                          padding: EdgeInsets.only(left: Dimens.gap_dp10),
                          child: MyTextButtonWithIcon(
                              onPressed: () {
                                if (parentController
                                        .selectedSong.value?.length !=
                                    controller.items.value?.length) {
                                  //未全选中
                                  parentController.selectedSong.value =
                                      List.from(controller.items.value!);
                                } else {
                                  //已全选中
                                  parentController.selectedSong.value = null;
                                }
                              },
                              gap: Dimens.gap_dp8,
                              icon: RoundCheckBox(
                                const Key('all'),
                                value: parentController
                                        .selectedSong.value?.length ==
                                    controller.items.value?.length,
                              ),
                              label: Text(
                                '全选',
                                style: headlineStyle()
                                    .copyWith(fontWeight: FontWeight.normal),
                              )),
                        )
                      else
                        Padding(
                            padding: EdgeInsets.only(left: Dimens.gap_dp8),
                            child: MyTextButtonWithIcon(
                                onPressed: () {
                                  _playList();
                                },
                                gap: Dimens.gap_dp2,
                                icon: Image.asset(
                                  ImageUtils.getImagePath('btn_play'),
                                  color: headlineStyle().color,
                                  width: Dimens.gap_dp30,
                                  height: Dimens.gap_dp30,
                                ),
                                label: RichText(
                                    text: TextSpan(
                                        text: '播放全部',
                                        style: headlineStyle(),
                                        children: [
                                      WidgetSpan(child: Gaps.hGap5),
                                      TextSpan(
                                          text:
                                              '(共${controller.items.value!.length}首)',
                                          style: TextStyle(
                                              fontSize: Dimens.font_sp12,
                                              color: Colours.color_150
                                                  .withOpacity(0.8)))
                                    ])))),
                      const Expanded(child: Gaps.empty),
                      MyTextButtonWithIcon(
                          onPressed: () {
                            parentController.showCheck.value =
                                !parentController.showCheck.value;
                          },
                          icon: parentController.showCheck.value
                              ? Gaps.empty
                              : Image.asset(
                                  ImageUtils.getImagePath('icn_list_multi'),
                                  color: captionStyle().color,
                                  width: Dimens.gap_dp16,
                                ),
                          label: !parentController.showCheck.value
                              ? Text(
                                  '多选',
                                  style: body1Style()
                                      .copyWith(fontSize: Dimens.font_sp15),
                                )
                              : Text(
                                  '完成',
                                  style: TextStyle(
                                      color: Colours.app_main_light,
                                      fontSize: Dimens.font_sp16),
                                )),
                      Gaps.hGap5
                    ],
                  )),
      ),
    );
  }

  void _playList({Song? song}) {
    context.player.playWithQueue(
        PlayQueue(
            queueId: '${widget.tagModel.name}新歌',
            queueTitle: '${widget.tagModel.name}新歌',
            queue: controller.items.value!.toMetadataList()),
        metadata: song?.metadata);
  }
}
