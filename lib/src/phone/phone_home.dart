import 'package:flutter/material.dart';
import 'package:video_player_controls/data/controller.dart';
import 'package:video_player_controls/src/buttons/next_button.dart';
import 'package:video_player_controls/src/buttons/play_button.dart';
import 'package:video_player_controls/src/buttons/previous_button.dart';
import 'package:video_player_controls/src/progress/player_top_bar.dart';
import 'package:video_player_controls/src/progress/progress_bar.dart';

class PhoneHome extends StatefulWidget {
  final Controller controller;

  const PhoneHome({Key key, this.controller}) : super(key: key);
  @override
  _PhoneHomeState createState() => _PhoneHomeState();
}

class _PhoneHomeState extends State<PhoneHome> {
  Controller _controller;

  @override
  void initState() {
    //
    super.initState();
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //
        Positioned(
          bottom: 50,
          top: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              PlayerTopBar(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // Container(child: VolumeSlider()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !_controller.showSkipButtons
                            ? Container()
                            : PreviousButton(isRtl: _controller.isRtl),
                        SizedBox(width: 15),
                        PlayButton(),
                        SizedBox(width: 15),
                        !_controller.showSkipButtons
                            ? Container()
                            : NextButton(isRtl: _controller.isRtl),
                      ],
                    ),
                    // Container(child: BrightnessSlider()),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ProgressBar(controller: _controller),
        )
      ],
    );
  }
}
