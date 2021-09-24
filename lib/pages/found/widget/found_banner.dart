import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/model/banner_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/services/home_top_service.dart';
import 'package:flutter_cloud_music/widgets/banner_pagination_builder.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class FoundBanner extends StatefulWidget {
  const FoundBanner(this.bannerModel, {required this.itemHeight});

  final BannerModel bannerModel;
  final double itemHeight;

  @override
  State<StatefulWidget> createState() {
    return FoundBannerState();
  }
}

class FoundBannerState extends State<FoundBanner> {
  final imageMap = HashMap<int, ImageProvider>();

  late SwiperController controller;

  Future<void> _updatePaletteGenerator(ImageProvider image) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      image,
    );
    final dominColor =
        paletteGenerator.dominantColor?.color ?? Colors.transparent;
    HomeTopService.to.appBarBgColors.value =
        Get.isDarkMode ? dominColor.withOpacity(0.5) : dominColor;
  }

  Widget _buildItem(int index) {
    final banner = widget.bannerModel.banner[index];
    return Container(
      margin: EdgeInsets.fromLTRB(
          Dimens.gap_dp15, Dimens.gap_dp5, Dimens.gap_dp15, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimens.gap_dp12),
        child: CachedNetworkImage(
          imageUrl: ImageUtils.getImageUrlFromSize(
              banner.pic, Size(Adapt.screenW() - Adapt.px(30), Adapt.px(135))),
          placeholder: (context, url) {
            return Container(
              color: Colours.load_image_placeholder,
            );
          },
          imageBuilder: (context, imageProvider) {
            if (!imageMap.containsValue(imageProvider)) {
              _updatePaletteGenerator(imageProvider);
              imageMap[index] = imageProvider;
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
                                : Colours.blue,
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
    controller = SwiperController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.itemHeight,
      child: Stack(
        children: [
          Obx(() => Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Get.theme.cardColor.withAlpha(10),
                  Get.theme.cardColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Container(
                  decoration: HomeTopService.to.isScrolled.value
                      ? BoxDecoration(color: Get.theme.cardColor)
                      : BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                HomeTopService.to.appBarBgColors.value
                                    .withAlpha(15),
                                Colors.transparent
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                ),
              )),
          Swiper(
              itemBuilder: (context, index) {
                return _buildItem(index);
              },
              autoplay: true,
              autoplayDelay: 6000,
              onIndexChanged: (index) async {
                if (imageMap.containsKey(index)) {
                  _updatePaletteGenerator(imageMap[index]!);
                }
              },
              pagination: SwiperPagination(
                builder: BannerPaginationBuilder(
                    color: Colours.white.withAlpha(80),
                    size: const Size(14, 3),
                    activeSize: const Size(14, 3),
                    space: 4,
                    activeColor: Colours.white),
              ),
              controller: controller,
              itemCount: widget.bannerModel.banner.length),
        ],
      ),
    );
  }
}
