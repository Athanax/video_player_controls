library video_player_controls;

export 'package:video_player_controls/data/controller.dart';
export 'package:video_player_controls/data/player_item.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:video_player_controls/bloc/enter_full_screen/enter_full_screen_bloc.dart';
import 'package:video_player_controls/bloc/exit_full_screen/exit_full_screen_bloc.dart';
import 'package:video_player_controls/bloc/fast_foward/fast_foward_bloc.dart';
import 'package:video_player_controls/bloc/fast_rewind/fast_rewind_bloc.dart';
import 'package:video_player_controls/bloc/load_player/load_player_bloc.dart';
import 'package:video_player_controls/bloc/next_video/next_video_bloc.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/player_item/player_item_bloc.dart';
import 'package:video_player_controls/bloc/previous_video/previous_video_bloc.dart';
import 'package:video_player_controls/bloc/seek_video/seek_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/bloc/show_subtitles/show_subtitles_bloc.dart';
import 'package:video_player_controls/bloc/video_duration/video_duration_bloc.dart';
import 'package:video_player_controls/bloc/video_playing/video_playing_bloc.dart';
import 'package:video_player_controls/bloc/video_position/video_position_bloc.dart';
import 'package:video_player_controls/data/controller.dart';
import 'package:video_player_controls/data/player_item.dart';
import 'package:video_player_controls/src/progress/player_top_bar.dart';
import 'package:video_player_controls/src/progress/progress_bar.dart';
import 'package:wakelock/wakelock.dart';

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
        BlocProvider<LoadPlayerBloc>(
          create: (context) => LoadPlayerBloc(),
        ),
        BlocProvider<ShowSubtitlesBloc>(
          create: (context) => ShowSubtitlesBloc(),
        ),
        BlocProvider<PlayerItemBloc>(
          create: (context) => PlayerItemBloc(),
        ),
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
        BlocProvider<VideoDurationBloc>(
          create: (context) => VideoDurationBloc(),
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
        BlocProvider<EnterFullScreenBloc>(
          create: (context) => EnterFullScreenBloc(),
        ),
        BlocProvider<ExitFullScreenBloc>(
          create: (context) => ExitFullScreenBloc(),
        ),
        BlocProvider<VideoPlayingBloc>(
          create: (context) => VideoPlayingBloc(),
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

enum Skip { NEXT, PREVIOUS, RESTART }

class _VideoPlayerInterfaceState extends State<VideoPlayerInterface> {
  // video player controller
  VideoPlayerController _videoPlayerController;

  FullScreen fullScreen = new FullScreen();

  int _index;

  // Controller
  Controller _controller;

  PlayerItem _playerItem;

  int duration;

  // control the opacity of the controls
  bool showControls = false;
  // control the player controls timeout
  Timer timer;

  bool showSubtitles = false;

  @override
  void didChangeDependencies() {
    //
    BlocProvider.of<LoadPlayerBloc>(context).add(LoadPlayerEventLoad());
    super.didChangeDependencies();
  }

  void startPlayer() {
    initializeVideo(widget.controller.items[widget.controller.index].url);
  }

  // init state method
  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    //
    if (_controller.allowedScreenSleep == false) {
      Wakelock.enable();
    }
    if (_controller.fullScreenByDefault == true) {
      enterFullScreen();
    }
    _index = _controller.index;
    // _videoPlayerController.addListener(() => listener());
  }

  Future initializeVideo(String url) async {
    if (_controller.videoSource == VideoSource.NETWORK) {
      _videoPlayerController = VideoPlayerController.network(url)
        ..addListener(() => listener());
    } else {
      _videoPlayerController = VideoPlayerController.asset(url)
        ..addListener(() => listener());
    }

    //

    //
    await _videoPlayerController.setLooping(_controller.isLooping);

    if ((_controller.autoInitialize || _controller.autoPlay) &&
        !_videoPlayerController.value.initialized) {
      await _videoPlayerController.initialize();
    }

    if (!_controller.autoPlay && !_videoPlayerController.value.initialized) {
      await _videoPlayerController.initialize();
    }

    if (_controller.autoPlay) {
      await _videoPlayerController.play();
    }

    if (_controller.items[_index].startAt != null) {
      await _videoPlayerController.seekTo(_controller.items[_index].startAt);
    }
    setState(() {
      _playerItem = _controller.items[_index];
      duration = _videoPlayerController.value.duration.inSeconds;
      _playerItem.duration = _videoPlayerController.value.duration;
    });
    BlocProvider.of<PlayerItemBloc>(context)
        .add(PlayerItemEventLoad(_playerItem));

    /// Show controls when the video starts
    BlocProvider.of<ShowcontrolsBloc>(context).add(ShowcontrolsEventStart());

    // cancelAndRestartTimer();
  }

  // distructor
  @override
  void dispose() {
    if (_controller.fullScreenByDefault == true) {
      exitFullScreen();
    }
    if (_controller.allowedScreenSleep == false) {
      Wakelock.disable();
    }
    _videoPlayerController.removeListener(() => listener());
    _videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // if (_videoPlayerController.value.hasError == false) {
        BlocProvider.of<ShowcontrolsBloc>(this.context)
            .add(ShowcontrolsEventStart());
        // }
      },
      onDoubleTap: () {
        // mute video
        // BlocProvider.of<VideoDurationBloc>(context).add(VideoDurationEventLoad(
        //     _videoPlayerController.value.duration.inSeconds));
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
                  aspectRatio: _controller.items[_index].aspectRatio ?? 16 / 9,
                  child: Stack(
                    children: <Widget>[
                      if (_videoPlayerController != null)
                        if (_videoPlayerController.value.hasError == true)
                          if (_controller.errorBuilder != null)
                            _controller.errorBuilder(this.context,
                                _videoPlayerController.value.errorDescription)
                          else
                            Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 42,
                              ),
                            )
                        else
                          SubTitleWrapper(
                              subtitleStyle: new SubtitleStyle(
                                hasBorder: true,
                                textColor: Colors.white,
                              ),
                              videoPlayerController: _videoPlayerController,
                              subtitleController: SubtitleController(
                                subtitleType: SubtitleType.srt,
                                subtitleUrl:
                                    _controller.items[_index].subtitleUrl,
                                showSubtitles:
                                    (_controller.items[_index].subtitleUrl !=
                                                null &&
                                            showSubtitles == true)
                                        ? true
                                        : false,
                              ),
                              videoChild: VideoPlayer(_videoPlayerController))
                      else
                        _controller.placeholder ??
                            new Container(
                              color: Colors.black,
                            ),
                      if (_videoPlayerController == null ||
                          _videoPlayerController.value.isBuffering)
                        new Center(
                          child:
                              _controller.loader ?? CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
              listeners: [
                BlocListener<LoadPlayerBloc, LoadPlayerState>(
                    listener: (context, state) {
                  if (state is LoadPlayerLoaded) {
                    //
                    startPlayer();
                  }
                }),
                BlocListener<ShowcontrolsBloc, ShowcontrolsState>(
                  listener: (context, state) {
                    if (state is ShowcontrolsStarted) {
                      cancelAndRestartTimer();
                    }
                  },
                ),
                BlocListener<ShowSubtitlesBloc, ShowSubtitlesState>(
                  listener: (context, state) {
                    if (state is ShowSubtitlesLoaded) {
                      toggleSubtitles();
                    }
                  },
                ),
                BlocListener<EnterFullScreenBloc, EnterFullScreenState>(
                    listener: (context, state) {
                  if (state is EnterFullScreenLoaded) {
                    //
                    enterFullScreen();
                  }
                }),
                BlocListener<ExitFullScreenBloc, ExitFullScreenState>(
                    listener: (context, state) {
                  if (state is ExitFullScreenLoaded) {
                    //
                    exitFullScreen();
                  }
                }),
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
            ),
          ),
          _controller.showControls == true
              ? _buildControls(context)
              : new Container(),
        ],
      ),
    );
  }

  void toggleSubtitles() {
    //
    _videoPlayerController.pause();
    setState(() {
      showSubtitles = !showSubtitles;
    });
    _videoPlayerController.play();
    if (showSubtitles == true) {
      if (_controller.items[_index].subtitleUrl == null) {
        showToast('no subtitle found');
      } else {
        showToast('Subtitles enabled');
      }
    } else {
      showToast('Subtitles disabled');
    }
  }

  void showToast(String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void enterFullScreen() {
    //
    fullScreen.enterFullScreen(FullScreenMode.EMERSIVE);
  }

  void exitFullScreen() async {
    //
    fullScreen.exitFullScreen();
  }

  void initialize(String link, Skip skip) async {
    setState(() {
      _controller = null;
      _videoPlayerController = null;
    });
    _controller = widget.controller;
    // _controller.index = 1;

    if (skip == Skip.NEXT) {
      changeIndex(Skip.NEXT);
    } else if (skip == Skip.PREVIOUS) {
      changeIndex(Skip.PREVIOUS);
    } else {
      changeIndex(Skip.RESTART);
    }

    initializeVideo(link);

    // _controller.initialize(link);
  }

  void changeIndex(Skip skip) {
    //
    if (skip == Skip.NEXT) {
      // add one to index if the link isn't the last element in the urls array

      if (_index < _controller.items.length) {
        // add one to the controller index
        _index = _index + 1;
      }
    } else if (skip == Skip.PREVIOUS) {
      // subtract one to index if the video isn't the first in the array
      if (_index > 0) {
        // add one to the controller index
        _index = _index - 1;
      }
    } else {
      _index = 0;
    }
  }

  void changeVideo(String link, Skip skip) async {
    //
    if (_videoPlayerController == null) {
      // If there was no controller, just create a new one
      if (skip == Skip.NEXT) {
        initialize(link, Skip.NEXT);
      } else if (skip == Skip.PREVIOUS) {
        initialize(link, Skip.PREVIOUS);
      } else {
        initialize(link, Skip.RESTART);
      }
    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = _videoPlayerController;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await oldController.dispose();
        // Initing new controller
        if (skip == Skip.NEXT) {
          initialize(link, Skip.NEXT);
        } else if (skip == Skip.PREVIOUS) {
          initialize(link, Skip.PREVIOUS);
        } else {
          initialize(link, Skip.RESTART);
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
    BlocProvider.of<PlayerItemBloc>(context)
        .add(PlayerItemEventLoad(_playerItem));
    timer = new Timer(new Duration(seconds: 4), () {
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

  /// play the next video
  void nextVideo() {
    //
    if (_index < _controller.items.length) {
      int index = _index + 1;
      // this solved the RangeIndex() Exception
      if (index != _controller.items.length) {
        String link = _controller.items[index].url;
        changeVideo(link, Skip.NEXT);
      }
    }
  }

  /// play the previous video
  void previousVideo() {
    if (_index > 0) {
      int index = _index - 1;
      String link = _controller.items[index].url;
      changeVideo(link, Skip.PREVIOUS);
    }
  }

  // fast-foward and fastbackward in a video
  void seek(Duration time) {
    //
    _videoPlayerController.seekTo(time);
    // ignore: unnecessary_statements
    // _videoPlayerController.value.buffered;
  }

  // Listen to changes in the video player controller
  void listener() {
    //
    if (_videoPlayerController != null) {
      listenables();
    }
  }

  void listenables() {
    BlocProvider.of<VideoDurationBloc>(context).add(VideoDurationEventLoad(
        _videoPlayerController.value.duration.inSeconds));
    BlocProvider.of<VideoPositionBloc>(context).add(VideoPositionEventLoad(
        _videoPlayerController.value.position.inSeconds));

    if (widget.controller.isPlaying != null) {
      widget.controller.isPlaying(_videoPlayerController.value.isPlaying);
    }
    BlocProvider.of<VideoPlayingBloc>(context)
        .add(VideoPlayingEventLoad(_videoPlayerController.value.isPlaying));
    setState(() {
      _playerItem.position = _videoPlayerController.value.position;
    });
    if (widget.controller.playerItem != null) {
      widget.controller.playerItem(_playerItem);
    }
    if (_controller.isLive == false) {
      if (duration != null) {
        if (_videoPlayerController.value.position.inSeconds == duration) {
          if (_controller.isLooping == false) {
            nextVideo();
          }
          if (_controller.items.length - 1 == _index) {
            if (widget.controller.videosCompleted != null) {
              widget.controller.videosCompleted(true);
            }
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
        if (_videoPlayerController.value.position ==
            _videoPlayerController.value.duration) {
          // restart video
          restartPlaylist();
        } else {
          _videoPlayerController.play();
        }
      }
    }
  }

  void restartPlaylist() {
    //
    String link = _controller.items[0].url;
    changeVideo(link, Skip.RESTART);
  }

  // controls widget
  Widget _buildControls(context) {
    //

    return new Positioned(
      bottom: 0,
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedOpacity(
        duration: new Duration(milliseconds: 200),
        curve: Curves.decelerate,
        opacity: showControls == false ? 0 : 1,
        child: Container(
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
                PlayerTopBar(),
                new Expanded(child: new Container()),
                new ProgressBar(controller: _controller)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubtitlePosition {}
