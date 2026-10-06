import 'package:flutter/material.dart';

class ColumnScreen extends StatefulWidget {
  const ColumnScreen({super.key});

  @override
  State<ColumnScreen> createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  int _selectedConfigIndex = 0; // 0: Base (Slide), 1: Espaçado & Ajustado, 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  MainAxisAlignment _simMainAxisAlignment = MainAxisAlignment.center;
  CrossAxisAlignment _simCrossAxisAlignment = CrossAxisAlignment.center;
  MainAxisSize _simMainAxisSize = MainAxisSize.max;

  // Funções auxiliares para formatar os enums no código
  String _mainAxisAlignmentToString(MainAxisAlignment alignment) {
    switch (alignment) {
      case MainAxisAlignment.start:
        return 'MainAxisAlignment.start';
      case MainAxisAlignment.center:
        return 'MainAxisAlignment.center';
      case MainAxisAlignment.end:
        return 'MainAxisAlignment.end';
      case MainAxisAlignment.spaceBetween:
        return 'MainAxisAlignment.spaceBetween';
      case MainAxisAlignment.spaceAround:
        return 'MainAxisAlignment.spaceAround';
      case MainAxisAlignment.spaceEvenly:
        return 'MainAxisAlignment.spaceEvenly';
    }
  }

  String _crossAxisAlignmentToString(CrossAxisAlignment alignment) {
    switch (alignment) {
      case CrossAxisAlignment.start:
        return 'CrossAxisAlignment.start';
      case CrossAxisAlignment.center:
        return 'CrossAxisAlignment.center';
      case CrossAxisAlignment.end:
        return 'CrossAxisAlignment.end';
      case CrossAxisAlignment.stretch:
        return 'CrossAxisAlignment.stretch';
      default:
        return 'CrossAxisAlignment.center';
    }
  }

  String _mainAxisSizeToString(MainAxisSize size) {
    return size == MainAxisSize.max ? 'MainAxisSize.max' : 'MainAxisSize.min';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: Column'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é a Column?',
              'Organiza os seus widgets filhos numa disposição linear vertical. O seu eixo principal (main) é vertical e o seu eixo cruzado (cross) é horizontal.',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA VISUAL DA COLUMN
            _buildSectionTitle('Prévia Visual da Column:'),
            const SizedBox(height: 8),
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: _buildPreviewColumn(),
            ),
            const SizedBox(height: 20),

            // 2. SELEÇÃO DA CONFIGURAÇÃO
            _buildSectionTitle('Escolha a configuração do código:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Base (Slide)')),
                ButtonSegment(value: 1, label: Text('Avançado')),
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

  // Constrói a prévia conforme a seleção
  Widget _buildPreviewColumn() {
    switch (_selectedConfigIndex) {
      case 1: // Espaçado & Ajustado
        return Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade300, width: 2),
              borderRadius: BorderRadius.circular(8),
              color: Colors.blue.shade50,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildBox('Item 1 (stretch)', Colors.blue.shade300),
                _buildBox('Item 2 (stretch)', Colors.blue.shade500),
                _buildBox('Item 3 (stretch)', Colors.blue.shade700),
              ],
            ),
          ),
        );

      case 2: // Simulador Interativo
        return Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade300, width: 2, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: _simMainAxisSize,
              mainAxisAlignment: _simMainAxisAlignment,
              crossAxisAlignment: _simCrossAxisAlignment,
              children: [
                _buildBox('Item 1 (w: 80)', Colors.blue.shade300, width: 80),
                _buildBox('Item 2 (w: 120)', Colors.blue.shade500, width: 120),
                _buildBox('Item 3 (w: 60)', Colors.blue.shade700, width: 60),
              ],
            ),
          ),
        );

      case 0:
      default: // Base (Slide)
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildBox('Item 1', Colors.blue.shade300, width: 100),
            _buildBox('Item 2', Colors.blue.shade500, width: 100),
            _buildBox('Item 3', Colors.blue.shade700, width: 100),
          ],
        );
    }
  }

  // Helper para criar as caixas internas da Column
  Widget _buildBox(String text, Color color, {double? width}) {
    return Container(
      width: width,
      height: 40,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  // Renderiza o código correspondente
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.blue, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedConfigIndex == 0) {
      // CÓDIGO BASE (SLIDE)
      return const Text(
        '''Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisSize: MainAxisSize.max,
  children: [
    Container(width: 100, height: 40, color: Colors.blue.shade300),
    Container(width: 100, height: 40, color: Colors.blue.shade500),
    Container(width: 100, height: 40, color: Colors.blue.shade700),
  ],
);''',
        style: textStyleCode,
      );
    } else if (_selectedConfigIndex == 1) {
      // CÓDIGO DESTAQUE
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: 'Column(\n'),
            TextSpan(text: '  mainAxisSize: MainAxisSize.min, // Ocupa a altura mínima dos filhos\n', style: textStyleHighlight),
            TextSpan(text: '  mainAxisAlignment: MainAxisAlignment.spaceEvenly,\n'),
            TextSpan(text: '  crossAxisAlignment: CrossAxisAlignment.stretch, // Estica na horizontal\n', style: textStyleHighlight),
            TextSpan(text: '  children: [\n    Widget1(),\n    Widget2(),\n    Widget3(),\n  ],\n);'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'Column(\n  mainAxisAlignment: '),
            _buildCodeDropdown<MainAxisAlignment>(
              value: _simMainAxisAlignment,
              options: const [
                MainAxisAlignment.start,
                MainAxisAlignment.center,
                MainAxisAlignment.end,
                MainAxisAlignment.spaceBetween,
                MainAxisAlignment.spaceAround,
                MainAxisAlignment.spaceEvenly,
              ],
              labelBuilder: _mainAxisAlignmentToString,
              onChanged: (val) => setState(() => _simMainAxisAlignment = val!),
            ),
            const TextSpan(text: ',\n  crossAxisAlignment: '),
            _buildCodeDropdown<CrossAxisAlignment>(
              value: _simCrossAxisAlignment,
              options: const [
                CrossAxisAlignment.start,
                CrossAxisAlignment.center,
                CrossAxisAlignment.end,
                CrossAxisAlignment.stretch,
              ],
              labelBuilder: _crossAxisAlignmentToString,
              onChanged: (val) => setState(() => _simCrossAxisAlignment = val!),
            ),
            const TextSpan(text: ',\n  mainAxisSize: '),
            _buildCodeDropdown<MainAxisSize>(
              value: _simMainAxisSize,
              options: const [MainAxisSize.max, MainAxisSize.min],
              labelBuilder: _mainAxisSizeToString,
              onChanged: (val) => setState(() => _simMainAxisSize = val!),
            ),
            const TextSpan(text: ',\n  children: [\n    Item(width: 80),\n    Item(width: 120),\n    Item(width: 60),\n  ],\n);'),
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
          color: Colors.blue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, size: 16, color: Colors.blue),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.blue,
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
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
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