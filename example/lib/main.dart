import 'package:example/bloc/video_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/video_player_controls.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: new Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: new Center(
          child: new RaisedButton(
            onPressed: () {
              //
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new PlayerClass()));
            },
            child: new Text('next'),
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: () {
        //
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new HomePage()));
      }),
    );
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
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
          new PlayerItem(
            title: 'video 3',
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          ),
        ],
        progressColors: ProgressColors(playedColor: Colors.redAccent),
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
          // print(isPlaying);
        },
        onError: (error) {
          //
          // print(error['hasError']);
          // print(error['message']);
        },
        playerItem: (playerItem) {
          // print('Player title: ' + playerItem.title);
          // print('position: ' + playerItem.position.inSeconds.toString());
          // print('Duration: ' + playerItem.duration.inSeconds.toString());
        });
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

class PlayerClass extends StatefulWidget {
  @override
  _PlayerClassState createState() => _PlayerClassState();
}

class _PlayerClassState extends State<PlayerClass> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => VideoBloc(), child: Scaffold(body: new PageTwo()));
  }
}

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  VideoPlayerController _videoPlayerController;
  int seconds = 0;
  @override
  void initState() {
    //
    super.initState();
    _videoPlayerController = new VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4")
      ..initialize()
      ..play();
    _videoPlayerController.addListener(() => listener());
  }

  void listener() {
    //
    BlocProvider.of<VideoBloc>(context)
        .add(VideoEventLoad(_videoPlayerController.value.position.inSeconds));
    print(_videoPlayerController.value.position.inSeconds.toString());
  }

  @override
  void dispose() {
    //
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoBloc, VideoState>(
      listener: (context, state) {
        if (state is VideoLoaded) {
          setState(() {
            seconds = state.pos;
          });
        }
      },
      child: new Center(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black,
              child: new AspectRatio(
                aspectRatio: 16 / 9,
                child: new VideoPlayer(_videoPlayerController),
              ),
            ),
            new Center(
              child: Text(seconds.toString()),
            )
          ],
        ),
      ),
    );
  }
}
