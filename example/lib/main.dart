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
          LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent()
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
              accentColor: Colors.redAccent,
            ),
            home: HomePage()));
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
    controller = Controller(
      items: [
        //
        PlayerItem(
          title: 'video 1',
          url:
              'https://westream.ariablue.com/fe313e10-72a7-4c10-a978-aa28d15b4c12',
          // subtitleUrl: "https://wecast.ch/posters/vt.vtt",
        ),
        // PlayerItem(
        //   startAt: Duration(seconds: 2),
        //   title: 'video 2',
        //   aspectRatio: 16 / 4,
        //   url:
        //       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        //   subtitleUrl: "https://wecast.ch/posters/vtt.vtt",
        // ),
        // PlayerItem(
        //   title: 'video 3',
        //   aspectRatio: 16 / 9,
        //   url:
        //       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        //   subtitleUrl: "https://wecast.ch/posters/vtt.vtt",
        // ),
      ],
      autoPlay: true,
      // errorBuilder: (context, message) {
      //   return Container(
      //     child: Text(message),
      //   );
      // },
      // index: 2,
      autoInitialize: true,
      // isLooping: false,
      allowedScreenSleep: false,
      // showControls: false,
      hasSubtitles: true,
      // isLive: true,
      // showSeekButtons: false,
      // showSkipButtons: false,
      // allowFullScreen: false,
      fullScreenByDefault: false,
      // placeholder: Container(
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
