import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/res/gaps.dart';
import '../common/utils/image_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/11 8:25 下午
/// Des:

class UserAvatar extends StatelessWidget {
  final String avatar;
  final double size;
  final String? identityIconUrl;
  final String? holderAsset;

  const UserAvatar(
      {required this.avatar,
      this.size = 35,
      this.identityIconUrl,
      this.holderAsset});

  @override
  Widget build(BuildContext context) {
    final sizeL = Size(size, size);
    return CachedNetworkImage(
      imageUrl: ImageUtils.getImageUrlFromSize(avatar, sizeL),
      errorWidget: (context, url, e) {
        if (holderAsset != null) {
          return ClipOval(
            child: Image.asset(
              holderAsset!,
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
          );
        }
        return Gaps.ovalImgHolder(sizeL);
      },
      placeholder: (context, url) {
        if (holderAsset != null) {
          return ClipOval(
            child: Image.asset(
              holderAsset!,
              fit: BoxFit.cover,
              width: size,
              height: size,
            ),
          );
        }
        return Gaps.ovalImgHolder(sizeL);
      },
      imageBuilder: (context, provider) {
        return SizedBox(
          width: identityIconUrl == null ? size : size * 1.2,
          height: size,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipOval(
                child: Image(
                  image: provider,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                ),
              ),
              if (identityIconUrl != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ClipOval(
                    child: CachedNetworkImage(
                        width: 0.48 * size,
                        height: 0.48 * size,
                        imageUrl: identityIconUrl!),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
