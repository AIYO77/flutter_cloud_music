import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class RoundCheckBox extends StatefulWidget {
  bool value = false;

  // final ParamSingleCallback<bool> onChanged;

  RoundCheckBox(Key? key, {required this.value}) : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: GestureDetector(
      //   onTap: () {
      //     widget.value = !widget.value;
      //     widget.onChanged.call(widget.value);
      //     setState(() {});
      //   },
      child: widget.value
          ? ClipOval(
              child: Container(
                width: Dimens.gap_dp22,
                height: Dimens.gap_dp22,
                color: Colours.app_main_light,
                child: Image.asset(
                  ImageUtils.getImagePath('icn_check'),
                  width: Dimens.gap_dp13,
                  color: Colours.white,
                ),
              ),
            )
          : Image.asset(
              ImageUtils.getImagePath('icn_checkbox'),
              width: Dimens.gap_dp22,
              height: Dimens.gap_dp22,
              color: Colours.text_gray,
            ),
      // ),
    );
  }
}
