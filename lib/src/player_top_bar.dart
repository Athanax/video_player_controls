import 'package:flutter/material.dart';
import 'package:video_player_controls/data/controller.dart';
import 'package:video_player_controls/src/subtitle_button.dart';

class PlayerTopBar extends StatelessWidget {
  final Controller controller;

  const PlayerTopBar({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        controller.hasSubtitles == true
            ? SubtitleButton(controller: controller)
            : new Container(),
        new Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            margin: EdgeInsets.only(left: 30),
            child: new Text(
              controller.title != null ? controller.title : '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ))
      ],
    );
  }
}
