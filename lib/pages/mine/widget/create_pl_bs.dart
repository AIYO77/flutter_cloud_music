import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/widgets/round_checkbox.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../mine_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/8 7:47 下午
/// Des:

class CreatePlBottomSheet extends StatefulWidget {
  static void show(BuildContext context) {
    Get.bottomSheet(CreatePlBottomSheet(),
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimens.gap_dp16),
            topLeft: Radius.circular(Dimens.gap_dp16),
          ),
        ),
        backgroundColor: context.theme.cardColor);
  }

  @override
  _State createState() => _State();
}

class _State extends State<CreatePlBottomSheet> {
  final controller = GetInstance().find<MineController>();

  String? _plName;

  late TextEditingController _editingController;

  final int _nameMaxLength = 20;

  //歌单类型,默认'NORMAL',传 'VIDEO'则为视频歌单
  String _plType = 'NORMAL';

  //是否设置为隐私歌单，默认否，传'10'则设置成隐私歌单
  String? _plPrivacy;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _editingController = TextEditingController();
    _editingController.addListener(() {
      setState(() {
        _plName = _editingController.text;
      });
      if (_editingController.text.length >= _nameMaxLength) {
        EasyLoading.showError('字数超过限制');
      }
    });
    Future.delayed(const Duration(milliseconds: 100))
        .whenComplete(() => FocusScope.of(context).requestFocus(_focusNode));
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: Dimens.gap_dp15,
          right: Dimens.gap_dp15,
          top: Dimens.gap_dp17,
          bottom: Dimens.gap_dp17),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimens.gap_dp16),
          topLeft: Radius.circular(Dimens.gap_dp16),
        ),
        gradient: context.isDarkMode
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                    Colors.white12,
                    Colors.white.withOpacity(0.05),
                  ])
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  '取消',
                  style: body2Style().copyWith(fontSize: Dimens.font_sp18),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (GetUtils.isNullOrBlank(_plName) != true) {
                    context.hideKeyboard();
                    controller.createPlaylist(_plName!, _plType, _plPrivacy);
                  }
                },
                child: Opacity(
                  opacity: GetUtils.isNullOrBlank(_plName) == true ? 0.3 : 1.0,
                  child: Text(
                    '完成',
                    style: body2Style().copyWith(fontSize: Dimens.font_sp18),
                  ),
                ),
              )
            ],
          ),
          Gaps.vGap12,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _plType = 'NORMAL';
                  });
                },
                behavior: HitTestBehavior.translucent,
                child: Opacity(
                  opacity: _plType == 'NORMAL' ? 1.0 : 0.3,
                  child: Text(
                    '音乐歌单',
                    style: headlineStyle().copyWith(
                        fontSize: Dimens.font_sp18,
                        fontWeight: _plType == 'NORMAL'
                            ? FontWeight.w500
                            : FontWeight.normal),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp12),
                child: Container(
                  width: 0.5,
                  height: Dimens.gap_dp16,
                  color: context.theme.dividerColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _plType = 'VIDEO';
                  });
                },
                behavior: HitTestBehavior.translucent,
                child: Opacity(
                  opacity: _plType == 'VIDEO' ? 1.0 : 0.3,
                  child: Text(
                    '视频歌单',
                    style: headlineStyle().copyWith(
                        fontSize: Dimens.font_sp18,
                        fontWeight: _plType == 'VIDEO'
                            ? FontWeight.w500
                            : FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
          Gaps.vGap15,
          Row(
            children: [
              Expanded(
                  child: TextField(
                focusNode: _focusNode,
                maxLength: _nameMaxLength,
                controller: _editingController,
                style: body2Style(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusColor: context.theme.highlightColor,
                  counterText: '',
                  constraints: BoxConstraints(maxHeight: Dimens.gap_dp50),
                  contentPadding: EdgeInsets.zero,
                  hintText: '输入新建歌单标题',
                  hintStyle: body2Style()
                      .copyWith(color: body2Style().color?.withOpacity(0.3)),
                ), // focusNode: _focusNode,
              )),
              Offstage(
                offstage: GetUtils.isNullOrBlank(_plName) == true,
                child: GestureDetector(
                    onTap: () {
                      _editingController.clear();
                    },
                    child: Icon(
                      Icons.cancel,
                      size: Dimens.gap_dp20,
                      color: Colors.grey.shade400,
                    )),
              )
            ],
          ),
          Gaps.vGap15,
          GestureDetector(
            onTap: () {
              setState(() {
                if (_plPrivacy == null) {
                  _plPrivacy = '10';
                } else {
                  _plPrivacy = null;
                }
              });
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RoundCheckBox(
                    null,
                    value: GetUtils.isNullOrBlank(_plPrivacy) != true,
                    size: 16,
                  ),
                  Gaps.hGap4,
                  Text(
                    '设置为隐私歌单',
                    style: captionStyle().copyWith(fontSize: Dimens.font_sp13),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
