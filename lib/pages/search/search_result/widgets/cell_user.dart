import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:get/get.dart';

import '../../../../common/res/gaps.dart';
import '../../../../common/utils/common_utils.dart';
import '../../../../widgets/rich_text_widget.dart';
import '../../../../widgets/user_avatar.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/29 5:47 下午
/// Des:

class SearchUserCell extends StatelessWidget {
  final UserInfo userInfo;

  final String keywords;

  const SearchUserCell({required this.userInfo, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Bounce(
        onPressed: () {
          toUserDetail(accountId: userInfo.userId.toString());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp3),
          child: Row(
            children: [
              UserAvatar(
                avatar: userInfo.avatarUrl,
                size: Dimens.gap_dp50,
                identityIconUrl: userInfo.avatarDetail?.identityIconUrl,
              ),
              Gaps.hGap10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichTextWidget(
                      Text(
                        userInfo.nickname,
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
                    Gaps.vGap7,
                    if (userInfo.avatarDetail?.userType == 4)
                      Text(
                        '网易音乐人',
                        style: captionStyle(),
                      )
                    else if (!GetUtils.isNullOrBlank(userInfo.description)!)
                      Text(
                        userInfo.description!,
                        style: captionStyle(),
                      )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
