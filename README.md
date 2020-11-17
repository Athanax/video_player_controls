# video_player_controls

Video player controls is a flutter [Video player package](https://pub.dev/packages/video_player)  with more customizable user interface and state management via [Flutter bloc](https://pub.dev/packages/flutter_bloc).
I have always tried to make the package as friedly as possible. My aim was to make The videoplayer package to play all video and audio codecs. it was so unfortunate that I had fork the original videoplayer package. I cant publish this package requiring dependencies from Github. But it works as expected. Except the video codecs.

If you would like to achieve that, then require the package from my Github repository from the another branch


``` dart 

  video_player_controls:
    git:
      url: 'https://github.com/Athanax/video_player_controls.git'
      ref: another

```

# Installation

``` yaml
dependencies:
    flutter:
        sdk: flutter
    video_player_controls:

```

# Screenshot

![Demo video](https://wecast.ch/player/2.1.9.gif "Demo video")

# Features

* Able to play a list of videos from the first to the last.
* Play and pause button
* Ability to enable and disable vtt subtitles
* Next and Previous button
* Fast rewind and fast forward buttons
* [Flutter_bloc](https://pub.dev/packages/flutter_bloc) state management
* Ability to listen to player state, isPlaying, through a simple interface, which returns with true if the video is playing, else false

As from version 2.1.7, you can make your own custom UI and use the available API to perform basic operations like next, previous, restart, pause, play, and so on, using the methods of the Controller class

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
      autoPlay: true,
      errorBuilder: (context, message) {
        return new Container(
          child: new Text(message),
        );
      },
      // index: 2,
      autoInitialize: true,
      // isLooping: false,
      allowedScreenSleep: true,
      // showControls: false,
      // hasSubtitles: true,
      // isLive: true,
      // showSkipButtons: false,
      // allowFullScreen: false,
      fullScreenByDefault: false,
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

To play the next video, 

``` dart

controller.next()

```


To play the previous video, 

``` dart

controller.previous()

```


To seek the video 20 seconds foward, 

``` dart

controller.foward(20)

```

To seek the video 20 seconds backwards, 

``` dart

controller.rewind(20)

```


Play video, 

``` dart

controller.play()

```

Pause video, 

``` dart

controller.pause()

```

skip video to an index in the list, eg. play the fifth video , setIndex(5)

``` dart

controller.setIndex()

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
            theme: ThemeData(
              brightness: Brightness.dark,
              accentColor: Colors.redAccent,
            ),
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
      autoPlay: true,
      errorBuilder: (context, message) {
        return new Container(
          child: new Text(message),
        );
      },
      // index: 2,
      autoInitialize: true,
      // isLooping: false,
      allowedScreenSleep: true,
      // showControls: false,
      // hasSubtitles: true,
      // isLive: true,
      // showSeekButtons: false,
      // showSkipButtons: false,
      // allowFullScreen: false,
      fullScreenByDefault: false,
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
