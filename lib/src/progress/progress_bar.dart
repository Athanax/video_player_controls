import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_controls/bloc/pause_video/pause_video_bloc.dart';
import 'package:video_player_controls/bloc/play_video/play_video_bloc.dart';
import 'package:video_player_controls/bloc/seek_video/seek_video_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/src/buttons/fast_foward_button.dart';
import 'package:video_player_controls/src/buttons/fast_rewind_button.dart';
import 'package:video_player_controls/src/buttons/next_button.dart';
import 'package:video_player_controls/src/buttons/play_button.dart';
import 'package:video_player_controls/src/buttons/previous_button.dart';
import 'package:video_player_controls/src/progress/progres_slider.dart';
import 'package:video_player_controls/src/progress/video_period.dart';
import 'package:video_player_controls/video_player_controls.dart';

class ProgressBar extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final Controller controller;
  const ProgressBar({
    Key key,
    this.videoPlayerController,
    this.controller,
  }) : super(key: key);
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double duration = 1.0;
  Controller _controller;

  @override
  void initState() {
    _controller = widget.controller;
    duration = widget.videoPlayerController.value.duration.inSeconds.toDouble();
    super.initState();
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: new Container(
                child: new Column(
                  children: <Widget>[
                    VideoPeriod(
                      videoPlayerController: widget.videoPlayerController,
                    ),
                    new ProgressSlider(
                      duration: duration,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _controller.showSeekButtons == false
                            ? new Container()
                            : new FastRewindButton(),
                        _controller.showSkipButtons == false
                            ? new Container()
                            : new PreviousButton(),
                        new PlayButton(),
                        _controller.showSkipButtons == false
                            ? new Container()
                            : new NextButton(),
                        _controller.showSeekButtons == false
                            ? new Container()
                            : new FastFowardButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
