import 'package:flutter/material.dart';
import 'package:video_player_controls/src/tv/playback_duration.dart';
import 'package:video_player_controls/src/tv/playback_position.dart';
import 'package:video_player_controls/src/tv/tv_progress.dart';
import 'package:video_player_controls/src/tv/tv_play_button.dart';
import 'package:video_player_controls/video_player_controls.dart';

class TvBottomBar extends StatefulWidget {
  final Controller controller;

  const TvBottomBar({Key key, this.controller}) : super(key: key);
  @override
  _TvBottomBarState createState() => _TvBottomBarState();
}

class _TvBottomBarState extends State<TvBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: new Row(
        children: [
          new TvPlayButton(),
          new PlaybackPosition(),
          Expanded(child: new TvProgress()),
          new PlayBackDuration()
        ],
      ),
    );
  }
}
