import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Linha'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.home),
              Icon(Icons.search),
              Icon(Icons.settings),
            ],
          ),
        ),
      ),
    );
