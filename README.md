# video_player_controls

Video player controls is a flutter [Video player package](https://pub.dev/packages/video_player)  with more custom user interface and state management via [Flutter bloc](https://pub.dev/packages/flutter_bloc).

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

* Callback when the final player item plays

``` dart
videosCompleted: (isCompleted) {
  print(isCompleted);
});
  ```

* Added android tv controls
* Listen to D-Pad media controls

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
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        ),
        new PlayerItem(
          startAt: Duration(seconds: 2),
          title: 'video 2',
          aspectRatio: 16 / 4,
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        new PlayerItem(
          title: 'video 3',
          aspectRatio: 16 / 9,
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
      ],
      progressColors: ProgressColors(playedColor: Colors.redAccent),
      autoPlay: true,
      errorBuilder: (context, message) {
        return new Container(
          child: new Text(message),
        );
      },
      // index: 2,
      autoInitialize: true,
      // isLooping: false,
      allowedScreenSleep: false,
      // showControls: false,
      // hasSubtitles: true,
      // isLive: true,
      // showSeekButtons: false,
      // showSkipButtons: false,
      // allowFullScreen: false,
      fullScreenByDefault: true,
      // placeholder: new Container(
      //   color: Colors.grey,
      // ),
      isPlaying: (isPlaying) {
        //
        // print(isPlaying);
      },

      playerItem: (playerItem) {
        // print('Player title: ' + playerItem.title);
        // print('position: ' + playerItem.position.inSeconds.toString());
        // print('Duration: ' + playerItem.duration.inSeconds.toString());
      },
      videosCompleted: (isCompleted) {
        print(isCompleted);
      },
    );
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
import 'package:flutter/services.dart';
import 'package:video_player_controls/video_player_controls.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.select):
              const Intent(ActivateAction.key)
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: new HomePage()));
  }
}

class HomePage extends StatefulWidget {
  HomePage({this.title = 'Video player controls'});

  final String title;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Controller controller;
  @override
  void initState() {
    super.initState();
    controller = new Controller(
      items: [
        new PlayerItem(
          title: 'video 1',
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        ),
        new PlayerItem(
          startAt: Duration(seconds: 2),
          title: 'video 2',
          aspectRatio: 16 / 4,
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
        new PlayerItem(
          title: 'video 3',
          aspectRatio: 16 / 9,
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),
      ],
      progressColors: ProgressColors(playedColor: Colors.redAccent),
      autoPlay: true,
      errorBuilder: (context, message) {
        return new Container(
          child: new Text(message),
        );
      },
      // index: 2,
      autoInitialize: true,
      // isLooping: false,
      allowedScreenSleep: false,
      // showControls: false,
      // hasSubtitles: true,
      // isLive: true,
      // showSeekButtons: false,
      // showSkipButtons: false,
      // allowFullScreen: false,
      fullScreenByDefault: true,
      // placeholder: new Container(
      //   color: Colors.grey,
      // ),
      isPlaying: (isPlaying) {
        //
        // print(isPlaying);
      },

      playerItem: (playerItem) {
        // print('Player title: ' + playerItem.title);
        // print('position: ' + playerItem.position.inSeconds.toString());
        // print('Duration: ' + playerItem.duration.inSeconds.toString());
      },
      videosCompleted: (isCompleted) {
        print(isCompleted);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: VideoPlayerControls(
          controller: controller,
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
