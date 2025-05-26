import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Coluna'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Item 1'),
              Text('Item 2'),
              Icon(Icons.star),
            ],
          ),
        ),
      ),
    );
