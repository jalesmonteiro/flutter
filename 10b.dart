import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Divisão'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Row(
            children: <Widget>[
              Expanded(
                flex: 2, // Ocupa 2/3 do espaço disponível
                child: Container(color: Colors.orange, height: 50),
              ),
              Expanded(
                flex: 1, // Ocupa 1/3 do espaço disponível
                child: Container(color: Colors.purple, height: 50),
              ),
            ],
          ),
        ),
      ),
    );
