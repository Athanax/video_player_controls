# video_player_controls

This si a video player packege built on chewie, video_player and the flutter_bloc. It has better state management and user interface.

# Installation


``` yaml
dependencies:
    flutter:
        sdk: flutter
    video_player_controls:

```
# Documentation

``` dart
VideoPlayerControls(
    hasSubtitles: true,
    chewie: Chewie(
        controller: _chewieController,
    ),
    videoPlayerController: _videoPlayerController1,
    showSubtitles: () {
        print('show subtitles');
    },
),
```

# Example in code

``` dart
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 1280 / 532,
      autoPlay: true,
      looping: true,
      allowMuting: false,
      startAt: new Duration(seconds: 4),
      allowFullScreen: true,
      allowedScreenSleep: false,
      showControls: false,
      placeholder: Container(color: Colors.grey),
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
          child: VideoPlayerControls(
            hasSubtitles: true,
            chewie: Chewie(
              controller: _chewieController,
            ),
            videoPlayerController: _videoPlayerController1,
            showSubtitles: () {
              //
              print('show subtitles');
            },
          ),
        ),
      ),
    );
  }
}
```



## Getting Started with flutter

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
