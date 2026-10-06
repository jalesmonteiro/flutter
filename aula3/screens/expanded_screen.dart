import 'package:flutter/material.dart';

class ExpandedScreen extends StatefulWidget {
  const ExpandedScreen({super.key});

  @override
  State<ExpandedScreen> createState() => _ExpandedScreenState();
}

class _ExpandedScreenState extends State<ExpandedScreen> {
  int _selectedConfigIndex = 0; // 0: Base (Slide), 1: Proporções (Flex), 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  int _simFlex1 = 1;
  int _simFlex2 = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: Expanded'),
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é o Expanded?',
              'É um widget que força o seu filho a expandir e preencher todo o espaço disponível restante ao longo do eixo principal de uma Row, Column ou Flex.',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA VISUAL DO EXPANDED
            _buildSectionTitle('Prévia Visual do Expanded:'),
            const SizedBox(height: 8),
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: _buildPreviewExpanded(),
              ),
            ),
            const SizedBox(height: 20),

            // 2. SELEÇÃO DA CONFIGURAÇÃO
            _buildSectionTitle('Escolha a configuração do código:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Base (Slide)')),
                ButtonSegment(value: 1, label: Text('Proporções')),
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
  Widget _buildPreviewExpanded() {
    switch (_selectedConfigIndex) {
      case 1: // Proporções Flex (1 vs 2)
        return Container(
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple.shade300, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
            color: Colors.purple.shade50,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'flex: 1\n(1/3)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade700,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'flex: 2\n(2/3)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        );

      case 2: // Simulador Interativo
        return Container(
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple.shade300, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                flex: _simFlex1,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'flex: $_simFlex1',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: _simFlex2,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade700,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'flex: $_simFlex2',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );

      case 0:
      default: // Base (Slide) - Caixinha fixa + Expanded
        return Container(
          height: 90,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple.shade200, width: 1.5, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Fixa\n80px',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade600,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Expanded\n(Preenche o resto)',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }

  // Renderiza o bloco de código
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.purple, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedConfigIndex == 0) {
      // CÓDIGO BASE (SLIDE)
      return const Text(
        '''Row(
  children: [
    Container(width: 80, child: Text('Fixa')),
    Expanded(
      child: Container(
        color: Colors.purple,
        child: Text('Expanded'),
      ),
    ),
  ],
);''',
        style: textStyleCode,
      );
    } else if (_selectedConfigIndex == 1) {
      // CÓDIGO PROPORÇÕES (DESTAQUE)
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: 'Row(\n  children: [\n'),
            TextSpan(text: '    Expanded(\n      flex: 1, // Ocupa 1 parte do espaço total (1/3)\n', style: textStyleHighlight),
            TextSpan(text: '      child: Container(color: Colors.purple.shade400),\n    ),\n'),
            TextSpan(text: '    Expanded(\n      flex: 2, // Ocupa 2 partes do espaço total (2/3)\n', style: textStyleHighlight),
            TextSpan(text: '      child: Container(color: Colors.purple.shade700),\n    ),\n  ],\n);'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'Row(\n  children: [\n    Expanded(\n      flex: '),
            _buildCodeDropdown<int>(
              value: _simFlex1,
              options: const [1, 2, 3, 4],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simFlex1 = val!),
            ),
            const TextSpan(text: ',\n      child: Container(color: Colors.purple.shade400),\n    ),\n    Expanded(\n      flex: '),
            _buildCodeDropdown<int>(
              value: _simFlex2,
              options: const [1, 2, 3, 4],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simFlex2 = val!),
            ),
            const TextSpan(text: ',\n      child: Container(color: Colors.purple.shade700),\n    ),\n  ],\n);'),
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
          color: Colors.purple.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: Icon(Icons.arrow_drop_down, size: 16, color: Colors.purple.shade800),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.purple.shade800,
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
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
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