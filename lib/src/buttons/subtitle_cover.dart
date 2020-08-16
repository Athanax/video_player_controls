import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/set_subtitle/set_subtitle_bloc.dart';
import 'package:video_player_controls/data/subtitle.dart';

class SubtitleCover extends StatefulWidget {
  final Subtitle subtitle;

  const SubtitleCover({Key key, this.subtitle}) : super(key: key);
  @override
  _SubtitleCoverState createState() => _SubtitleCoverState();
}

class _SubtitleCoverState extends State<SubtitleCover> {
  bool isSimilar = false;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      // focusColor: Theme.of(context).accentColor,
      onPressed: () {
        BlocProvider.of<SetSubtitleBloc>(context)
            .add(SetSubtitleEventLoad(widget.subtitle));
      },
      child: BlocListener<SetSubtitleBloc, SetSubtitleState>(
        listener: (context, state) {
          //
          if (state is SetSubtitleLoaded) {
            if (state.subtitle == widget.subtitle) {
              setState(() {
                isSimilar = true;
              });
            } else {
              setState(() {
                isSimilar = false;
              });
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                alignment: Alignment.centerLeft,
                child: new Text(
                  widget.subtitle.title,
                  style: new TextStyle(fontSize: 17),
                ),
              ),
              isSimilar == true ? new Icon(Icons.check) : new Container(),
            ],
          ),
        ),
      ),
    );
  }
}
