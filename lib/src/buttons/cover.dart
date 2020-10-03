import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_controls/bloc/show_controls/showcontrols_bloc.dart';
import 'package:video_player_controls/src/buttons/key_events.dart';

class Cover extends StatefulWidget {
  final IconData icon;
  final Function onTap;

  const Cover({Key key, @required this.icon, @required this.onTap})
      : super(key: key);
  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> {
  FocusNode _node;

  @override
  void initState() {
    //
    super.initState();

    _node = FocusNode(onKey: (node, event) {
      //
      if (event is RawKeyDownEvent) {
        BlocProvider.of<ShowcontrolsBloc>(context)
            .add(ShowcontrolsEventStart());
        return false;
      }
      return false;
    });
    _node.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_node.hasFocus) {
      //
      BlocProvider.of<ShowcontrolsBloc>(context).add(ShowcontrolsEventStart());
    }
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new IconButton(
      focusNode: _node,
      focusColor: Colors.transparent,
      color: _node.hasFocus ? Theme.of(context).accentColor : Colors.white,
      iconSize: 30,
      icon: new Icon(widget.icon),
      onPressed: () {
        widget.onTap();
      },
    );
  }
}
