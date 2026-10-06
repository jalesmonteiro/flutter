import 'package:flutter/material.dart';

class CenterScreen extends StatefulWidget {
  const CenterScreen({super.key});

  @override
  State<CenterScreen> createState() => _CenterScreenState();
}

class _CenterScreenState extends State<CenterScreen> {
  int _selectedConfigIndex = 0; // 0: Base (Slide), 1: Com Fatores, 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  double? _simWidthFactor; // null, 1.5, 2.0
  double? _simHeightFactor; // null, 1.5, 2.0
  Color _simChildColor = Colors.deepOrange;

  // Funções auxiliares para formatação no código
  String _factorToString(double? factor) {
    if (factor == null) return 'null';
    return factor.toString();
  }

  String _colorToString(Color color) {
    if (color == Colors.deepOrange) return 'Colors.deepOrange';
    if (color == Colors.blue) return 'Colors.blue';
    if (color == Colors.teal) return 'Colors.teal';
    if (color == Colors.purple) return 'Colors.purple';
    return 'Color(...)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: Center'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é o Center?',
              'É um widget de alinhamento que posiciona o seu filho exatamente no centro do espaço disponível. Também permite multiplicar as dimensões do filho via widthFactor e heightFactor.',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA VISUAL DO CENTER
            _buildSectionTitle('Prévia Visual do Center:'),
            const SizedBox(height: 8),
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: _buildPreviewCenter(),
            ),
            const SizedBox(height: 20),

            // 2. SELEÇÃO DA CONFIGURAÇÃO
            _buildSectionTitle('Escolha a configuração do código:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Base (Slide)')),
                ButtonSegment(value: 1, label: Text('Com Fatores')),
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

  // Constrói a prévia visual conforme a seleção
  Widget _buildPreviewCenter() {
    switch (_selectedConfigIndex) {
      case 1: // Com Fatores (widthFactor e heightFactor)
        return UnconstrainedBox(
          child: Container(
            color: Colors.deepOrange.shade100,
            child: Center(
              widthFactor: 2.0,
              heightFactor: 2.0,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '70x70',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );

      case 2: // Simulador Interativo
        return UnconstrainedBox(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade50,
              border: Border.all(color: Colors.deepOrange.shade200, style: BorderStyle.solid),
            ),
            child: Center(
              widthFactor: _simWidthFactor,
              heightFactor: _simHeightFactor,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _simChildColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Filho\n80x80',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          ),
        );

      case 0:
      default: // Base (Slide)
        return Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'No Centro',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
    }
  }

  // Renderiza o bloco de código de acordo com a aba selecionada
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.deepOrange, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedConfigIndex == 0) {
      // CÓDIGO BASE (SLIDE)
      return const Text(
        '''Center(
  child: Container(
    width: 100.0,
    height: 100.0,
    color: Colors.deepOrange,
    child: Text('No Centro'),
  ),
);''',
        style: textStyleCode,
      );
    } else if (_selectedConfigIndex == 1) {
      // CÓDIGO COM FATORES DESTAQUE
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: 'Center(\n'),
            TextSpan(text: '  widthFactor: 2.0,  // Largura do Center = 2x a largura do filho\n', style: textStyleHighlight),
            TextSpan(text: '  heightFactor: 2.0, // Altura do Center = 2x a altura do filho\n', style: textStyleHighlight),
            TextSpan(text: '  child: Container(\n    width: 70.0,\n    height: 70.0,\n    color: Colors.deepOrange,\n  ),\n);'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'Center(\n  widthFactor: '),
            _buildCodeDropdown<double?>(
              value: _simWidthFactor,
              options: const [null, 1.5, 2.0],
              labelBuilder: _factorToString,
              onChanged: (val) => setState(() => _simWidthFactor = val),
            ),
            const TextSpan(text: ',\n  heightFactor: '),
            _buildCodeDropdown<double?>(
              value: _simHeightFactor,
              options: const [null, 1.5, 2.0],
              labelBuilder: _factorToString,
              onChanged: (val) => setState(() => _simHeightFactor = val),
            ),
            const TextSpan(text: ',\n  child: Container(\n    width: 80.0,\n    height: 80.0,\n    color: '),
            _buildCodeDropdown<Color>(
              value: _simChildColor,
              options: const [Colors.deepOrange, Colors.blue, Colors.teal, Colors.purple],
              labelBuilder: _colorToString,
              onChanged: (val) => setState(() => _simChildColor = val!),
            ),
            const TextSpan(text: ',\n    child: Text(\'Filho\'),\n  ),\n);'),
          ],
        ),
      );
    }
  }

  // Widget de seletor para colocar no meio da sintaxe do código
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
          color: Colors.deepOrange.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, size: 16, color: Colors.deepOrange),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.deepOrange,
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
        color: Colors.deepOrange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepOrange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
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