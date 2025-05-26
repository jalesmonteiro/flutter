import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Centralizando'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Center(child: Text('Texto Centralizado')),
        ),
      ),
    );
