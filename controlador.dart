import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF01A534), // Verde principal
        primary: const Color(0xFF01A534), // Cor principal
        secondary: const Color(0xFF01A534), // Cor secundária (opcional)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF01A534), // Botões elevados
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF01A534), // AppBar
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF01A534)),
        ),
        labelStyle: TextStyle(color: Color(0xFF01A534)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(const Color(0xFF01A534)),
        trackColor: WidgetStateProperty.all(const Color(0x3301A534)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(const Color(0xFF01A534)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.all(const Color(0xFF01A534)),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: Color(0xFF01A534),
        thumbColor: Color(0xFF01A534),
      ),
    ),
    home: VariableNameFieldApp()));

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
