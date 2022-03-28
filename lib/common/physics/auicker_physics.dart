import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/21 3:43 下午
/// Des:
class QuickerScrollPhysics extends BouncingScrollPhysics {
  const QuickerScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  QuickerScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return QuickerScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => SpringDescription.withDampingRatio(
        mass: 0.2,
        stiffness: 300.0,
        ratio: 1.1,
      );
}
