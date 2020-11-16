import 'package:flutter/material.dart';
import 'package:video_player_controls/src/buttons/full_screen_button.dart';
import 'package:video_player_controls/src/buttons/subtitle_button.dart';
import 'package:video_player_controls/src/progress/progres_slider.dart';
import 'package:video_player_controls/src/progress/video_period.dart';
import 'package:video_player_controls/video_player_controls.dart';

class ProgressBar extends StatefulWidget {
  final Controller controller;
  const ProgressBar({
    Key key,
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
    super.initState();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Container(
              child: new Column(
                children: <Widget>[
                  if (_controller.isLive != true)
                    Row(
                      children: [
                        VideoPeriod(),
                        new Expanded(child: new Container()),
                        widget.controller.hasSubtitles == true
                            ? SubtitleButton()
                            : new Container(),
                        widget.controller.fullScreenByDefault == true ||
                                widget.controller.allowFullScreen == false
                            ? new Container()
                            : new FullScreenButton(),
                      ],
                    ),
                  if (_controller.isLive != true) new ProgressSlider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
