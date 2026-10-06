import 'package:flutter/material.dart';

class ContainerScreen extends StatefulWidget {
  const ContainerScreen({super.key});

  @override
  State<ContainerScreen> createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  int _selectedConfigIndex = 0; // 0: Exemplo Base, 1: Decorado, 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  double _simWidth = 160.0;
  double _simHeight = 120.0;
  Color _simColor = Colors.indigo;
  double _simBorderRadius = 12.0;
  double _simPadding = 16.0;
  Alignment _simAlignment = Alignment.center;

  // Funções auxiliares de formatação de código
  String _colorToString(Color color) {
    if (color == Colors.indigo) return 'Colors.indigo';
    if (color == Colors.orange) return 'Colors.orange';
    if (color == Colors.teal) return 'Colors.teal';
    if (color == Colors.purple) return 'Colors.purple';
    if (color == Colors.blue) return 'Colors.blue';
    return 'Color(...)';
  }

  String _alignmentToString(Alignment alignment) {
    if (alignment == Alignment.center) return 'Alignment.center';
    if (alignment == Alignment.topLeft) return 'Alignment.topLeft';
    if (alignment == Alignment.bottomRight) return 'Alignment.bottomRight';
    return 'Alignment.center';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: Container'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é o Container?',
              'É um widget multiuso de conveniência que combina configurações de tamanho (width/height), espaçamento (margin/padding), alinhamento, cor e bordas (BoxDecoration).',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA VISUAL DO CONTAINER
            _buildSectionTitle('Prévia Visual do Container:'),
            const SizedBox(height: 8),
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: _buildPreviewContainer(),
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

  // Constrói a prévia do Container conforme a seleção
  Widget _buildPreviewContainer() {
    switch (_selectedConfigIndex) {
      case 1: // Decorado (Com Destaque)
        return Container(
          width: 200,
          height: 140,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(color: Colors.indigo.shade200, width: 2),
          ),
          child: const Text(
            'Container Decorado',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        );

      case 2: // Simulador Interativo
        return Container(
          width: _simWidth,
          height: _simHeight,
          padding: EdgeInsets.all(_simPadding),
          alignment: _simAlignment,
          decoration: BoxDecoration(
            color: _simColor,
            borderRadius: BorderRadius.circular(_simBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Text(
            'Texto Interno',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        );

      case 0:
      default: // Base (Slide)
        return Container(
          width: 150,
          height: 100,
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text(
            'Container Base',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
    }
  }

  // Renderiza o código correspondente à opção selecionada
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.indigo, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedConfigIndex == 0) {
      // CÓDIGO BASE (SLIDE)
      return const Text(
        '''Container(
  width: 150.0,
  height: 100.0,
  color: Colors.blue,
  alignment: Alignment.center,
  child: Text('Container Base'),
);''',
        style: textStyleCode,
      );
    } else if (_selectedConfigIndex == 1) {
      // CÓDIGO DECORADO COM DESTAQUES
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: 'Container(\n  width: 200.0,\n  height: 140.0,\n'),
            TextSpan(text: '  margin: EdgeInsets.all(12.0),\n  padding: EdgeInsets.all(16.0),\n', style: textStyleHighlight),
            TextSpan(text: '  alignment: Alignment.center,\n'),
            TextSpan(text: '  decoration: BoxDecoration(\n    color: Colors.indigo,\n', style: textStyleHighlight),
            TextSpan(text: '    borderRadius: BorderRadius.circular(20.0),\n', style: textStyleHighlight),
            TextSpan(text: '    boxShadow: [BoxShadow(...)],\n    border: Border.all(width: 2.0),\n  ),\n', style: textStyleHighlight),
            TextSpan(text: '  child: Text(\'Container Decorado\'),\n);'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'Container(\n  width: '),
            _buildCodeDropdown<double>(
              value: _simWidth,
              options: const [120.0, 160.0, 200.0],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simWidth = val!),
            ),
            const TextSpan(text: ',\n  height: '),
            _buildCodeDropdown<double>(
              value: _simHeight,
              options: const [80.0, 120.0, 160.0],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simHeight = val!),
            ),
            const TextSpan(text: ',\n  padding: EdgeInsets.all('),
            _buildCodeDropdown<double>(
              value: _simPadding,
              options: const [0.0, 8.0, 16.0, 24.0],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simPadding = val!),
            ),
            const TextSpan(text: '),\n  alignment: '),
            _buildCodeDropdown<Alignment>(
              value: _simAlignment,
              options: const [Alignment.center, Alignment.topLeft, Alignment.bottomRight],
              labelBuilder: _alignmentToString,
              onChanged: (val) => setState(() => _simAlignment = val!),
            ),
            const TextSpan(text: ',\n  decoration: BoxDecoration(\n    color: '),
            _buildCodeDropdown<Color>(
              value: _simColor,
              options: const [Colors.indigo, Colors.orange, Colors.teal, Colors.purple, Colors.blue],
              labelBuilder: _colorToString,
              onChanged: (val) => setState(() => _simColor = val!),
            ),
            const TextSpan(text: ',\n    borderRadius: BorderRadius.circular('),
            _buildCodeDropdown<double>(
              value: _simBorderRadius,
              options: const [0.0, 12.0, 24.0, 50.0],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simBorderRadius = val!),
            ),
            const TextSpan(text: '),\n  ),\n  child: Text(\'Texto Interno\'),\n);'),
          ],
        ),
      );
    }
  }

  // Seletor adaptado para aparecer dentro do bloco de código
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
          color: Colors.indigo.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, size: 16, color: Colors.indigo),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.indigo,
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
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
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