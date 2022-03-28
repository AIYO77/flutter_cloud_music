/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/25 4:53 下午
/// Des:
import 'package:flutter/material.dart';

class Tapped extends StatefulWidget {
  final Widget? child;
  final Function? onTap;
  final Function? onLongTap;

  const Tapped({
    Key? key,
    this.onTap,
    this.onLongTap,
    this.child,
  }) : super(key: key);

  @override
  _TappedState createState() => _TappedState();
}

class _TappedState extends State<Tapped> with TickerProviderStateMixin {
  bool _isChangeAlpha = false;

  AnimationController? _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(value: 1, vsync: this);
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOutCubic,
    );
    _animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  bool _tapDown = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Duration duration = Duration(milliseconds: 50);
    const Duration showDuration = Duration(milliseconds: 660);

    return GestureDetector(
      onTap: () async {
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onTap?.call();
      },
      onLongPress: widget.onLongTap == null
          ? null
          : () async {
              await Future.delayed(const Duration(milliseconds: 100));
              widget.onLongTap!();
            },
      onTapDown: (detail) async {
        _tapDown = true;
        _isChangeAlpha = true;
        await _controller!.animateTo(0.4, duration: duration);
        if (!_tapDown) {
          await _controller!.animateTo(1, duration: showDuration);
        }
        _tapDown = false;
        _isChangeAlpha = false;
      },
      onTapUp: (detail) async {
        _tapDown = false;
        if (_isChangeAlpha == true) {
          return;
        }
        await _controller!.animateTo(1, duration: showDuration);
        _isChangeAlpha = false;
      },
      onTapCancel: () async {
        _tapDown = false;
        _controller!.value = 1;
        _isChangeAlpha = false;
      },
      child: Opacity(
        opacity: _animation.value,
        child: Container(
          color: const Color(0x00000000),
          child: widget.child,
        ),
      ),
    );
  }
}
