import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/singer_list/model/id_name_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SingerListState {
  int page = 0;

  late ScrollController scrollController;

  //当前滚动偏移量 用来判断上滑还是下拉
  double curScrollOffset = 0.0;
  late RefreshController refreshController;

  //头部筛选动画控制器
  late AnimationController headerAnimationController;

  //是否展开筛选
  final isExpandFilter = true.obs;

  // -1:全部
  // 1:男歌手
  // 2:女歌手
  // 3:乐队
  final type = Rx<IdNameModel>(const IdNameModel(id: -1, name: '全部'));

  // -1:全部
  // 7华语
  // 96欧美
  // 8:日本
  // 16韩国
  // 0:其他
  final area = Rx<IdNameModel>(const IdNameModel(id: -1, name: '全部'));

  late List<IdNameModel> listType;

  late List<IdNameModel> listArea;

  ///按首字母索引查找参数 热门传-1,#传 0
  final initials = [
    '-1',
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z',
    '0'
  ];

  //当前请求类型
  late String curInitial;

  SingerListState() {
    curInitial = initials.elementAt(0);
    listType = List.empty(growable: true);
    listType.add(const IdNameModel(id: 1, name: '男歌手'));
    listType.add(const IdNameModel(id: 2, name: '女歌手'));
    listType.add(const IdNameModel(id: 3, name: '乐队/组合'));

    listArea = List.empty(growable: true);
    listArea.add(const IdNameModel(id: 7, name: '华语'));
    listArea.add(const IdNameModel(id: 96, name: '欧美'));
    listArea.add(const IdNameModel(id: 8, name: '日本'));
    listArea.add(const IdNameModel(id: 16, name: '韩国'));
    listArea.add(const IdNameModel(id: 0, name: '其他'));
  }

  String? getNextInitial() {
    final curIndex = initials.indexOf(curInitial);
    if (curIndex == -1 || curIndex >= initials.length - 1) {
      return null;
    } else {
      return initials.elementAt(curIndex + 1);
    }
  }
}
