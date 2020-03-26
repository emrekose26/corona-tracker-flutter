import 'package:flutter/material.dart';
class MainCard extends StatefulWidget {
  String title;
  String img_path;
  int number;
  MainCard({@required this.title, @required this.img_path, @required this.number});

  @override
  _MainCardState createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      width: double.infinity,
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset(widget.img_path, width: 40,height: 40),
              Text(widget.number.toString(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
              Text(widget.title,style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
