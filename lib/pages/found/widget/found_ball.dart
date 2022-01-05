import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/found_ball_model.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:get/get.dart';

class FoundBall extends StatelessWidget {
  final List<Ball> balls;

  final double itemHeight;

  const FoundBall(this.balls, {required this.itemHeight});

  Widget _buildBall(Ball ball) {
    return GestureDetector(
      onTap: () {
        RouteUtils.routeFromActionStr(ball.url);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              width: Dimens.gap_dp46,
              height: Dimens.gap_dp46,
              color: Colours.app_main.withOpacity(0.05),
              child: CachedNetworkImage(
                imageUrl: ball.iconUrl,
                fadeInDuration: const Duration(),
                imageBuilder: (context, provider) {
                  return Stack(
                    children: [
                      Image(
                        image: provider,
                        color: const Color.fromARGB(255, 238, 40, 39),
                      ),
                      if (ball.id == -1)
                        Container(
                          margin: EdgeInsets.only(top: Dimens.gap_dp5),
                          child: Center(
                            child: Text(
                              DateTime.now().day.toString(),
                              style: TextStyle(
                                  color: Get.theme.cardColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimens.font_sp12),
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
            ),
          ),
          Gaps.vGap5,
          Text(
            ball.name,
            style: body1Style().copyWith(fontSize: Dimens.font_sp12),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      color: Get.theme.cardColor,
      child: ListView.separated(
          padding:
              EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final ball = balls[index];
            return _buildBall(ball);
          },
          separatorBuilder: (context, index) {
            return Gaps.hGap24;
          },
          itemCount: balls.length),
    );
  }
}
