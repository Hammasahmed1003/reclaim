import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reclaim/appConstants/ReclaimColors.dart';
import 'package:video_player/video_player.dart';

class LessonVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const LessonVideoPlayer({super.key, required this.videoUrl});

  @override
  State<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    final fullUrl = "https://reclaim.hboxdigital.website${widget.videoUrl}";
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(fullUrl));

    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        allowPlaybackSpeedChanging: true,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null ||
        !_videoPlayerController.value.isInitialized) {
      return SizedBox(
        height: 130,
        child: Center(
          child: SpinKitDoubleBounce(
            color: Reclaimcolors.BasicBlue,
            size: 20.0,
          ),
        ),
      );
    }

    return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Chewie(controller: _chewieController!),
      ),
    );
  }
}
