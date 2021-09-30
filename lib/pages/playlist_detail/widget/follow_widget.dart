import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:lottie/lottie.dart';

class CreatorFollowWidget extends StatefulWidget {
  final bool followed;
  const CreatorFollowWidget({required this.followed});
  @override
  _CreatorFollowState createState() => _CreatorFollowState();
}

class _CreatorFollowState extends State<CreatorFollowWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: GestureDetector(
        onTap: () {
          _controller.forward();
        },
        child: Lottie.asset(ImageUtils.getAnimPath('follow'),
            controller: _controller,
            repeat: false,
            fit: BoxFit.contain,
            animate: false, onLoaded: (composition) {
          _controller.duration = composition.duration;
          // _controller.animateTo(composition.duration.);
        }),
      ),
    );
  }
}
