import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class MinePage extends GetView<MineController> {
  const MinePage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[
      SwitchListTile(
        title: TextX.labelLarge('自动播放下一个'),
        value: controller.isAutoNext,
        onChanged: (b) {
          controller.isAutoNext = b;
          controller.updateUi();
        },
      ),
      SwitchListTile(
        title: TextX.labelLarge('自动打开字幕'),
        value: controller.isAutoNext,
        onChanged: (b) {
          controller.isAutoNext = b;
          controller.updateUi();
        },
      ),
      SwitchListTile(
        title: TextX.labelLarge('自动收藏(播放十分钟后)'),
        value: controller.isAutoNext,
        onChanged: (b) {
          controller.isAutoNext = b;
          controller.updateUi();
        },
      ),
      ListTileX(title: '清理播放记录'),
      ListTileX(title: '清理播放缓存'),
      ListTileX(title: '选择域名'),
      ListTileX(title: '选择线路'),
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .padding(all: 10.w, bottom: 50.w)
        .scrollable(primary: true)
        .scrollbar()
        .width(1.sw);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MineController>(
      init: MineController(),
      id: 'mine',
      builder: (_) {
        return Scaffold(
          extendBody: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: Text('设置'), elevation: 1),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
