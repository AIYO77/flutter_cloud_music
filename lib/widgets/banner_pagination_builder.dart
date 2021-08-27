import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class BannerPaginationBuilder extends SwiperPlugin {
  final Color? activeColor;

  final Color? color;

  final Size activeSize;

  final Size size;

  final double space;

  final Key? key;

  const BannerPaginationBuilder({
    this.activeColor,
    this.color,
    this.key,
    this.size = const Size(10.0, 2.0),
    this.activeSize = const Size(10.0, 2.0),
    this.space = 3.0,
  });

  @override
  Widget build(BuildContext context, SwiperPluginConfig? config) {
    final themeData = Theme.of(context);
    final activeColor = this.activeColor ?? themeData.primaryColor;
    final color = this.color ?? themeData.scaffoldBackgroundColor;

    final list = <Widget>[];

    if (config!.itemCount! > 20) {
      debugPrint(
        'The itemCount is too big, we suggest use FractionPaginationBuilder '
        'instead of DotSwiperPaginationBuilder in this situation',
      );
    }

    final itemCount = config.itemCount!;
    final activeIndex = config.activeIndex;

    for (var i = 0; i < itemCount; ++i) {
      final active = i == activeIndex;
      final size = active ? activeSize : this.size;
      list.add(SizedBox(
        width: size.width,
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
              color: active ? activeColor : color,
              borderRadius: BorderRadius.circular(size.height / 2)),
          key: Key('pagination_$i'),
          // margin: EdgeInsets.all(space),
          margin: EdgeInsets.only(right: space),
        ),
      ));
    }

    if (config.scrollDirection == Axis.vertical) {
      return Column(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    } else {
      return Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: list,
      );
    }
  }
}
