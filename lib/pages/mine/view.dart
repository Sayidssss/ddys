import 'package:ddys/common/MyDatabase.dart';
import 'package:flutter/material.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class MinePage extends GetView<MineController> {
  const MinePage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[
      ListTileX(
        title: '自动播放下一个',
        trailing: Switch(
            value: controller.isAutoNext,
            onChanged: (b) {
              controller.setAutoNext(b);
            }),
      ),
      ListTileX(
        title: '自动打开字幕',
        trailing: Switch(
            value: controller.isAutoSub,
            onChanged: (b) {
              controller.setAutoSub(b);
            }),
      ),
      ListTileX(
        title: '自动加入播放记录',
        trailing: Switch(
            value: controller.isAutoFav,
            onChanged: (b) {
              controller.setAutoFav(b);
            }),
      ),
      ListTileX(
        title: '清理播放记录',
        onTap: () {
          Get.defaultDialog(
            title: '提示',
            content: TextX.bodyMedium('清理所有播放记录?'),
            textConfirm: '确认',
            textCancel: '取消',
            onConfirm: () {
              DatabaseHelper.db.deleteAll();
              showToast('清理成功');
            },
            onCancel: () {},
          );
        },
      ),
      ListTileX(
        title: '清理播放缓存',
        onTap: () {
          Get.defaultDialog(
            title: '提示',
            content: TextX.bodyMedium('清理播放缓存?'),
            textConfirm: '确认',
            textCancel: '取消',
            onConfirm: () {
              showToast('清理成功');
            },
            onCancel: () {},
          );
        },
      ),
      ListTileX(
        title: '选择域名',
        onTap: () {
          Get.defaultDialog(
            title: '选择域名',
            content: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTileX(
                  title: '域名 ${index + 1}',
                  subTitle: controller.domainList[index],
                );
              },
              itemCount: controller.domainList.length,
            ),
          );
        },
      ),
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
