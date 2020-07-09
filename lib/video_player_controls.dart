library video_player_controls;

import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/video_duration/video_duration_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';
import 'package:video_player_controls/src/player_top_bar.dart';
import 'package:video_player_controls/src/progress_bar.dart';

class VideoPlayerControls extends StatefulWidget {
  final Chewie chewie;

  final VideoPlayerController videoPlayerController;

  const VideoPlayerControls({Key key, this.chewie, this.videoPlayerController})
      : assert(
          videoPlayerController != null,
          'Video player controller must be provided in this instance',
        ),
        super(key: key);

  @override
  _VideoPlayerControlsState createState() => _VideoPlayerControlsState();
}

class _VideoPlayerControlsState extends State<VideoPlayerControls> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShowcontrolsBloc>(
          create: (context) => ShowcontrolsBloc(),
        ),
        BlocProvider<VideoPositionBloc>(
          create: (context) => VideoPositionBloc(),
        ),
        BlocProvider<VideoDurationBloc>(
          create: (context) => VideoDurationBloc(),
        ),
      ],
      child: new VideoPlayerInterface(
        videoPlayerController: widget.videoPlayerController,
        chewie: widget.chewie,
      ),
    );
  }
}

class VideoPlayerInterface extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final ChewieController chewieController;
  final Widget chewie;

  const VideoPlayerInterface(
      {Key key, this.videoPlayerController, this.chewieController, this.chewie})
      : super(key: key);
  @override
  _VideoPlayerInterfaceState createState() => _VideoPlayerInterfaceState();
}

class _VideoPlayerInterfaceState extends State<VideoPlayerInterface> {
  VideoPlayerController _videoPlayerController;
  void listener() {
    if (_videoPlayerController != null) {
      BlocProvider.of<VideoPositionBloc>(context)
          .add(VideoPositionEventLoad(_videoPlayerController.value.position));
      BlocProvider.of<VideoDurationBloc>(context)
          .add(VideoDurationEventLoad(_videoPlayerController.value.duration));
    }
  }

  @override
  void initState() {
    _videoPlayerController = widget.videoPlayerController;
    widget.videoPlayerController.addListener(() => listener());
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(() => listener());
    super.dispose();
  }

  bool showControls = false;
  Timer timer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ShowcontrolsBloc>(this.context)
            .add(ShowcontrolsEventStart());
      },
      child: Stack(
        children: <Widget>[
          new Positioned(
            bottom: 0,
            top: 0,
            left: 0,
            right: 0,
            child: new Center(
              child: widget.chewie,
            ),
          ),
          _buildControls(context),
        ],
      ),
    );
  }

  // start timer tom show co
  void startTimer() {
    setState(() {
      showControls = true;
    });
    timer = new Timer(new Duration(seconds: 3), () {
      setState(() {
        showControls = false;
      });
    });
  }

  void cancelAndRestartTimer() {
    if (timer != null) {
      timer.cancel();
      startTimer();
    } else {
      startTimer();
    }
  }

  Widget _buildControls(context) {
    return new Positioned(
      bottom: 0,
      top: 0,
      left: 0,
      right: 0,
      child: BlocListener<ShowcontrolsBloc, ShowcontrolsState>(
        listener: (context, state) {
          if (state is ShowcontrolsStarted) {
            cancelAndRestartTimer();
          }
        },
        child: AnimatedOpacity(
          duration: new Duration(milliseconds: 300),
          opacity: showControls == true ? 1.0 : 0.0,
          child: new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black45,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black45,
                ],
              ),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PlayerTopBar(),
                new Expanded(child: new Container()),
                new ProgressBar(
                  videoPlayerController: widget.videoPlayerController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
