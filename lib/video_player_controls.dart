library video_player_controls;

import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/seek_video/seek_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';
import 'package:video_player_controls/src/player_top_bar.dart';
import 'package:video_player_controls/src/progress_bar.dart';

class VideoPlayerControls extends StatelessWidget {
  final Chewie chewie;
  final String title;
  final bool hasSubtitles;
  final showSubtitles;

  final VideoPlayerController videoPlayerController;

  const VideoPlayerControls(
      {Key key,
      this.chewie,
      this.videoPlayerController,
      this.title,
      this.hasSubtitles = false,
      this.showSubtitles})
      : assert(
          videoPlayerController != null,
          'Video player controller must be provided in this instance',
        ),
        super(key: key);

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
        BlocProvider<PlayVideoBloc>(
          create: (context) => PlayVideoBloc(),
        ),
        BlocProvider<PauseVideoBloc>(
          create: (context) => PauseVideoBloc(),
        ),
        BlocProvider<SeekVideoBloc>(
          create: (context) => SeekVideoBloc(),
        ),
      ],
      child: new VideoPlayerInterface(
        videoPlayerController: videoPlayerController,
        chewie: chewie,
        title: title,
        hasSubtitles: hasSubtitles,
        showSubtitles: showSubtitles,
      ),
    );
  }
}

class VideoPlayerInterface extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final ChewieController chewieController;
  final Widget chewie;
  final String title;
  final Function showSubtitles;
  final bool hasSubtitles;

  const VideoPlayerInterface(
      {Key key,
      this.videoPlayerController,
      this.chewieController,
      this.chewie,
      this.title,
      this.showSubtitles,
      this.hasSubtitles})
      : super(key: key);
  @override
  _VideoPlayerInterfaceState createState() => _VideoPlayerInterfaceState();
}

class _VideoPlayerInterfaceState extends State<VideoPlayerInterface> {
  // video player controller
  VideoPlayerController _videoPlayerController;

  // control the opacity of the controls
  bool showControls = false;
  // control the player controls timeout
  Timer timer;

  // init state method
  @override
  void initState() {
    _videoPlayerController = widget.videoPlayerController;
    widget.videoPlayerController.addListener(() => listener());

    super.initState();
  }

  // distructor
  @override
  void dispose() {
    _videoPlayerController.removeListener(() => listener());
    super.dispose();
  }

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
              child: MultiBlocListener(
                child: new Center(
                  child: widget.chewie,
                ),
                listeners: [
                  BlocListener<PlayVideoBloc, PlayVideoState>(
                      listener: (context, state) {
                    if (state is PlayVideoLoaded) {
                      playVideo();
                    }
                  }),
                  BlocListener<PauseVideoBloc, PauseVideoState>(
                      listener: (context, state) {
                    if (state is PauseVideoLoaded) {
                      pauseVideo();
                    }
                  }),
                  BlocListener<SeekVideoBloc, SeekVideoState>(
                      listener: (context, state) {
                    //
                    if (state is SeekVideoLoaded) {
                      seek(state.time);
                    }
                  })
                ],
              )),
          _buildControls(context),
        ],
      ),
    );
  }

  // start timer to show controls
  void startTimer() {
    //
    setState(() {
      showControls = true;
    });
    timer = new Timer(new Duration(seconds: 3), () {
      setState(() {
        showControls = false;
      });
    });
  }

  // start or restart the timer if
  void cancelAndRestartTimer() {
    //
    if (timer != null) {
      timer.cancel();
      startTimer();
    } else {
      startTimer();
    }
  }

  // fast-foward and fastbackward in a video
  void seek(Duration time) {
    //
    _videoPlayerController.seekTo(time);
  }

  // Listen to changes in the video player controller
  void listener() {
    //
    if (_videoPlayerController != null) {
      // print('Position ' +
      //     _videoPlayerController.value.position.inSeconds.toString());
      // print('Duration ' +
      //     _videoPlayerController.value.duration.inSeconds.toString());

      BlocProvider.of<VideoPositionBloc>(context)
          .add(VideoPositionEventLoad(_videoPlayerController.value.position));
    }
  }

  // pause video
  void pauseVideo() {
    //
    if (_videoPlayerController != null) {
      if (_videoPlayerController.value.isPlaying == true) {
        _videoPlayerController.pause();
      }
    }
  }

  // play video
  void playVideo() {
    //
    if (_videoPlayerController != null) {
      if (_videoPlayerController.value.isPlaying == false) {
        _videoPlayerController.play();
      }
    }
  }

  // controls widget
  Widget _buildControls(context) {
    //
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
                PlayerTopBar(
                  title: widget.title,
                  showSubtitles: widget.showSubtitles,
                  hasSubtitles: widget.hasSubtitles,
                ),
                new Expanded(child: new Container()),
                new ProgressBar(
                  videoPlayerController: _videoPlayerController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
