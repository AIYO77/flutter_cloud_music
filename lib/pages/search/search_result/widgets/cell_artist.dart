import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/follow/follow_widget.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:flutter_cloud_music/widgets/user_avatar.dart';
import 'package:get/get.dart';

import '../../../../common/model/artists_model.dart';
import '../../../../common/res/dimens.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 8:14 下午
/// Des:

class SearchArtistCell extends StatelessWidget {
  final Artists artist;

  final String keywords;

  const SearchArtistCell({required this.artist, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Bounce(
        onPressed: () {
          toUserDetail(artistId: artist.id, accountId: artist.accountId);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp3),
          child: Row(
            children: [
              UserAvatar(
                avatar: artist.img1v1Url,
                size: Dimens.gap_dp50,
                identityIconUrl: artist.identityIconUrl,
              ),
              Gaps.hGap10,
              Expanded(
                child: RichTextWidget(
                  Text(
                    artist.getArName(),
                    style: headline2Style(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  richTexts: [
                    BaseRichText(
                      keywords,
                      style: headline2Style().copyWith(
                        fontWeight: FontWeight.normal,
                        color: context.theme.highlightColor,
                      ),
                    )
                  ],
                ),
              ),
              Gaps.hGap10,
              SizedBox(
                height: Dimens.gap_dp26,
                width: Dimens.gap_dp64,
                child: FollowWidget(Key(artist.id.toString()),
                    id: artist.id.toString(), isFollowed: artist.followed),
              )
            ],
          ),
        ));
  }
}
