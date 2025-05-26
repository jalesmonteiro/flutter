import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Contenedor'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Container(
            width: 100.0,
            height: 100.0,
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text('Dentro do Container'),
          ),
        ),
      ),
    );
