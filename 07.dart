import 'package:flutter/material.dart';

final meuControladorDeTexto = TextEditingController();

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Formulário'),
            centerTitle: true,
            backgroundColor: Colors.green,
          ),
          body: TextField(
            controller: meuControladorDeTexto,
            decoration: InputDecoration(
              labelText: 'Nome de usuário',
              hintText: 'Digite seu nome de usuário',
              border: OutlineInputBorder(),
            ),
            onChanged: (texto) {
              print('Texto atual: $texto');
            },
          ),
        ),
      ),
    );
