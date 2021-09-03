import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:get/get.dart';

class TabWidget extends StatefulWidget {
  final List<Widget> tabItems;

  final ValueChanged<int>? onPageChanged;

  final IndexedWidgetBuilder pageItemBuilder;

  final int initTabIndex;

  const TabWidget({
    Key? key,
    required this.tabItems,
    this.initTabIndex = 0,
    required this.pageItemBuilder,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _PlayListTabBarState createState() => _PlayListTabBarState();
}

class _PlayListTabBarState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: widget.tabItems.length,
        initialIndex: widget.initTabIndex);

    _pageController = PageController(initialPage: widget.initTabIndex);
  }

  late TabController _tabController;
  late PageController _pageController;

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Get.theme.cardColor,
          child: Stack(
            children: [
              SizedBox(
                height: Dimens.gap_dp40,
                child: TabBar(
                  labelPadding: EdgeInsets.only(
                      left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                  isScrollable: true,
                  padding: EdgeInsets.only(top: Dimens.gap_dp4),
                  labelColor: Get.isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 51, 51, 51),
                  labelStyle: TextStyle(
                      fontSize: Dimens.font_sp15, fontWeight: FontWeight.w500),
                  unselectedLabelColor: Get.isDarkMode
                      ? Colors.white.withOpacity(0.8)
                      : const Color.fromARGB(255, 114, 114, 114),
                  unselectedLabelStyle: TextStyle(
                      fontSize: Dimens.font_sp15,
                      fontWeight: FontWeight.normal),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(
                      // left: Dimens.gap_dp5,
                      bottom: Dimens.gap_dp9,
                      top: Dimens.gap_dp21),
                  indicator: BoxDecoration(
                      color: Colours.indicator_color,
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
                  controller: _tabController,
                  onTap: _changeTab,
                  tabs: widget.tabItems,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: widget.pageItemBuilder,
            itemCount: widget.tabItems.length,
            controller: _pageController,
            onPageChanged: _pageChanged,
          ),
        )
      ],
    );
  }

  void _changeTab(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _pageChanged(int index) {
    _tabController.animateTo(index);
  }
}
