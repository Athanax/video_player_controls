import 'package:flutter/material.dart';
import 'package:video_player_controls/data/subtitle.dart';

class SubtitleCover extends StatefulWidget {
  final Subtitle subtitle;
  final ValueChanged<Subtitle> callback;
  final bool focus;

  const SubtitleCover({Key key, this.subtitle, this.callback, this.focus})
      : super(key: key);
  @override
  _SubtitleCoverState createState() => _SubtitleCoverState();
}

class _SubtitleCoverState extends State<SubtitleCover> {
  @override
  void initState() {
    //
    print('object');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      // focusColor: Theme.of(context).accentColor,
      onPressed: () {
        widget.callback(widget.subtitle);
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
            widget.focus == true ? new Icon(Icons.check) : new Container(),
          ],
        ),
      ),
    );
  }
}
