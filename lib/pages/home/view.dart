import 'package:ddys/pages/anime/index.dart';
import 'package:ddys/pages/drama/index.dart';
import 'package:ddys/pages/index/index.dart';
import 'package:ddys/pages/mine/index.dart';
import 'package:ddys/pages/movie/index.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  // 主视图
  Widget _buildView() {
    return PageView(
      controller: controller.pageController,
      onPageChanged: (index) {
        controller.setIndex(index);
      },
      children: [
        const IndexPage(),
        const MoviePage(),
        const DramaPage(),
        const AnimePage(),
        const MinePage(),
      ],
    );
  }

  //导航栏
  Widget _buildNavigationBar() {
    return NavigationX(
      currentIndex: controller.pageIndex, // 当前选中的tab索引
      onTap: (index) {
        controller.setIndex(index);
      }, // 切换tab事件
      items: [
        NavigationItemModel(
          label: '首页',
          icon: AntdIcon.home,
          selectedIcon: AntdIcon.home_fill,
        ),
        NavigationItemModel(
          label: '电影',
          icon: AntdIcon.video,
          selectedIcon: AntdIcon.video_fill,
        ),
        NavigationItemModel(
          label: '剧集',
          icon: AntdIcon.calendar,
          selectedIcon: AntdIcon.calendar_fill,
        ),
        NavigationItemModel(
          label: '动画',
          icon: AntdIcon.bell,
          selectedIcon: AntdIcon.bell_fill,
        ),
        NavigationItemModel(
          label: '设置',
          icon: AntdIcon.setting,
          selectedIcon: AntdIcon.setting_fill,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      id: 'home',
      builder: (_) {
        return Scaffold(
          extendBody: false,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: _buildNavigationBar(),
          body: _buildView(),
        );
      },
    );
  }
}
