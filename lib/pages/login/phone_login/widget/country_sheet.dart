import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/login_api.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/model/country_list_model.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CountrySheet extends StatelessWidget {
  final controller = GetInstance().put(CountryShaeetController());

  final ParamSingleCallback<String> callback;

  CountrySheet({Key? key, required this.callback}) : super(key: key);

  static void show(ParamSingleCallback<String> callback) {
    Get.bottomSheet(
        CountrySheet(
          callback: callback,
        ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.gap_dp16),
                topRight: Radius.circular(Dimens.gap_dp16))),
        backgroundColor: Get.theme.cardColor);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adapt.screenW(),
      height: Adapt.screenH() - Adapt.topPadding(),
      child: Column(
        children: [
          SizedBox(
            height: Dimens.gap_dp44,
            child: Stack(
              children: [
                IconButton(
                  iconSize: Dimens.gap_dp20,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(ImageUtils.getImagePath('login_icn_back'),
                      color: headlineStyle().color),
                ),
                Center(
                  child: Text(
                    '选择国家和地区',
                    style: headlineStyle(),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: controller.obx(
              (state) => _buildContent(context, state),
              onEmpty: const Text("empty"),
              onError: (err) {
                Get.log(' error $err');
                toast(err.toString());
                return Gaps.empty;
              },
              onLoading: Container(
                margin: EdgeInsets.only(top: Dimens.gap_dp80),
                child: MusicLoading(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<CountryListModel>? state) {
    if (state == null) return Gaps.empty;
    return ListView.builder(
        itemCount: state.length,
        itemBuilder: (context, index) {
          return StickyHeader(
              header: Container(
                color: Get.theme.cardColor,
                height: Dimens.gap_dp30,
                padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.elementAt(index).label,
                  style: headlineStyle().copyWith(fontSize: Dimens.font_sp13),
                ),
              ),
              content: Column(
                children: _buildGroup(state.elementAt(index).countryList),
              ));
        });
  }

  List<Widget> _buildGroup(List<Country> countryList) {
    return countryList.map((e) {
      return InkWell(
        onTap: () {
          callback.call(e.code);
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
          height: Dimens.gap_dp44,
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.zh,
                    style: headline1Style().copyWith(
                        fontSize: Dimens.font_sp15,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '+${e.code}',
                    style: captionStyle().copyWith(fontSize: Dimens.font_sp13),
                  )
                ],
              )),
              Gaps.line
            ],
          ),
        ),
      );
    }).toList();
  }
}

class CountryShaeetController extends SuperController<List<CountryListModel>?> {
  @override
  Future<void> onReady() async {
    super.onReady();
    append(() => LoginApi.getCountries);
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
