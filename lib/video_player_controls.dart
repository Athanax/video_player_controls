library video_player_controls;

export 'package:video_player_controls/data/controller.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/fast_foward/fast_foward_bloc.dart';
import 'package:video_player_controls/bloc/fast_rewind/fast_rewind_bloc.dart';
import 'package:video_player_controls/bloc/next_video/next_video_bloc.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/previous_video/previous_video_bloc.dart';
import 'package:video_player_controls/bloc/seek_video/seek_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';
import 'package:video_player_controls/data/controller.dart';
import 'package:video_player_controls/src/player_top_bar.dart';
import 'package:video_player_controls/src/progress_bar.dart';

class VideoPlayerControls extends StatelessWidget {
  final Controller controller;
  const VideoPlayerControls({
    Key key,
    this.controller,
  })  : assert(
          controller != null,
          'A controller must be provided in this instance',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShowcontrolsBloc>(
          create: (context) => ShowcontrolsBloc(),
        ),
        BlocProvider<PreviousVideoBloc>(
          create: (context) => PreviousVideoBloc(),
        ),
        BlocProvider<NextVideoBloc>(
          create: (context) => NextVideoBloc(),
        ),
        BlocProvider<FastFowardBloc>(
          create: (context) => FastFowardBloc(),
        ),
        BlocProvider<FastRewindBloc>(
          create: (context) => FastRewindBloc(),
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
        controller: controller,
      ),
    );
  }
}

class VideoPlayerInterface extends StatefulWidget {
  final Controller controller;
  const VideoPlayerInterface({
    Key key,
    this.controller,
  }) : super(key: key);
  @override
  _VideoPlayerInterfaceState createState() => _VideoPlayerInterfaceState();
}

class _VideoPlayerInterfaceState extends State<VideoPlayerInterface> {
  // video player controller
  VideoPlayerController _videoPlayerController;

  // Controller
  Controller _controller;

  // control the opacity of the controls
  bool showControls = false;
  // control the player controls timeout
  Timer timer;

  // init state method
  @override
  void initState() {
    _controller = widget.controller;
    _videoPlayerController = _controller.videoPlayerController;
    _videoPlayerController.addListener(() => listener());
    super.initState();
  }

  // distructor
  @override
  void dispose() {
    _videoPlayerController.removeListener(() => listener());
    widget.controller.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ShowcontrolsBloc>(this.context)
            .add(ShowcontrolsEventStart());
      },
      child: _videoPlayerController == null
          ? new CircularProgressIndicator()
          : Stack(
              children: <Widget>[
                new Positioned(
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: MultiBlocListener(
                      child: new Center(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      ),
                      listeners: [
                        BlocListener<NextVideoBloc, NextVideoState>(
                            listener: (context, state) {
                          if (state is NextVideoLoaded) {
                            nextVideo();
                          }
                        }),
                        BlocListener<PreviousVideoBloc, PreviousVideoState>(
                            listener: (context, state) {
                          if (state is PreviousVideoLoaded) {
                            previousVideo();
                          }
                        }),
                        BlocListener<FastFowardBloc, FastFowardState>(
                            listener: (context, state) {
                          if (state is FastFowardLoaded) {
                            fastFoward();
                          }
                        }),
                        BlocListener<FastRewindBloc, FastRewindState>(
                            listener: (context, state) {
                          if (state is FastRewindLoaded) {
                            fastRewind();
                          }
                        }),
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
    timer = new Timer(new Duration(seconds: 20), () {
      setState(() {
        showControls = false;
      });
    });
  }

  // start or restart the timer if its already running
  void cancelAndRestartTimer() {
    //
    if (timer != null) {
      timer.cancel();
      startTimer();
    } else {
      startTimer();
    }
  }

  void fastFoward() {
    //
    int time = _videoPlayerController.value.position.inSeconds + 20;
    this.seek(new Duration(seconds: time));
  }

  void fastRewind() {
    //
    int time = _videoPlayerController.value.position.inSeconds - 10;
    this.seek(new Duration(seconds: time));
  }

  void nextVideo() {
    //
    print('called');
    print(widget.controller.urls.length.toString());
    print(widget.controller.playingIndex.toString());
    if (widget.controller.playingIndex < widget.controller.urls.length) {
      int index = widget.controller.playingIndex + 1;
      String link = widget.controller.urls[index];
      changeVideo(link);
    } else {
      print('condition met');
    }
  }

  void previousVideo() {
    //

    if (widget.controller.playingIndex != 0) {
      int index = widget.controller.playingIndex - 1;
      String link = widget.controller.urls[index];
      changeVideo(link);
    }
  }

  void changeVideo(String link) async {
    // _videoPlayerController.removeListener(() => listener());
    setState(() {
      widget.controller.videoPlayerController = null;
      _videoPlayerController = null;
    });
    setState(() {
      widget.controller.videoPlayerController =
          _videoPlayerController = new VideoPlayerController.network(link);
      _videoPlayerController = widget.controller.videoPlayerController;
    });
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
                  Colors.black,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PlayerTopBar(
                  controller: widget.controller,
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
