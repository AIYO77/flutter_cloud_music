import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/widgets/marquee_on_demand.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class PlayingTitle extends StatelessWidget {
  final Song? song;

  const PlayingTitle({Key? key, this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: AppBar(
          elevation: 0,
          primary: false,
          leadingWidth: Dimens.gap_dp46,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: EdgeInsets.only(left: Dimens.gap_dp22),
              child: Image.asset(
                ImageUtils.getImagePath('list_icn_arr_open'),
                color: Colors.white,
              ),
            ),
          ),
          titleSpacing: 0,
          centerTitle: true,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MarqueeOnDemand(
                switchWidth: Adapt.screenW() * 2 / 3,
                text: song?.name ?? "",
                marqueeBuilder: (context, text, textStyle) => Marquee(
                  text: text,
                  style: textStyle,
                  velocity: 25,
                  blankSpace: 30,
                ),
                textBuilder: (context, text, textStyle) => Text(
                  text,
                  style: textStyle,
                ),
                textStyle: const TextStyle(fontSize: 17, color: Colors.white),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        song?.arString() ?? "",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: Dimens.font_sp13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: Dimens.gap_dp17,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ],
                ),
              )
            ],
          ),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: Dimens.gap_dp20),
                child: Image.asset(
                  ImageUtils.getImagePath('icn_share'),
                  width: Dimens.gap_dp28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
