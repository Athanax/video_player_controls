import 'package:flutter/material.dart';
import 'package:video_player_controls/src/subtitle_button.dart';

class PlayerTopBar extends StatelessWidget {
  final String title;
  final Function showSubtitles;
  final bool hasSubtitles;

  const PlayerTopBar(
      {Key key, this.title, this.showSubtitles, this.hasSubtitles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        hasSubtitles == true
            ? SubtitleButton(showSubtitles: showSubtitles)
            : new Container(),
        new Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            margin: EdgeInsets.only(left: 30),
            child: new Text(
              title != null ? title : '',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ))
      ],
    );
  }
}
