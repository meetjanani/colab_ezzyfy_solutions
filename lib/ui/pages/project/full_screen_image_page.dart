import 'package:colab_ezzyfy_solutions/resource/extensions.dart';
import 'package:colab_ezzyfy_solutions/ui/widget/colab_catched_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../model/project_attchments_response_model.dart';

class FullScreenImagePage extends StatefulWidget {
  FullScreenImagePage({super.key});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late ProjectAttachmentsResponseModel attachmentsResponseModel;

  late VideoPlayerController _videoController;

  late Future<void> _initializeVideoPlayerFuture;

  @override
  Widget build(BuildContext context) {
    attachmentsResponseModel = (Get.arguments as ProjectAttachmentsResponseModel);
    if(attachmentsResponseModel.videoUrl?.isNotEmpty == true) {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(
          attachmentsResponseModel.videoUrl!,
        ),
      );
      _initializeVideoPlayerFuture = _videoController.initialize();
    }
    return SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          height: Get.width.dynamicWidth() * 0.75,
          width: Get.width.dynamicWidth() * 1,
          child: Center(
            child: InteractiveViewer(
              child: attachmentsResponseModel.videoUrl.isNull ? ColabCatchedImageWidget(
                imageUrl: attachmentsResponseModel.projectAttachmentUrl,
                height: Get.width.dynamicWidth() / 2,
                width: Get.width.dynamicWidth(),
                boxFit: BoxFit.cover  ,
              ) : FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    _videoController.play();
                    return AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_videoController),
                    );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.pause();
  }
}
