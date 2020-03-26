import 'package:flutter/material.dart';
class MainCard extends StatefulWidget {
  String title;
  String img_path;
  String number;
  MainCard({@required this.title, @required this.img_path, @required this.number});

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      width: double.infinity,
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(widget.img_path, width: 50,height: 50),
              Text(widget.number, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
              Text(widget.title,style: TextStyle(fontSize: 15, color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }
}
