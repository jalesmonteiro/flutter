import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Tamanho fixo'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: SizedBox(
            width: 150.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Botão com Tamanho Fixo'),
            ),
          ),
        ),
      ),
    );
