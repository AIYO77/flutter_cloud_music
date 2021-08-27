import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

// ignore: must_be_immutable
class FrameAnimationImage extends StatefulWidget {
  final List<String> _assetList;
  final double width;
  final double height;
  Color? imgColor;
  bool start;
  int interval;

  FrameAnimationImage(Key key, this._assetList,
      {required this.width,
      required this.height,
      this.imgColor,
      this.interval = 200,
      this.start = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FrameAnimationImageState();
  }
}

class FrameAnimationImageState extends State<FrameAnimationImage>
    with SingleTickerProviderStateMixin {
  // 动画控制
  late Animation<double> _animation;
  late AnimationController _controller;
  int interval = 200;

  @override
  void initState() {
    super.initState();

    interval = widget.interval;
    final int imageCount = widget._assetList.length;
    final int maxTime = interval * imageCount;

    // 启动动画controller
    _controller = AnimationController(
        duration: Duration(milliseconds: maxTime), vsync: this);
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(from: 0.0); // 完成后重新开始
      }
    });

    _animation =
        Tween<double>(begin: 0, end: imageCount.toDouble()).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    if (widget.start) {
      _controller.forward();
    }
  }

  void startAnimation() => _controller.forward();
  void stopAnimation() => _controller.stop();
  void reStartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  void didUpdateWidget(FrameAnimationImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int ix = _animation.value.floor() % widget._assetList.length;

    final List<Widget> images = [];
    // 把所有图片都加载进内容，否则每一帧加载时会卡顿
    for (int i = 0; i < widget._assetList.length; ++i) {
      if (i != ix) {
        images.add(Image.asset(
          ImageUtils.getImagePath(widget._assetList[i]),
          width: 0,
          height: 0,
        ));
      }
    }

    images.add(Image.asset(
      ImageUtils.getImagePath(widget._assetList[ix]),
      width: widget.width,
      height: widget.height,
      color: widget.imgColor,
    ));

    return Stack(alignment: AlignmentDirectional.center, children: images);
  }
}
