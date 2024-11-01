// ignore_for_file: prefer_is_empty

import 'package:ddys/pages/video/landscape_controls.dart';
import 'package:ddys/pages/video/portrait_controls.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:getx_scaffold/common/index.dart';
import 'package:getx_scaffold/getx_scaffold.dart';

import 'index.dart';

class VideoPage extends GetView<VideoController> {
  const VideoPage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[
      if (controller.flickManager != null)
        FlickVideoPlayer(
          flickManager: controller.flickManager!,
          flickVideoWithControls: const FlickVideoWithControls(
            videoFit: BoxFit.contain,
            controls: LandscapeControls(),
          ),
          flickVideoWithControlsFullscreen: _buildFullScreenControl(),
        ).aspectRatio(aspectRatio: 16.0 / 9.0),
      [
        TextX.titleMedium(controller.video?.name ?? "")
            .padding(vertical: 10.dm),
        TextX.bodyMedium('选择集数').marginOnly(bottom: 10.dm),
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return controller.trackIndex == index
                ? Container(
                    height: 40.dm,
                    width: 40.dm,
                    decoration: BoxDecoration(
                        color: ThemeColor.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5.dm))),
                    child: Center(
                      child: TextX.labelSmall(
                        (index + 1).toString(),
                        color: Colors.white,
                      ),
                    ),
                  ).onTap(() {
                    controller.setTrack(index);
                  }).marginOnly(right: 10.dm)
                : Container(
                    height: 40.dm,
                    width: 40.dm,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ThemeColor.primary,
                          width: 1.dm,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5.dm))),
                    child: Center(
                      child: TextX.labelSmall(
                        (index + 1).toString(),
                        color: ThemeColor.primary,
                      ),
                    ),
                  ).onTap(() {
                    controller.setTrack(index);
                  }).marginOnly(right: 10.dm);
          },
          itemCount: controller.video?.videoMeta?.tracks.length ?? 0,
        ).height(40.dm),
        if (controller.video?.seasons.length != 0)
          TextX.bodyMedium('选择季数').marginSymmetric(vertical: 10.dm),
        if (controller.video?.seasons.length != 0)
          ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ButtonX.text(
                "第 ${controller.video!.seasons[index].name} 季",
                foregroundColor: controller.video!.seasons[index].isCurrent
                    ? Colors.black12
                    : Colors.black,
                onPressed: () {
                  if (!controller.video!.seasons[index].isCurrent) {
                    controller.url = controller.video!.seasons[index].url;
                    controller.getVideoInfo();
                  }
                },
              ).height(20.dm).marginOnly(right: 10.dm);
            },
            itemCount: controller.video?.seasons.length ?? 0,
          ).height(40.dm),
        if (controller.video?.videoIntro != null)
          Column(
            children: [
              Row(
                children: [
                  ExtendedImage.network(
                    controller.video!.videoIntro!.post!,
                    width: 100.dm,
                    height: 141.dm,
                    headers: {'Referer': controller.url},
                  ).marginOnly(
                    right: 10.dm,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextX.bodyLarge(controller.video!.videoIntro!.title!)
                            .marginOnly(bottom: 10.dm),
                        Row(
                          children: [
                            StarRating(
                                starCount: 5,
                                rating: (controller.video!.videoIntro!.rating!
                                        .toDouble()! /
                                    2.0)),
                            TextX.bodyMedium(
                                controller.video!.videoIntro!.rating!)
                          ],
                        ),
                        ReadMoreText(
                          controller.video!.videoIntro!.intro!,
                          trimLines: 6,
                          style: TextStyle(fontSize: 14.sp),
                          trimMode: TrimMode.Line,
                          trimExpandedText: ' 收起',
                          trimCollapsedText: ' 更多',
                        ),
                      ],
                    ).marginOnly(
                      bottom: 10.dm,
                    ),
                  )
                ],
              ),
              TextX.bodyMedium(controller.video!.videoIntro!.abstract!),
            ],
          ).padding(all: 10.dm).card().marginOnly(top: 10.dm)
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .padding(all: 10.w, bottom: 0.w)
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .scrollable(primary: true)
        .scrollbar()
        .width(1.sw);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> onWillPop() async {
      if (controller.flickManager?.flickControlManager?.isFullscreen == true) {
        controller.flickManager?.flickControlManager?.exitFullscreen();

        return false;
      }
      return true; // 否则允许退出页面
    }

    return GetBuilder<VideoController>(
      init: VideoController(),
      id: 'video',
      builder: (_) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            extendBody: false,
            resizeToAvoidBottomInset: false,
            appBar:
                AppBar(title: Text(controller.video?.name ?? ""), elevation: 1),
            body: SafeArea(
              child: _buildView(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFullScreenControl() {
    return const FlickVideoWithControls(
      controls: PortraitControls(),
      videoFit: BoxFit.contain,
      closedCaptionTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    );
  }
}
