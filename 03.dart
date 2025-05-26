import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Scaffold'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: Text('Conteúdo da Tela'),
          floatingActionButton: FloatingActionButton(
            onPressed: () {/* ação */},
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
