import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Controller controller;
  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    // ]);
    // _videoPlayerController1 = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    controller = new Controller(
        urls: [
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
        ],
        autoPlay: true,
        autoInitialize: true,
        isLooping: false,
        videoSource: VideoSource.NETWORK,
        aspectRatio: 16 / 9,
        // startAt: Duration(seconds: 1000),
        allowedScreenSleep: false,
        hasSubtitles: true,
        placeholder: new Container(
          color: Colors.red,
          child: new Center(
            child: new Text('Loading'),
          ),
        ));
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

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
          child: VideoPlayerControls(
            controller: controller,
          ),
        ),
      ),
    );
  }
}
