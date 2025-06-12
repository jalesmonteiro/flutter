import 'package:flutter/material.dart';

class VariableNameFieldApp extends StatefulWidget {
  @override
  _VariableNameFieldAppState createState() => _VariableNameFieldAppState();
}

class _VariableNameFieldAppState extends State<VariableNameFieldApp> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_formatText);
  }

  void _formatText() {
    String text = _controller.text;

    // Remove todos os espaços
    String newText = text.replaceAll(' ', '');

    // Se o texto não estiver vazio, verifica o primeiro caractere
    if (newText.isNotEmpty) {
      // Se o primeiro caractere não for letra ou "_", remove
      if (!RegExp(r'^[a-zA-Z_]').hasMatch(newText[0])) {
        newText = newText.substring(1);
      }
    }

    // Apenas atualiza se houve alteração para evitar loop infinito
    if (newText != text) {
      _controller.value = _controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_formatText);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Formulário com Diferentes Inputs'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Nome da variável'),
            )));
  }
}
