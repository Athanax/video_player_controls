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
import 'package:video_player_controls/src/progress/player_top_bar.dart';
import 'package:video_player_controls/src/progress/progress_bar.dart';

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

enum Skip { NEXT, PREVIOUS }

class _VideoPlayerInterfaceState extends State<VideoPlayerInterface> {
  // video player controller
  VideoPlayerController _videoPlayerController;

  int _index;

  // Controller
  Controller _controller;

  int duration;

  // control the opacity of the controls
  bool showControls = false;
  // control the player controls timeout
  Timer timer;

  // init state method
  @override
  void initState() {
    _controller = widget.controller;
    _index = _controller.index;
    initializeVideo(widget.controller.urls[widget.controller.index]);
    // _videoPlayerController.addListener(() => listener());
    super.initState();
  }

  Future initializeVideo(String url) async {
    if (_controller.videoSource == VideoSource.NETWORK) {
      _videoPlayerController = VideoPlayerController.network(url)
        ..addListener(() => listener());
    } else {
      _videoPlayerController = VideoPlayerController.asset(url)
        ..addListener(() => listener());
    }

    await _videoPlayerController.setLooping(_controller.isLooping);

    if ((_controller.autoInitialize || _controller.autoPlay) &&
        !_videoPlayerController.value.initialized) {
      await _videoPlayerController.initialize();
    }

    if (_controller.autoPlay) {
      await _videoPlayerController.play();
    }

    if (_controller.startAt != null) {
      await _videoPlayerController.seekTo(_controller.startAt);
    }
    setState(() {
      duration = _videoPlayerController.value.duration.inSeconds;
    });
    cancelAndRestartTimer();
  }

  // distructor
  @override
  void dispose() {
    _videoPlayerController.removeListener(() => listener());
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<ShowcontrolsBloc>(this.context)
            .add(ShowcontrolsEventStart());
      },
      onDoubleTap: () {
        // mute video
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
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _videoPlayerController == null
                        ? _controller.placeholder
                        : VideoPlayer(_videoPlayerController),
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

  void initialize(String link, Skip skip) async {
    setState(() {
      _controller = null;
      _videoPlayerController = null;
    });
    _controller = widget.controller;
    // _controller.index = 1;
    print('index: ' + _controller.index.toString());

    if (skip == Skip.NEXT) {
      changeIndex(Skip.NEXT);
    } else {
      changeIndex(Skip.PREVIOUS);
    }

    initializeVideo(link);

    // _controller.initialize(link);
  }

  void changeIndex(Skip skip) {
    //
    if (skip == Skip.NEXT) {
      // add one to index if the link isn't the last element in the urls array

      if (_index < _controller.urls.length) {
        // add one to the controller index
        _index = _index + 1;
        print('object' + _controller.index.toString());
      } else {
        print('uko nje buda');
      }
    } else {
      // subtract one to index if the video isn't the first in the array
      if (_index > 0) {
        // add one to the controller index
        _index = _index - 1;
      }
    }
  }

  void changeVideo(String link, Skip skip) async {
    //
    if (_videoPlayerController == null) {
      // If there was no controller, just create a new one
      if (skip == Skip.NEXT) {
        initialize(link, Skip.NEXT);
      } else {
        initialize(link, Skip.PREVIOUS);
      }
    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = _videoPlayerController;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController.dispose();
        // Initing new controller
        if (skip == Skip.NEXT) {
          initialize(link, Skip.NEXT);
        } else {
          initialize(link, Skip.PREVIOUS);
        }
      });

      setState(() {
        _videoPlayerController = null;
      });
    }
  }

  // start timer to show controls
  void startTimer() {
    //
    setState(() {
      showControls = true;
    });
    timer = new Timer(new Duration(minutes: 20), () {
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
    if (_index < _controller.urls.length) {
      int index = _index + 1;
      String link = _controller.urls[index];
      changeVideo(link, Skip.NEXT);
    }
  }

  void previousVideo() {
    if (_index > 0) {
      int index = _index - 1;
      String link = _controller.urls[index];
      changeVideo(link, Skip.PREVIOUS);
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
      BlocProvider.of<VideoPositionBloc>(context).add(VideoPositionEventLoad(
          _videoPlayerController.value.position.inSeconds));
      if (duration != null) {
        if (_videoPlayerController.value.position.inSeconds == duration) {
          if (_controller.isLooping == false) {
            nextVideo();
          }
        }
      }
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
                  controller: _controller,
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
