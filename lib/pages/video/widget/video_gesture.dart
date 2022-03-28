import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/values/server.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/28 11:06 上午
/// Des:手势封装 (单击：暂停 , 双击：点赞)

class VideoGesture extends StatefulWidget {
  const VideoGesture({
    Key? key,
    required this.child,
    this.onAddFavorite,
    this.onSingleTap,
  }) : super(key: key);

  final Function? onAddFavorite;
  final Function? onSingleTap;
  final Widget child;

  @override
  _VideoGestureState createState() => _VideoGestureState();
}

class _VideoGestureState extends State<VideoGesture> {
  final GlobalKey _key = GlobalKey();

  // 内部转换坐标点
  Offset _p(Offset p) {
    final RenderBox getBox =
        _key.currentContext!.findRenderObject()! as RenderBox;
    return getBox.globalToLocal(p);
  }

  List<Offset> icons = [];

  bool canAddFavorite = false;
  bool justAddFavorite = false;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    final iconStack = Stack(
      children: icons
          .map<Widget>(
            (p) => TikTokFavoriteAnimationIcon(
              key: Key(p.toString()),
              position: p,
              onAnimationComplete: () {
                icons.remove(p);
              },
            ),
          )
          .toList(),
    );
    return GestureDetector(
      key: _key,
      onTapDown: (detail) {
        setState(() {
          if (canAddFavorite) {
            logger.d('添加爱心，当前爱心数量:${icons.length}');
            icons.add(_p(detail.globalPosition));
            widget.onAddFavorite?.call();
            justAddFavorite = true;
          } else {
            justAddFavorite = false;
          }
        });
      },
      onTapUp: (detail) {
        timer?.cancel();
        final delay = canAddFavorite ? 1200 : 600;
        timer = Timer(Duration(milliseconds: delay), () {
          canAddFavorite = false;
          timer = null;
          if (!justAddFavorite) {
            widget.onSingleTap?.call();
          }
        });
        canAddFavorite = true;
      },
      onTapCancel: () {
        logger.d('onTapCancel');
      },
      child: Stack(
        children: <Widget>[
          widget.child,
          iconStack,
        ],
      ),
    );
  }
}

class TikTokFavoriteAnimationIcon extends StatefulWidget {
  final Offset? position;
  final double size;
  final Function? onAnimationComplete;

  const TikTokFavoriteAnimationIcon({
    Key? key,
    this.onAnimationComplete,
    this.position,
    this.size = 100,
  }) : super(key: key);

  @override
  _TikTokFavoriteAnimationIconState createState() =>
      _TikTokFavoriteAnimationIconState();
}

class _TikTokFavoriteAnimationIconState
    extends State<TikTokFavoriteAnimationIcon> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    logger.d('didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    );

    _animationController!.addListener(() {
      setState(() {});
    });
    startAnimation();
    super.initState();
  }

  Future<void> startAnimation() async {
    await _animationController!.forward();
    widget.onAnimationComplete?.call();
  }

  double rotate = pi / 10.0 * (2 * Random().nextDouble() - 1);

  double? get value => _animationController?.value;

  double appearDuration = 0.1;
  double dismissDuration = 0.8;

  double get opa {
    if (value! < appearDuration) {
      return 0.99 / appearDuration * value!;
    }
    if (value! < dismissDuration) {
      return 0.99;
    }
    final res = 0.99 - (value! - dismissDuration) / (1 - dismissDuration);
    return res < 0 ? 0 : res;
  }

  double get scale {
    if (value! < appearDuration) {
      return 1 + appearDuration - value!;
    }
    if (value! < dismissDuration) {
      return 1;
    }
    return (value! - dismissDuration) / (1 - dismissDuration) + 1;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Icon(
      Icons.favorite,
      size: widget.size,
      color: Colors.redAccent,
    );
    content = ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => RadialGradient(
        center: Alignment.topLeft.add(const Alignment(0.66, 0.66)),
        colors: const [
          Color(0xffEF6F6F),
          Color(0xffF03E3E),
        ],
      ).createShader(bounds),
      child: content,
    );
    final Widget body = Transform.rotate(
      angle: rotate,
      child: Opacity(
        opacity: opa,
        child: Transform.scale(
          alignment: Alignment.bottomCenter,
          scale: scale,
          child: content,
        ),
      ),
    );
    return widget.position == null
        ? Container()
        : Positioned(
            left: widget.position!.dx - widget.size / 2,
            top: widget.position!.dy - widget.size / 2,
            child: body,
          );
  }
}
