import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/player_item/player_item_bloc.dart';

class PlayerTopBar extends StatefulWidget {
  const PlayerTopBar({
    Key key,
  }) : super(key: key);

  @override
  _PlayerTopBarState createState() => _PlayerTopBarState();
}

class _PlayerTopBarState extends State<PlayerTopBar> {
  String title = '';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              // margin: EdgeInsets.only(left: 30),
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: BlocListener<PlayerItemBloc, PlayerItemState>(
                  listener: (context, state) {
                    if (state is PlayerItemLoaded) {
                      setState(() {
                        if (state.playerItem != null) {
                          title = state.playerItem.title;
                        }
                      });
                    }
                  },
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            ),
          ),
        ))
      ],
    );
  }
}
