import 'package:flutter/material.dart';

class home_master extends StatefulWidget {
  const home_master({Key? key}) : super(key: key);

  @override
  _home_masterState createState() => _home_masterState();
}

class _home_masterState extends State<home_master> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        automaticallyImplyLeading: false,
        title: Text('Master'),
        centerTitle: true,
        elevation: 0,

      ),
      body: Padding(
        padding: EdgeInsets.all(100.0),
        child: Text('home master'),
      ),
    );;
  }
}
