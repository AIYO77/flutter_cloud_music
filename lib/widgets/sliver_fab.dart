import 'package:flutter/material.dart';

class SliverFab extends StatefulWidget {
  final List<Widget> slivers;

  ///widget
  final PreferredSizeWidget floatingWidget;

  ///FlexibleAppBar 展开的高度
  final double expandedHeight;

  ///距离顶部多少开始收缩
  final double topScalingEdge;

  ///widget位置
  final FloatingPosition floatingPosition;

  const SliverFab({
    required this.slivers,
    required this.floatingWidget,
    this.floatingPosition = const FloatingPosition(right: 16.0),
    this.expandedHeight = 256.0,
    this.topScalingEdge = 96.0,
  });

  @override
  State<StatefulWidget> createState() {
    return SliverFabState();
  }
}

class SliverFabState extends State<SliverFab> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          slivers: widget.slivers,
        ),
        _buildFab(),
      ],
    );
  }

  Widget _buildFab() {
    final double defaultTopMargin = widget.expandedHeight +
        (widget.floatingPosition.top ?? 0) -
        widget.floatingWidget.preferredSize.height / 2;

    final double scale0edge = widget.expandedHeight - kToolbarHeight;
    final double scale1edge = defaultTopMargin - widget.topScalingEdge;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (scrollController.hasClients) {
      final double offset = scrollController.offset;
      top -= offset > 0 ? offset : 0;
      if (offset < scale1edge) {
        scale = 1.0;
      } else if (offset > scale0edge) {
        scale = 0.0;
      } else {
        scale = (scale0edge - offset) / (scale0edge - scale1edge);
      }
    }
    return Positioned(
      top: top,
      right: widget.floatingPosition.right,
      left: widget.floatingPosition.left,
      child: Transform(
        transform: Matrix4.identity()..scale(scale, scale),
        alignment: Alignment.center,
        child: Opacity(
          opacity: scale > 0.8 ? scale : 0,
          child: widget.floatingWidget,
        ),
      ),
    );
  }
}

class FloatingPosition {
  final double? top;

  final double? right;

  final double? left;

  const FloatingPosition({this.top, this.right, this.left});
}
