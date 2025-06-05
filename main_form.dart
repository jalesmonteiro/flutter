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
    home: const FormExampleScreen()));

class FormExampleScreen extends StatefulWidget {
  const FormExampleScreen({super.key});

  @override
  _FormExampleScreenState createState() => _FormExampleScreenState();
}

class _FormExampleScreenState extends State<FormExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Formulário Completo')),
        body: const Text('oi'));
  }
}
