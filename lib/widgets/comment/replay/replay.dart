import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/21 11:29 上午
/// Des: 发送评论

//TODO 没做完
class SendCommentWidget extends StatefulWidget {
  final String hint;

  const SendCommentWidget({required this.hint});

  @override
  _State createState() => _State();
}

class _State extends State<SendCommentWidget> {
  late TextEditingController _controller;

  late FocusNode _focusNode;

  bool showEmoji = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();
    super.initState();
    _focusNode.addListener(setState);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!_focusNode.hasFocus && !showEmoji) Gaps.line,
        Container(
          width: Adapt.screenW(),
          height: Dimens.gap_dp49,
          alignment: Alignment.center,
          padding:
              EdgeInsets.only(left: Dimens.gap_dp16, right: Dimens.gap_dp15),
          color: context.isDarkMode
              ? const Color(0xff010101)
              : const Color(0xfffefefe),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                constraints: BoxConstraints(
                    maxHeight: Dimens.gap_dp122, minHeight: Dimens.gap_dp38),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.gap_dp19),
                    color: context.isDarkMode
                        ? Colors.white12
                        : const Color(0xfff7f7f7)),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  minLines: 1,
                  style: TextStyle(
                    fontSize: Dimens.font_sp14,
                    color: headlineStyle().copyWith(
                        fontSize: Dimens.font_sp14,
                        fontWeight: FontWeight.normal),
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (str) {
                    //发送评论
                    if (_focusNode.hasFocus) _focusNode.unfocus();
                  },
                  decoration: InputDecoration(
                      hintText: widget.hint,
                      isCollapsed: true,
                      counterText: '',
                      border: InputBorder.none,
                      hintStyle: captionStyle().copyWith(
                          fontSize: Dimens.font_sp14,
                          fontWeight: FontWeight.normal)),
                ),
              )),
              Gaps.hGap12,
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (!showEmoji) {
                      setState(() {
                        showEmoji = true;
                      });
                      if (_focusNode.hasFocus) _focusNode.unfocus();
                    } else {
                      setState(() {
                        showEmoji = false;
                      });
                      if (!_focusNode.hasFocus) {
                        FocusScope.of(context).requestFocus(_focusNode);
                      }
                    }
                  });
                },
                child: Image.asset(
                  ImageUtils.getImagePath(showEmoji ? 'key_bord' : 'key_emoji'),
                  color: context.theme.iconTheme.color,
                  width: Dimens.gap_dp30,
                ),
              )
            ],
          ),
        ),
        Offstage(
          offstage: !showEmoji,
          // child:,
        )
      ],
    );
  }
}
