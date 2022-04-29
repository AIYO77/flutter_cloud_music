/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 11:18 上午
/// Des:

class BaseSearchModel {
  final String? moreText;

  final bool more;

  BaseSearchModel(this.moreText, this.more) : super();

  BaseSearchModel.fromJson(Map<String, dynamic> json)
      : moreText = json['moreText'] as String?,
        more = json['more'] as bool;
}
