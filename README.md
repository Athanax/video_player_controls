# video_player_controls

This is a video player package built on [Video player](https://pub.dev/packages/video_player) and the [Flutter bloc](https://pub.dev/packages/flutter_bloc). It has better state management and user interface.

# Installation

``` yaml
dependencies:
    flutter:
        sdk: flutter
    video_player_controls:

```

# Screenshot

![Demo video](https://wecast.ch/storage/images/video.gif "Demo video")

# Features

* Able to play a list of videos from the first to the last.
* Play and pause button
* Next and Previous button
* Fast rewind and fast forward buttons
* [Flutter_bloc](https://pub.dev/packages/flutter_bloc) state management
* Ability to listen to player state, isPlaying, through a simple interface, which returns with true if the video is playing, else false

``` dart

  isPlaying: (isPlaying) {
    //
    print(isPlaying);
  },
  ```

* Ability to listen to the playing player item, see it's position, duration, and the other specified properties
* Allow video player to play in fullscreen mode (optional)
* Allow the video player to toggle full screen mode

``` dart
playerItem: (playerItem) {
  print('Player title: ' + playerItem.title); // specified title of the video
  print('position: ' + playerItem.position.inSeconds.toString()); // current position of the video
  print('Duration: ' + playerItem.duration.inSeconds.toString());  // Duration of the playing video
});
  ```

# Documentation

## Import the controller

``` dart
import 'package:video_player_controls/video_player_controls.dart';
  ```

## Initialize the Controller

``` dart
controller = new Controller(
        items: [
          new PlayerItem(
            title: 'video 1',
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
          new PlayerItem(
            startAt: Duration(seconds: 2),
            title: 'video 2',
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
          new PlayerItem(
            title: 'video 3',
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
        ],
        autoPlay: true,
        autoInitialize: true,
        // isLooping: false,
        aspectRatio: 16 / 9,
        allowedScreenSleep: false,
        // showControls: false,
        // hasSubtitles: true,
        // isLive: false,
        // showSeekButtons: false,
        // showSkipButtons: false,
        // allowFullScreen: false,
        // fullScreenByDefault: true,
        placeholder: new Container(
          color: Colors.grey,
        ),
        isPlaying: (isPlaying) {
          //
          print(isPlaying);
        },
        playerItem: (playerItem) {
          print('Player title: ' + playerItem.title);
          print('position: ' + playerItem.position.inSeconds.toString());
          print('Duration: ' + playerItem.duration.inSeconds.toString());
        });
```

The video source property of the Controller class is an enum datatype which cao either be:

``` dart
  // use a network video
  VideoSource.NETWORK
```

or

``` dart
  // use an asset video
  VideoSource.ASSET
```

# Example in code

``` dart
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
    controller = new Controller(
        items: [
          new PlayerItem(
            title: 'video 1',
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
          new PlayerItem(
            startAt: Duration(seconds: 2),
            title: 'video 2',
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
          new PlayerItem(
            title: 'video 3',
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
        ],
        autoPlay: true,
        autoInitialize: true,
        // isLooping: false,
        aspectRatio: 16 / 9,
        allowedScreenSleep: false,
        // showControls: false,
        // hasSubtitles: true,
        // isLive: false,
        // showSeekButtons: false,
        // showSkipButtons: false,
        // allowFullScreen: false,
        // fullScreenByDefault: true,
        placeholder: new Container(
          color: Colors.grey,
        ),
        isPlaying: (isPlaying) {
          //
          print(isPlaying);
        },
        playerItem: (playerItem) {
          print('Player title: ' + playerItem.title);
          print('position: ' + playerItem.position.inSeconds.toString());
          print('Duration: ' + playerItem.duration.inSeconds.toString());
        });
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
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

```

## Getting Started with flutter

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/), 
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
