import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Espaçamento'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Column(
            children: <Widget>[
              Text('Widget Acima'),
              SizedBox(height: 20.0), // 20 pixels de espaço vertical
              Text('Widget Abaixo'),
            ],
          ),
        ),
      ),
    );
