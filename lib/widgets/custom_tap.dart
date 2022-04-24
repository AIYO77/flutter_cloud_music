import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Duration duration;
  final double scaleFactor;

  const Bounce({
    required this.onPressed,
    required this.child,
    this.duration = const Duration(milliseconds: 100),
    this.scaleFactor = 1.25,
  });

  @override
  BounceState createState() => BounceState();
}

class BounceState extends State<Bounce> with SingleTickerProviderStateMixin {
  late double _scale;

  late AnimationController _animate;

  VoidCallback get onPressed => widget.onPressed;

  Duration get userDuration => widget.duration;

  double get scaleFactor => widget.scaleFactor;

  @override
  void initState() {
    _animate = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - (_animate.value * scaleFactor);
    return GestureDetector(
        onTap: _onTap,
        behavior: HitTestBehavior.translucent,
        child: Transform.scale(
          scale: _scale,
          child: Opacity(
            opacity: _scale,
            child: widget.child,
          ),
        ));
  }

  void _onTap() {
    _animate.forward();

    //持续时间之后反转动画
    Future.delayed(userDuration, () {
      _animate.reverse();

      onPressed();
    });
  }
}
