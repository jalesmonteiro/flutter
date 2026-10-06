import 'package:flutter/material.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  int _selectedConfigIndex = 0; // 0: Base (Slide), 1: Decorado, 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  bool _simObscureText = false;
  String _simKeyboardTypeStr = 'text'; // 'text', 'number', 'emailAddress'
  String _simBorderStyleStr = 'outline'; // 'outline', 'underline', 'none'
  bool _simShowPrefixIcon = true;

  // Auxiliares para conversão de valores do Simulador
  TextInputType _getSimKeyboardType() {
    switch (_simKeyboardTypeStr) {
      case 'number':
        return TextInputType.number;
      case 'emailAddress':
        return TextInputType.emailAddress;
      case 'text':
      default:
        return TextInputType.text;
    }
  }

  String _keyboardTypeToString(String typeStr) {
    switch (typeStr) {
      case 'number':
        return 'TextInputType.number';
      case 'emailAddress':
        return 'TextInputType.emailAddress';
      default:
        return 'TextInputType.text';
    }
  }

  InputBorder _getSimBorder() {
    switch (_simBorderStyleStr) {
      case 'underline':
        return const UnderlineInputBorder();
      case 'none':
        return InputBorder.none;
      case 'outline':
      default:
        return const OutlineInputBorder();
    }
  }

  String _borderStyleToString(String style) {
    switch (style) {
      case 'underline':
        return 'UnderlineInputBorder()';
      case 'none':
        return 'InputBorder.none';
      default:
        return 'OutlineInputBorder()';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: TextField'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é o TextField?',
              'É o widget padrão para entrada de texto do utilizador. Permite capturar dados, aplicar máscaras visuais (ex: palavra-passe), ícones, textos de ajuda e personalizar bordas com o InputDecoration.',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA VISUAL DO TEXTFIELD
            _buildSectionTitle('Prévia Visual do TextField (Pode digitar!):'),
            const SizedBox(height: 8),
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: _buildPreviewTextField(),
              ),
            ),
            const SizedBox(height: 20),

            // 2. SELEÇÃO DA CONFIGURAÇÃO
            _buildSectionTitle('Escolha a configuração do código:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Base (Slide)')),
                ButtonSegment(value: 1, label: Text('Decorado')),
                ButtonSegment(value: 2, label: Text('Simulador')),
              ],
              selected: {_selectedConfigIndex},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedConfigIndex = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 20),

            // 3. APRESENTAÇÃO DO CÓDIGO
            _buildSectionTitle('Código da Configuração:'),
            const SizedBox(height: 8),
            Card(
              color: Colors.grey.shade100,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildCodeView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Constrói a prévia do TextField conforme a seleção
  Widget _buildPreviewTextField() {
    switch (_selectedConfigIndex) {
      case 1: // Decorado (Avançado)
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Palavra-passe',
              hintText: 'Digite a sua palavra-passe',
              prefixIcon: const Icon(Icons.lock, color: Colors.green),
              suffixIcon: const Icon(Icons.visibility, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        );

      case 2: // Simulador Interativo
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            obscureText: _simObscureText,
            keyboardType: _getSimKeyboardType(),
            decoration: InputDecoration(
              labelText: 'Campo de Texto Interativo',
              hintText: 'Digite algo aqui...',
              prefixIcon: _simShowPrefixIcon ? const Icon(Icons.edit, color: Colors.green) : null,
              border: _getSimBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        );

      case 0:
      default: // Base (Slide)
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Nome de Utilizador',
            ),
          ),
        );
    }
  }

  // Renderiza o bloco de código
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedConfigIndex == 0) {
      // CÓDIGO BASE (SLIDE)
      return const Text(
        '''TextField(
  decoration: InputDecoration(
    labelText: 'Nome de Utilizador',
  ),
);''',
        style: textStyleCode,
      );
    } else if (_selectedConfigIndex == 1) {
      // CÓDIGO DECORADO (DESTAQUE)
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: 'TextField(\n'),
            TextSpan(text: '  obscureText: false,\n'),
            TextSpan(text: '  decoration: InputDecoration(\n'),
            TextSpan(text: '    labelText: \'Palavra-passe\',\n'),
            TextSpan(text: '    hintText: \'Digite a sua palavra-passe\',\n', style: textStyleHighlight),
            TextSpan(text: '    prefixIcon: Icon(Icons.lock),\n', style: textStyleHighlight),
            TextSpan(text: '    suffixIcon: Icon(Icons.visibility),\n', style: textStyleHighlight),
            TextSpan(text: '    border: OutlineInputBorder(borderRadius: ...),\n', style: textStyleHighlight),
            TextSpan(text: '    filled: true,\n  ),\n);'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'TextField(\n  obscureText: '),
            _buildCodeDropdown<bool>(
              value: _simObscureText,
              options: const [false, true],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simObscureText = val!),
            ),
            const TextSpan(text: ',\n  keyboardType: '),
            _buildCodeDropdown<String>(
              value: _simKeyboardTypeStr,
              options: const ['text', 'number', 'emailAddress'],
              labelBuilder: _keyboardTypeToString,
              onChanged: (val) => setState(() => _simKeyboardTypeStr = val!),
            ),
            const TextSpan(text: ',\n  decoration: InputDecoration(\n    labelText: \'Campo Interativo\',\n    prefixIcon: '),
            _buildCodeDropdown<bool>(
              value: _simShowPrefixIcon,
              options: const [true, false],
              labelBuilder: (v) => v ? 'Icon(Icons.edit)' : 'null',
              onChanged: (val) => setState(() => _simShowPrefixIcon = val!),
            ),
            const TextSpan(text: ',\n    border: '),
            _buildCodeDropdown<String>(
              value: _simBorderStyleStr,
              options: const ['outline', 'underline', 'none'],
              labelBuilder: _borderStyleToString,
              onChanged: (val) => setState(() => _simBorderStyleStr = val!),
            ),
            const TextSpan(text: ',\n  ),\n);'),
          ],
        ),
      );
    }
  }

  // Widget seletor adaptado para o bloco de código
  WidgetSpan _buildCodeDropdown<T>({
    required T value,
    required List<T> options,
    required String Function(T) labelBuilder,
    required ValueChanged<T?> onChanged,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: Icon(Icons.arrow_drop_down, size: 16, color: Colors.green.shade800),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold,
          ),
          items: options.map((opt) {
            return DropdownMenuItem<T>(
              value: opt,
              child: Text(labelBuilder(opt)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildCardHeader(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }
}