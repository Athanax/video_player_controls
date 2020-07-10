import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subtitle_wrapper_package/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/video_player_controls.dart';

void main() {
  runApp(
    ChewieDemo(),
  );
}

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Chewie Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    _videoPlayerController1 = VideoPlayerController.network(
        'http://s8.bitdl.ir/Movie/Moana.2016/Moana.2016.720p.ShAaNiG.Bia2HD.mkv');

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 1280 / 532,
      autoPlay: true,
      looping: true,
      allowMuting: false,
      allowFullScreen: true,
      allowedScreenSleep: false,
      showControls: false,
      placeholder: Container(
        color: Colors.grey,
      ),
      autoInitialize: true,
    );

    _chewieController.enterFullScreen();
  }

  @override
  void dispose() {
    _chewieController.exitFullScreen();

    _videoPlayerController1.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SubTitleWrapper(
            videoPlayerController: _videoPlayerController1,
            subtitleController: SubtitleController(
              subtitleUrl:
                  "https://wecast.ch/storage/subtitles/episodes/0577acca-5d62-4ea3-a538-2e0d18f200b8.srt",
              showSubtitles: true,
            ),
            subtitleStyle:
                SubtitleStyle(textColor: Colors.white, hasBorder: true),
            videoChild: VideoPlayerControls(
              chewie: Chewie(
                controller: _chewieController,
              ),
              videoPlayerController: _videoPlayerController1,
            ),
          ),
        ),
      ),
    );
  }
}
