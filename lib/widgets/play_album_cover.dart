import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/widgets/rotation_cover_image.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:music_player/music_player.dart';

class PlayAlbumCover extends StatefulWidget {
  const PlayAlbumCover({Key? key, this.music}) : super(key: key);
  final Song? music;

  @override
  State createState() => _PlayAlbumCoverState();
}

class _PlayAlbumCoverState extends State<PlayAlbumCover>
    with TickerProviderStateMixin {
  late AnimationController _needleController;

  late Animation<double> _needleAnimation;

  AnimationController? _translateController;

  bool _needleAttachCover = false;

  bool _coverRotating = false;

  ///专辑封面X偏移量
  ///[-screenWidth/2,screenWidth/2]
  /// 0 表示当前播放音乐封面
  /// -screenWidth/2 - 0 表示向左滑动 |_coverTranslateX| 距离，即滑动显后一首歌曲的示封面
  double _coverTranslateX = 0;

  bool _beDragging = false;

  bool _previousNextDirty = true;

  ///滑动切换音乐效果上一个封面
  Song? _previous;

  ///当前播放中的音乐
  Song? _current;

  ///滑动切换音乐效果下一个封面
  Song? _next;

  late MusicPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = context.player;
    _needleAttachCover = _player.playbackState.isPlaying;
    _needleController = AnimationController(
        value: _needleAttachCover ? 1.0 : 0.0,
        vsync: this,
        duration: const Duration(milliseconds: 500));
    _needleAnimation = Tween<double>(begin: -1 / 12, end: 0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_needleController);

    _current = widget.music;
    _invalidatePn();
    _player.addListener(_checkNeedleAndCoverStatus);
    _checkNeedleAndCoverStatus();
  }

  @override
  void didUpdateWidget(PlayAlbumCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_current == widget.music) {
      _invalidatePn();
      return;
    }
    double offset = 0;
    if (widget.music == _previous) {
      offset = MediaQuery.of(context).size.width;
    } else if (widget.music == _next) {
      offset = -MediaQuery.of(context).size.width;
    }
    _animateCoverTranslateTo(offset, onCompleted: () {
      setState(() {
        _coverTranslateX = 0;
        _current = widget.music;
        _invalidatePn();
      });
    });
  }

  Future<void> _invalidatePn() async {
    if (!_previousNextDirty) {
      return;
    }
    _previousNextDirty = false;
    _previous = (await _player.getPreviousMusic(_current!.metadata)).toMusic();
    _next = (await _player.getNextMusic(_current!.metadata)).toMusic();
    if (mounted) {
      setState(() {});
    }
  }

  // 更新当前needle和封面状态
  void _checkNeedleAndCoverStatus() {
    final state = _player.playbackState;

    final bool attachToCover =
        state.isPlaying && !_beDragging && _translateController == null;
    _rotateNeedle(attachToCover);

    final _isPlaying = state.isPlaying;
    setState(() {
      _coverRotating = _isPlaying && _needleAttachCover;
    });
  }

  ///是否需要抓转Needle到封面上
  void _rotateNeedle(bool attachToCover) {
    if (_needleAttachCover == attachToCover) {
      return;
    }
    _needleAttachCover = attachToCover;
    if (attachToCover) {
      _needleController.forward(from: _needleController.value);
    } else {
      _needleController.reverse(from: _needleController.value);
    }
  }

  @override
  void dispose() {
    _player.removeListener(_checkNeedleAndCoverStatus);
    _needleController.dispose();
    _translateController?.dispose();
    _translateController = null;
    super.dispose();
  }

  static double kHeightSpaceAlbumTop = Adapt.px(70);

  void _animateCoverTranslateTo(double des, {void Function()? onCompleted}) {
    _translateController?.dispose();
    _translateController = null;
    _translateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    final animation =
        Tween(begin: _coverTranslateX, end: des).animate(_translateController!);
    animation.addListener(() {
      setState(() {
        _coverTranslateX = animation.value;
      });
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _translateController?.dispose();
        _translateController = null;
        if (onCompleted != null) {
          onCompleted();
        }
      }
    });
    _translateController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      assert(constraints.maxWidth.isFinite,
          "the width of cover layout should be constrainted!");
      return ClipRect(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: _build(context, constraints.maxWidth),
      ));
    });
  }

  Widget _build(BuildContext context, double layoutWidth) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onHorizontalDragStart: (detail) {
            _beDragging = true;
            _checkNeedleAndCoverStatus();
          },
          onHorizontalDragUpdate: (detail) {
            if (_beDragging) {
              setState(() {
                _coverTranslateX += detail.primaryDelta!;
              });
            }
          },
          onHorizontalDragEnd: (detail) {
            _beDragging = false;

            //左右切换封面滚动速度阈值
            final vThreshold =
                1.0 / (0.050 * MediaQuery.of(context).devicePixelRatio);

            final sameDirection =
                (_coverTranslateX > 0 && detail.primaryVelocity! > 0) ||
                    (_coverTranslateX < 0 && detail.primaryVelocity! < 0);
            if (_coverTranslateX.abs() > layoutWidth / 2 ||
                (sameDirection && detail.primaryVelocity!.abs() > vThreshold)) {
              var des = MediaQuery.of(context).size.width;
              if (_coverTranslateX < 0) {
                des = -des;
              }
              _animateCoverTranslateTo(des, onCompleted: () {
                setState(() {
                  //reset translateX to 0 when animation complete
                  _coverTranslateX = 0;
                  if (des > 0) {
                    logger.d('animateCover _previous');
                    _current = _previous;
                    context.transportControls.skipToPrevious();
                  } else {
                    logger.d('animateCover _next');
                    _current = _next;
                    context.transportControls.skipToNext();
                  }
                  _previousNextDirty = true;
                });
              });
            } else {
              //animate [_coverTranslateX] to 0
              _animateCoverTranslateTo(0, onCompleted: () {
                _checkNeedleAndCoverStatus();
              });
            }
          },
          child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: kHeightSpaceAlbumTop),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    ImageUtils.getImagePath('play_disc_mask'),
                    fit: BoxFit.cover,
                  ),
                  Transform.translate(
                    offset: Offset(_coverTranslateX - layoutWidth, 0),
                    child: RotationCoverImage(
                      rotating: false,
                      music: _previous,
                      pading: Dimens.gap_dp60,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(_coverTranslateX, 0),
                    child: Hero(
                        tag: HERO_TAG_CUR_PLAY,
                        child: RotationCoverImage(
                          rotating: _coverRotating && !_beDragging,
                          music: _current,
                          pading: Dimens.gap_dp60,
                        )),
                  ),
                  Transform.translate(
                    offset: Offset(_coverTranslateX + layoutWidth, 0),
                    child: RotationCoverImage(
                      rotating: false,
                      music: _next,
                      pading: Dimens.gap_dp60,
                    ),
                  ),
                ],
              )),
        ),
        ClipRect(
          child: Align(
            alignment: const Alignment(0, -1),
            child: Transform.translate(
              offset: const Offset(30, -12),
              child: RotationTransition(
                turns: _needleAnimation,
                alignment:
                    //计算旋转中心点的偏移,以保重旋转动画的中心在针尾圆形的中点
                    Alignment(-1 + Adapt.px(23) * 2 / Adapt.px(91.1),
                        -1 + Adapt.px(23) * 2 / Adapt.px(147)),
                child: Image.asset(
                  ImageUtils.getImagePath('play_needle_play'),
                  height: kHeightSpaceAlbumTop * 2.2,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
