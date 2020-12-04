import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/player_item/player_item_bloc.dart';
import 'package:video_player_controls/src/buttons/cover.dart';
import 'package:video_player_controls/src/buttons/next_button.dart';
import 'package:video_player_controls/src/buttons/subtitle_button.dart';
import 'package:video_player_controls/video_player_controls.dart';

class TvTopBar extends StatefulWidget {
  final Controller controller;

  const TvTopBar({Key key, this.controller}) : super(key: key);
  @override
  _TvTopBarState createState() => _TvTopBarState();
}

class _TvTopBarState extends State<TvTopBar> {
  String title = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        children: <Widget>[
          Container(
            child: !widget.controller.showBackButton
                ? Container()
                : Cover(
                    icon: Icons.arrow_back,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
          ),
          Container(
              child: !widget.controller.hasSubtitles
                  ? Container()
                  : SubtitleButton()),
          Container(
              child: !widget.controller.showSkipButtons
                  ? Container()
                  : NextButton(isRtl: widget.controller.isRtl)),
          Expanded(
              child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                // margin: EdgeInsets.only(left: 30),
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: BlocListener<PlayerItemBloc, PlayerItemState>(
                    listener: (context, state) {
                      if (state is PlayerItemLoaded)
                        setState(() {
                          title = state?.playerItem?.title;
                        });
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
      ),
    );
  }
}
