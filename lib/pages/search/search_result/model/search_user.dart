import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/base_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 2:06 下午
/// Des:

class SearchUser extends BaseSearchModel {
  final List<UserInfo> users;

  SearchUser.fromJson(Map<String, dynamic> json)
      : users =
            (json['users'] as List).map((e) => UserInfo.fromJson(e)).toList(),
        super.fromJson(json);
}
