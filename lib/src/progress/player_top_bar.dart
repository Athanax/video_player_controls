import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/player_item/player_item_bloc.dart';
import 'package:video_player_controls/data/controller.dart';
import 'package:video_player_controls/src/buttons/subtitle_button.dart';

class PlayerTopBar extends StatefulWidget {
  final Controller controller;

  const PlayerTopBar({Key key, this.controller}) : super(key: key);

  @override
  _PlayerTopBarState createState() => _PlayerTopBarState();
}

class _PlayerTopBarState extends State<PlayerTopBar> {
  String title = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.controller.hasSubtitles == true
            ? SubtitleButton()
            : new Container(),
        new Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
            margin: EdgeInsets.only(left: 30),
            child: BlocListener<PlayerItemBloc, PlayerItemState>(
                listener: (context, state) {
                  if (state is PlayerItemLoaded) {
                    setState(() {
                      title = state.playerItem.title;
                    });
                  }
                },
                child: new Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
        ))
      ],
    );
  }
}
