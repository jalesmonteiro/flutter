import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Preenchimento'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Row(
            children: <Widget>[
              Container(color: Colors.blue, width: 50, height: 50),
              Expanded(
                // Ocupa o restante do espaço na linha
                child: Container(color: Colors.red, height: 50),
              ),
              Container(color: Colors.green, width: 50, height: 50),
            ],
          ),
        ),
      ),
    );
