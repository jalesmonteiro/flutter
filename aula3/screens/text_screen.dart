import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  // Variáveis de estado para o Simulador Interativo no final da tela
  double _simFontSize = 24.0;
  FontWeight _simFontWeight = FontWeight.bold;
  Color _simColor = Colors.deepPurple;
  TextAlign _simTextAlign = TextAlign.center;

  // Funções auxiliares para formatar os valores para texto no código
  String _colorToString(Color color) {
    if (color == Colors.deepPurple) return 'Colors.deepPurple';
    if (color == Colors.red) return 'Colors.red';
    if (color == Colors.blue) return 'Colors.blue';
    if (color == Colors.green) return 'Colors.green';
    if (color == Colors.orange) return 'Colors.orange';
    return 'Color(...)';
  }

  String _fontWeightToString(FontWeight weight) {
    if (weight == FontWeight.bold) return 'FontWeight.bold';
    if (weight == FontWeight.normal) return 'FontWeight.normal';
    if (weight == FontWeight.w300) return 'FontWeight.w300';
    return 'FontWeight.bold';
  }

  String _textAlignToString(TextAlign align) {
    if (align == TextAlign.left) return 'TextAlign.left';
    if (align == TextAlign.center) return 'TextAlign.center';
    if (align == TextAlign.right) return 'TextAlign.right';
    return 'TextAlign.center';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: Text'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é o Text?',
              'Exibe uma string de caracteres com formatação e estilo específicos na interface do aplicativo.',
            ),
            const SizedBox(height: 16),

            // 1. EXEMPLO 02 DO SLIDE
            _buildSectionTitle('1. Exemplo do Slide (Exemplo 02)'),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Código: Text(\'Olá, Flutter!\', style: TextStyle(...), textAlign: TextAlign.center)',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Olá, Flutter!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 2. NOVO EXEMPLO: FORMATAÇÃO AVANÇADA (maxLines, overflow e letterSpacing)
            _buildSectionTitle('2. Outro Exemplo: Limitação de Linhas e Corte (maxLines & overflow)'),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Código: maxLines: 2, overflow: TextOverflow.ellipsis, letterSpacing: 1.2',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.deepPurple.shade200),
                      ),
                      child: const Text(
                        'Este é um texto longo escrito para demonstrar o uso do atributo maxLines em conjunto com '
                            'TextOverflow.ellipsis. Quando o texto excede o limite estipulado de linhas, o Flutter trunca '
                            'automaticamente o conteúdo e adiciona reticências no final.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          letterSpacing: 1.2,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 3. SIMULADOR INTERATIVO
            _buildSectionTitle('3. Simulador Interativo de Texto'),
            const SizedBox(height: 8),

            // Caixinha de Prévia do Texto
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resultado Visual:',
                      style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    // AQUI ESTÁ A CORREÇÃO: SizedBox com width: double.infinity
                    SizedBox(
                      width: double.infinity, // Garante que o Text ocupe toda a largura disponível!
                      child: Text(
                        'Aprender Flutter é fácil e divertido!',
                        style: TextStyle(
                          fontSize: _simFontSize,
                          fontWeight: _simFontWeight,
                          color: _simColor,
                        ),
                        textAlign: _simTextAlign,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Código Interativo com Dropdowns
            Card(
              color: Colors.grey.shade100,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                    children: [
                      const TextSpan(text: 'Text(\n  \'Aprender Flutter é fácil e divertido!\',\n  style: TextStyle(\n    fontSize: '),
                      _buildCodeDropdown<double>(
                        value: _simFontSize,
                        options: const [16.0, 20.0, 24.0, 30.0],
                        labelBuilder: (v) => '$v',
                        onChanged: (val) => setState(() => _simFontSize = val!),
                      ),
                      const TextSpan(text: ',\n    fontWeight: '),
                      _buildCodeDropdown<FontWeight>(
                        value: _simFontWeight,
                        options: const [FontWeight.w300, FontWeight.normal, FontWeight.bold],
                        labelBuilder: _fontWeightToString,
                        onChanged: (val) => setState(() => _simFontWeight = val!),
                      ),
                      const TextSpan(text: ',\n    color: '),
                      _buildCodeDropdown<Color>(
                        value: _simColor,
                        options: const [
                          Colors.deepPurple,
                          Colors.red,
                          Colors.blue,
                          Colors.green,
                          Colors.orange,
                        ],
                        labelBuilder: _colorToString,
                        onChanged: (val) => setState(() => _simColor = val!),
                      ),
                      const TextSpan(text: ',\n  ),\n  textAlign: '),
                      _buildCodeDropdown<TextAlign>(
                        value: _simTextAlign,
                        options: const [TextAlign.left, TextAlign.center, TextAlign.right],
                        labelBuilder: _textAlignToString,
                        onChanged: (val) => setState(() => _simTextAlign = val!),
                      ),
                      const TextSpan(text: ',\n);'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget genérico para construir caixas de seleção estilo código
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
          color: Colors.deepPurple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, size: 16, color: Colors.deepPurple),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.deepPurple,
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
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
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