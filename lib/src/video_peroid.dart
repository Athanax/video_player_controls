import 'package:flutter/material.dart';

class VideoPeriod extends StatefulWidget {
  @override
  _VideoPeriodState createState() => _VideoPeriodState();
}

class _VideoPeriodState extends State<VideoPeriod> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Row(
        children: <Widget>[
          new Container(
            child: new Text(
              '00:20:45',
              style: new TextStyle(color: Colors.white),
            ),
          ),
          new Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text('/', style: new TextStyle(color: Colors.white)),
            ),
          ),
          new Container(
            child:
                new Text('02:20:45', style: new TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
