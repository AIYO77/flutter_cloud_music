import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/model/banner_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/found_controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/widgets/banner_pagination_builder.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class FoundBanner extends StatefulWidget {
  const FoundBanner(Key? key, this.bannerModel, {required this.itemHeight})
      : super(key: key);

  final BannerModel bannerModel;
  final double itemHeight;

  @override
  State<StatefulWidget> createState() {
    return FoundBannerState();
  }
}

class FoundBannerState extends State<FoundBanner> {
  final imageMap = HashMap<String?, ImageProvider>();

  late SwiperController controller;

  final foundController = GetInstance().find<FoundController>();

  Future<void> _updatePaletteGenerator(String? bannerId) async {
    if (!imageMap.containsKey(bannerId)) return;
    await Future.delayed(const Duration(milliseconds: 300));
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageMap[bannerId]!,
    );
    final dominColor =
        paletteGenerator.dominantColor?.color ?? Colors.transparent;
    eventBus.fire(dominColor);
  }

  Widget _buildItem(int index) {
    final banner = widget.bannerModel.banner[index];
    return GestureDetector(
      onTap: () {
        if (banner.targetType == 1 && banner.song != null) {
          //新歌
          context.insertAndPlay(banner.song!);
        } else if (banner.targetType == 10) {
          //新碟
          Get.toNamed(Routes.ALBUM_DETAIL_ID(banner.targetId.toString()));
        } else if (banner.url != null) {
          //活动
          RouteUtils.routeFromActionStr(banner.url);
        } else {
          toast('type = ${banner.targetType} title = ${banner.typeTitle}');
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
            Dimens.gap_dp15, Dimens.gap_dp5, Dimens.gap_dp15, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.gap_dp12),
          child: CachedNetworkImage(
            imageUrl: ImageUtils.getImageUrlFromSize(banner.pic,
                Size(Adapt.screenW() - Adapt.px(30), Adapt.px(135))),
            placeholder: (context, url) {
              return Container(
                color: Colours.load_image_placeholder(),
              );
            },
            imageBuilder: (context, imageProvider) {
              if (!imageMap.containsKey(banner.bannerId)) {
                imageMap[banner.bannerId] = imageProvider;
                _updatePaletteGenerator(banner.bannerId);
              }
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (!banner.showAdTag)
                    Gaps.empty
                  else
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                          height: Dimens.gap_dp17,
                          decoration: BoxDecoration(
                              color: banner.titleColor == "red"
                                  ? Colours.app_main
                                  : context.theme.highlightColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12))),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Center(
                            child: Text(
                              banner.typeTitle!,
                              style: TextStyle(
                                  color: Colours.white,
                                  fontSize: Dimens.font_sp12),
                            ),
                          )),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    controller.stopAutoplay();
    super.deactivate();
  }

  @override
  void activate() {
    controller.startAutoplay();
    super.activate();
  }

  @override
  void initState() {
    super.initState();
    controller = SwiperController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.itemHeight,
      child: Stack(
        children: [
          Positioned.fill(
              child: Obx(() => Container(
                    color: foundController.isScrolled.value
                        ? Get.theme.cardColor
                        : Colors.transparent,
                  ))),
          Swiper(
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
              index: 0,
              autoplay: widget.bannerModel.banner.length > 1,
              autoplayDelay: 6000,
              onIndexChanged: (index) async {
                _updatePaletteGenerator(
                    widget.bannerModel.banner[index].bannerId);
              },
              pagination: widget.bannerModel.banner.length > 1
                  ? SwiperPagination(
                      builder: BannerPaginationBuilder(
                          color: Colours.white.withAlpha(80),
                          size: const Size(14, 3),
                          activeSize: const Size(14, 3),
                          space: 4,
                          activeColor: Colours.white),
                    )
                  : null,
              controller: controller,
              itemCount: widget.bannerModel.banner.length),
        ],
      ),
    );
  }
}
