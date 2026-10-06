import 'package:flutter/material.dart';

class SizedBoxScreen extends StatefulWidget {
  const SizedBoxScreen({super.key});

  @override
  State<SizedBoxScreen> createState() => _SizedBoxScreenState();
}

class _SizedBoxScreenState extends State<SizedBoxScreen> {
  int _selectedConfigIndex = 0; // 0: Base (Slide), 1: Construtores, 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  double _simWidth = 150.0;
  double _simHeight = 80.0;
  Color _simChildColor = Colors.teal;

  // Função auxiliar de formatação de cores para o código
  String _colorToString(Color color) {
    if (color == Colors.teal) return 'Colors.teal';
    if (color == Colors.amber) return 'Colors.amber';
    if (color == Colors.purple) return 'Colors.purple';
    if (color == Colors.indigo) return 'Colors.indigo';
    return 'Color(...)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: SizedBox'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é o SizedBox?',
              'É um widget que força o seu filho a ter uma largura e/ou altura fixas. Também pode ser usado sem filho como um espaçador invisível em Columns e Rows.',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA VISUAL DO SIZEDBOX
            _buildSectionTitle('Prévia Visual do SizedBox:'),
            const SizedBox(height: 8),
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Center(
                child: _buildPreviewSizedBox(),
              ),
            ),
            const SizedBox(height: 20),

            // 2. SELEÇÃO DA CONFIGURAÇÃO
            _buildSectionTitle('Escolha a configuração do código:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Base (Slide)')),
                ButtonSegment(value: 1, label: Text('Construtores')),
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
  Widget _buildPreviewSizedBox() {
    switch (_selectedConfigIndex) {
      case 1: // Construtor Nomeado (SizedBox.square)
        return Container(
          width: 180,
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade300, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
            color: Colors.teal.shade50,
          ),
          child: Center(
            child: SizedBox.square(
              dimension: 100.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Square\n100x100',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );

      case 2: // Simulador Interativo
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal.shade300, width: 2, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            width: _simWidth,
            height: _simHeight,
            child: Container(
              decoration: BoxDecoration(
                color: _simChildColor,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                '${_simWidth.toInt()} x ${_simHeight.toInt()}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );

      case 0:
      default: // Base (Slide)
        return SizedBox(
          width: 160,
          height: 90,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: const Text(
              'SizedBox Base\n160x90',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
    }
  }

  // Renderiza o bloco de código correspondente
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.teal, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedConfigIndex == 0) {
      // CÓDIGO BASE (SLIDE)
      return const Text(
        '''SizedBox(
  width: 160.0,
  height: 90.0,
  child: Container(
    color: Colors.teal,
    child: Text('SizedBox Base'),
  ),
);''',
        style: textStyleCode,
      );
    } else if (_selectedConfigIndex == 1) {
      // CÓDIGO COM CONSTRUTOR NOMEADO (DESTAQUE)
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: '// Construtor utilitário para dimensões quadradas iguais:\n'),
            TextSpan(text: 'SizedBox.square(\n', style: textStyleHighlight),
            TextSpan(text: '  dimension: 100.0, // Define largura e altura iguais\n', style: textStyleHighlight),
            TextSpan(text: '  child: Container(\n    color: Colors.teal,\n  ),\n);'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'SizedBox(\n  width: '),
            _buildCodeDropdown<double>(
              value: _simWidth,
              options: const [100.0, 150.0, 200.0],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simWidth = val!),
            ),
            const TextSpan(text: ',\n  height: '),
            _buildCodeDropdown<double>(
              value: _simHeight,
              options: const [50.0, 80.0, 120.0],
              labelBuilder: (v) => '$v',
              onChanged: (val) => setState(() => _simHeight = val!),
            ),
            const TextSpan(text: ',\n  child: Container(\n    color: '),
            _buildCodeDropdown<Color>(
              value: _simChildColor,
              options: const [Colors.teal, Colors.amber, Colors.purple, Colors.indigo],
              labelBuilder: _colorToString,
              onChanged: (val) => setState(() => _simChildColor = val!),
            ),
            const TextSpan(text: ',\n  ),\n);'),
          ],
        ),
      );
    }
  }

  // Seletor para usar dentro da sintaxe do código
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
          color: Colors.teal.withOpacity(0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: Icon(Icons.arrow_drop_down, size: 16, color: Colors.teal.shade800),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.teal.shade800,
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
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
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