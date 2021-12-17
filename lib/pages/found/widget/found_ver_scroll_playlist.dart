import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:get/get.dart';

class FoundVerScrollPlayList extends StatefulWidget {
  List<Resources> resources;

  FoundVerScrollPlayList({Key? key, required this.resources}) : super(key: key);

  @override
  FoundVerScrollPlayListState createState() => FoundVerScrollPlayListState();
}

class FoundVerScrollPlayListState extends State<FoundVerScrollPlayList> {
  final res = Rx<Resources?>(null);

  late SwiperController controller;

  @override
  void initState() {
    controller = SwiperController();
    super.initState();
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
  Widget build(BuildContext context) {
    res.value = widget.resources.first;
    return Bounce(
        child: SizedBox(
          width: Dimens.gap_dp109,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: Dimens.gap_dp105,
                    height: Dimens.gap_dp105,
                    decoration: BoxDecoration(
                        color: Get.theme.scaffoldBackgroundColor,
                        border: Border.all(
                            color: Colours.color_217, width: Dimens.gap_dp1),
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
                    child: Gaps.empty,
                  ),
                  Positioned.fill(
                      child: Swiper(
                    index: 0,
                    itemCount: widget.resources.length,
                    itemBuilder: (context, index) {
                      final resource = widget.resources.elementAt(index);
                      return ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
                        child: CachedNetworkImage(
                          width: Dimens.gap_dp105,
                          height: Dimens.gap_dp105,
                          placeholder: (context, url) {
                            return Container(
                              color: Colours.load_image_placeholder(),
                            );
                          },
                          imageUrl: ImageUtils.getImageUrlFromSize(
                              resource.uiElement.image?.imageUrl,
                              Size(Dimens.gap_dp105, Dimens.gap_dp105)),
                        ),
                      );
                    },
                    onIndexChanged: (index) {
                      res.value = widget.resources.elementAt(index);
                    },
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    itemHeight: Dimens.gap_dp105,
                    itemWidth: Dimens.gap_dp105,
                    autoplay: true,
                    autoplayDelay: 4000,
                    duration: 600,
                    scale: 0.8,
                  )),
                  Positioned(
                      right: Dimens.gap_dp4,
                      child: Image.asset(
                        ImageUtils.getImagePath('icon_meta'),
                        width: Dimens.gap_dp25,
                      )),
                ],
              ),
              Gaps.vGap5,
              //标题
              Obx(() => Text(
                    res.value?.uiElement.mainTitle?.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: captionStyle(),
                  ))
            ],
          ),
        ),
        onPressed: () {
          Get.toNamed('/playlist/${res.value?.resourceId}');
        });
  }
}
