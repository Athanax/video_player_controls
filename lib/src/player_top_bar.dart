import 'package:flutter/material.dart';
import 'package:video_player_controls/src/subtitle_button.dart';

class PlayerTopBar extends StatefulWidget {
  @override
  _PlayerTopBarState createState() => _PlayerTopBarState();
}

class _PlayerTopBarState extends State<PlayerTopBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SubtitleButton(),
        new Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            margin: EdgeInsets.only(left: 30),
            child: new Text(
              'Blacklist',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ))
      ],
    );
  }
}
