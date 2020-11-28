library video_player_controls;

export 'package:video_player_controls/data/controller.dart';
export 'package:video_player_controls/data/player_item.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ui_mode_manager/flutter_ui_mode_manager.dart';
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
import 'package:video_player_controls/bloc/focus_play/focus_play_bloc.dart';
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
import 'package:video_player_controls/src/phone/phone_home.dart';
import 'package:video_player_controls/src/tv/tv_bottom_bar.dart';
import 'package:video_player_controls/src/tv/tv_top_bar.dart';
import 'package:video_player_controls/utils/contract.dart';
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
        BlocProvider<FocusPlayBloc>(
          create: (context) => FocusPlayBloc(),
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

enum Skip { NEXT, PREVIOUS, RESTART, SET_INDEX }

class _VideoPlayerInterfaceState extends State<VideoPlayerInterface>
    implements Contract {
  // video player controller
  VideoPlayerController _videoPlayerController;

  FullScreen fullScreen = new FullScreen();

  bool isPlaying = false;

  UiMode uiMode;

  bool isLoading = true;

  int _index;

  // Controller
  Controller _controller;

  PlayerItem _playerItem;

  int duration;

  // control the opacity of the controls
  bool showControls = false;
  bool showRewind = false;
  bool showFoward = false;
  // control the player controls timeout
  Timer timer;
  Timer fowardTimer;
  Timer rewindTimer;
  int fowardTime = 0;
  int rewindTime = 0;

  double seekStart = 0;

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
    loadDevice();
    _controller = widget.controller;
    _controller.view = this;
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
        BlocProvider.of<ShowcontrolsBloc>(context)
            .add(ShowcontrolsEventStart());
      },
      onHorizontalDragStart: (d) {
        //
        BlocProvider.of<PauseVideoBloc>(context).add(PauseVideoEventLoad());
        print(d.localPosition.dx.toString());
        setState(() {
          seekStart = d.localPosition.dx;
        });
        // print(d.kind.index.toString());
      },
      onHorizontalDragUpdate: (d) {
        cancelAndRestartTimer();
        if (d.delta.direction > 0.0) {
          seekRewindDrag(((d.localPosition.dx - seekStart) /
                  MediaQuery.of(context).size.width *
                  100)
              .toInt());
        } else {
          seekFowardDrag(((d.localPosition.dx - seekStart) /
                  MediaQuery.of(context).size.width *
                  100)
              .toInt());
        }
      },
      onHorizontalDragEnd: (d) {
        BlocProvider.of<PlayVideoBloc>(context).add(PlayVideoEventLoad());
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
                      if (showControls == true) {
                        setState(() {
                          showControls = false;
                        });
                      } else {
                        cancelAndRestartTimer();
                      }
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
                    fastFoward(state.seconds);
                  }
                }),
                BlocListener<FastRewindBloc, FastRewindState>(
                    listener: (context, state) {
                  if (state is FastRewindLoaded) {
                    fastRewind(state.seconds);
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
          new Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.items[_index].aspectRatio ?? 16 / 9,
                child: new Row(
                  children: [
                    //
                    new Expanded(
                      flex: 1,
                      child: new GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            rewindTime = rewindTime + 10;
                            showRewind = true;
                          });
                          BlocProvider.of<FastRewindBloc>(context)
                              .add(FastRewindEventLoad(10));
                        },
                        child: new Container(
                          color: showRewind == true
                              ? Colors.black54
                              : Colors.transparent,
                          child: Center(
                              child: showRewind == true
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        new Icon(_controller.isRtl
                                            ? Icons.fast_forward_outlined
                                            : Icons.fast_rewind_outlined),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text('-' +
                                              rewindTime.toString() +
                                              's'),
                                        )
                                      ],
                                    )
                                  : new Container()),
                        ),
                      ),
                    ),
                    new Expanded(child: Container(), flex: 2),
                    new Expanded(
                      flex: 1,
                      child: new GestureDetector(
                        onVerticalDragStart: (d) {
                          //
                          print('started');
                        },
                        onDoubleTap: () {
                          setState(() {
                            fowardTime = fowardTime + 20;
                            showFoward = true;
                          });
                          BlocProvider.of<FastFowardBloc>(context)
                              .add(FastFowardEventLoad(20));
                        },
                        child: new Container(
                          color: showFoward == true
                              ? Colors.black54
                              : Colors.transparent,
                          child: Center(
                            child: showFoward == true
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      new Icon(_controller.isRtl
                                          ? Icons.fast_rewind_outlined
                                          : Icons.fast_forward_outlined),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: new Text(
                                            '+' + fowardTime.toString() + 's'),
                                      )
                                    ],
                                  )
                                : new Container(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void seekFowardDrag(int percentage) {
    //
    if (duration != null) {
      // Foward
      int value = (80) * percentage ~/ 100;
      if (value < duration) {
        fastFoward(value);
      } else {
        fastFoward(duration);
      }
    }
  }

  void seekRewindDrag(int percentage) {
    //
    if (duration != null) {
      // rewind
      int value = ((80) * percentage ~/ 100).abs();
      print(value.toString());
      if (value < 0) {
        fastRewind(0);
      } else {
        fastRewind(value);
      }
    }
  }

  void addVolume(int percentage) {
    //
  }

  void addBrightness(int percentage) {
    //
  }

  void loadDevice() async {
    uiMode = await FlutterUiModeManager.getDeviceUiMode;
    setState(() {
      isLoading = false;
    });
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
    fullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
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
    } else if (skip == Skip.RESTART) {
      changeIndex(Skip.RESTART);
    } else if (skip == Skip.SET_INDEX) {
      changeIndex(Skip.SET_INDEX);
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
    } else if (skip == Skip.RESTART) {
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
      } else if (skip == Skip.RESTART) {
        initialize(link, Skip.RESTART);
      } else if (skip == Skip.SET_INDEX) {
        initialize(link, Skip.SET_INDEX);
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
        } else if (skip == Skip.RESTART) {
          initialize(link, Skip.RESTART);
        } else if (skip == Skip.SET_INDEX) {
          initialize(link, Skip.SET_INDEX);
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
    timer = new Timer(new Duration(seconds: 3), () {
      setState(() {
        showControls = false;
      });
      BlocProvider.of<FocusPlayBloc>(context).add(FocusPlayEventLoad());
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

  void fastFoward(int seconds) {
    //
    int time = _videoPlayerController.value.position.inSeconds + seconds;
    this.seek(new Duration(seconds: time));
    restartFowardTimer();
  }

  void fastRewind(int seconds) {
    //
    int time = _videoPlayerController.value.position.inSeconds - seconds;
    this.seek(new Duration(seconds: time));
    restartRewindTimer();
  }

  restartFowardTimer() {
    if (fowardTimer != null) {
      fowardTimer.cancel();
      startFowardTimer();
    } else {
      startFowardTimer();
    }
  }

  startFowardTimer() {
    cancelAndRestartTimer();
    fowardTimer = new Timer(new Duration(seconds: 1), () {
      setState(() {
        showFoward = false;
        fowardTime = 0;
      });
    });
  }

  restartRewindTimer() {
    if (rewindTimer != null) {
      rewindTimer.cancel();
      startRewindTimer();
    } else {
      startRewindTimer();
    }
  }

  startRewindTimer() {
    cancelAndRestartTimer();
    rewindTimer = new Timer(new Duration(seconds: 1), () {
      setState(() {
        showRewind = false;
        rewindTime = 0;
      });
    });
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
    if (_videoPlayerController.value != null) {
      if (_videoPlayerController.value.duration != null) {
        BlocProvider.of<VideoDurationBloc>(context).add(VideoDurationEventLoad(
            _videoPlayerController.value.duration.inSeconds));
      }
      if (_videoPlayerController.value.position != null) {
        BlocProvider.of<VideoPositionBloc>(context).add(VideoPositionEventLoad(
            _videoPlayerController.value.position.inSeconds));
      }

      if (widget.controller.isPlaying != null) {
        widget.controller.isPlaying(_videoPlayerController.value.isPlaying);
      }
      BlocProvider.of<VideoPlayingBloc>(context)
          .add(VideoPlayingEventLoad(_videoPlayerController.value.isPlaying));
      setState(() {
        isPlaying = _videoPlayerController.value.isPlaying;
      });
      if (_videoPlayerController.value.isPlaying == false) {
        setState(() {
          showControls = true;
        });
      }
      if (_videoPlayerController.value.position != null &&
          _playerItem != null) {
        setState(() {
          _playerItem.position = _videoPlayerController.value.position;
        });
      }
    }

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

  void setPlayingIndex(int index) {
    //
    if (index < _controller.items.length && index >= 0) {
      String link = _controller.items[index].url;
      changeVideo(link, Skip.SET_INDEX);
      setState(() {
        _index = index;
      });
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
    if (isLoading == false) {
      return new Positioned(
        bottom: 0,
        top: 0,
        left: 0,
        right: 0,
        child: AnimatedOpacity(
          duration: new Duration(milliseconds: 200),
          curve: Curves.decelerate,
          opacity: showControls == false ? 0 : 1,
          child: new Container(
              decoration: new BoxDecoration(color: Colors.black54),
              child: uiMode == UiMode.UI_MODE_TYPE_TELEVISION
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TvTopBar(
                          controller: _controller,
                        ),
                        new Expanded(child: new Container()),
                        new TvBottomBar(),
                      ],
                    )
                  : new PhoneHome(
                      controller: _controller,
                    )),
        ),
      );
    } else {
      return new Positioned(
        bottom: 0,
        top: 0,
        left: 0,
        right: 0,
        child: new Center(
          child: _controller.loader ?? CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  void pause() {
    pauseVideo();
  }

  @override
  void foward(seconds) {
    //
    fastFoward(seconds);
  }

  @override
  void next() {
    //
    nextVideo();
  }

  @override
  void play() {
    //
    play();
  }

  @override
  void previous() {
    //
    previousVideo();
  }

  @override
  void rewind(seconds) {
    //
    fastRewind(seconds);
  }

  @override
  void setIndex(int index) {
    //
    setPlayingIndex(index);
  }
}
