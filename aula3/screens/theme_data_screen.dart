import 'package:flutter/material.dart';

class ThemeDataScreen extends StatefulWidget {
  const ThemeDataScreen({super.key});

  @override
  State<ThemeDataScreen> createState() => _ThemeDataScreenState();
}

class _ThemeDataScreenState extends State<ThemeDataScreen> {
  int _selectedThemeIndex = 0; // 0: IFPB Green, 1: Exemplo Tema Escuro, 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  Color _simSeedColor = Colors.deepPurple;
  Color _simScaffoldBg = Colors.grey.shade100;
  Color _simAppBarBg = Colors.deepPurple;
  Color _simAppBarFg = Colors.white;

  // Função auxiliar para converter a cor numa string para o código e para os Dropdowns
  String _colorToString(Color color) {
    if (color == Colors.green) return 'Colors.green';
    if (color == const Color(0xFF01A534)) return 'Color(0xFF01A534)';
    if (color == Colors.blue) return 'Colors.blue';
    if (color == Colors.red) return 'Colors.red';
    if (color == Colors.deepPurple) return 'Colors.deepPurple';
    if (color == Colors.amber) return 'Colors.amber';
    if (color == Colors.white) return 'Colors.white';
    if (color == Colors.black) return 'Colors.black';
    if (color == Colors.grey.shade100) return 'Colors.grey.shade100';
    if (color == Colors.grey.shade900) return 'Colors.grey.shade900';
    return 'Cor Personalizada';
  }

  // Retorna os dados do tema simulado para a pré-visualização
  ThemeData _getPreviewTheme() {
    switch (_selectedThemeIndex) {
      case 1: // Novo Exemplo: Tema Escuro (Dark Mode)
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: Colors.grey.shade900,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
            foregroundColor: Colors.amber,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.amber),
            bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white70),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
            ),
          ),
        );
      case 2: // Simulador Interativo
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: _simSeedColor,
          ),
          scaffoldBackgroundColor: _simScaffoldBg,
          appBarTheme: AppBarTheme(
            backgroundColor: _simAppBarBg,
            foregroundColor: _simAppBarFg,
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: _simAppBarBg),
            bodyMedium: const TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(backgroundColor: _simSeedColor, foregroundColor: Colors.white),
          ),
        );
      case 0:
      default: // Exemplo IFPB do Slide 14
        return ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            primary: const Color(0xFF01A534),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF01A534),
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF01A534),
              foregroundColor: Colors.white,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final previewTheme = _getPreviewTheme();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MaterialApp & ThemeData'),
        backgroundColor: const Color(0xFF01A534),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'MaterialApp & ThemeData',
              'O ThemeData centraliza cores, fontes, estilos de botões e comportamento visual de toda a aplicação.',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA MOVIDA PARA CIMA
            _buildSectionTitle('Prévia do Tema Aplicado:'),
            const SizedBox(height: 8),
            Theme(
              data: previewTheme,
              child: Builder(
                builder: (previewContext) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Theme.of(previewContext).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppBar(
                          title: const Text('Simulação de AppBar'),
                          automaticallyImplyLeading: false,
                          actions: const [
                            Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Icon(Icons.palette),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Título do App',
                                style: Theme.of(previewContext).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Este é um texto comum utilizando o bodyMedium configurado no tema global para testar o contraste.',
                                style: Theme.of(previewContext).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Botão do Tema'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // 2. SELEÇÃO DA CONFIGURAÇÃO
            _buildSectionTitle('Escolha a configuração do código:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Slide 14')),
                ButtonSegment(value: 1, label: Text('Exemplo Escuro')),
                ButtonSegment(value: 2, label: Text('Simulador')),
              ],
              selected: {_selectedThemeIndex},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedThemeIndex = newSelection.first;
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

  // Constrói o bloco de código com base na seleção
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.blueAccent, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedThemeIndex == 0) {
      // CÓDIGO BASE (SLIDE 14)
      return const Text(
        '''ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.green,
    primary: Color(0xFF01A534),
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF01A534),
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF01A534),
      foregroundColor: Colors.white,
    ),
  ),
);''',
        style: textStyleCode,
      );
    } else if (_selectedThemeIndex == 1) {
      // CÓDIGO TEMA ESCURO COM DESTAQUE
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: 'ThemeData(\n  useMaterial3: true,\n  colorScheme: ColorScheme.fromSeed(\n'),
            TextSpan(text: '    seedColor: Colors.amber,\n', style: textStyleHighlight),
            TextSpan(text: '    brightness: Brightness.dark,\n', style: textStyleHighlight),
            TextSpan(text: '  ),\n'),
            TextSpan(text: '  scaffoldBackgroundColor: Colors.grey.shade900,\n', style: textStyleHighlight),
            TextSpan(text: '  appBarTheme: AppBarTheme(\n'),
            TextSpan(text: '    backgroundColor: Colors.grey.shade900,\n', style: textStyleHighlight),
            TextSpan(text: '    foregroundColor: Colors.amber,\n', style: textStyleHighlight),
            TextSpan(text: '  ),\n  elevatedButtonTheme: ElevatedButtonThemeData(\n    style: ElevatedButton.styleFrom(\n'),
            TextSpan(text: '      backgroundColor: Colors.amber,\n', style: textStyleHighlight),
            TextSpan(text: '      foregroundColor: Colors.black,\n', style: textStyleHighlight),
            TextSpan(text: '    ),\n  ),\n);'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'ThemeData(\n  useMaterial3: true,\n  colorScheme: ColorScheme.fromSeed(\n    seedColor: '),
            _buildCodeDropdown(
              value: _simSeedColor,
              options: [Colors.green, Colors.blue, Colors.red, Colors.deepPurple, Colors.amber],
              onChanged: (val) => setState(() => _simSeedColor = val!),
            ),
            const TextSpan(text: ',\n  ),\n  scaffoldBackgroundColor: '),
            _buildCodeDropdown(
              value: _simScaffoldBg,
              options: [Colors.white, Colors.grey.shade100, Colors.grey.shade900, Colors.black],
              onChanged: (val) => setState(() => _simScaffoldBg = val!),
            ),
            const TextSpan(text: ',\n  appBarTheme: AppBarTheme(\n    backgroundColor: '),
            _buildCodeDropdown(
              value: _simAppBarBg,
              options: [Colors.green, Colors.blue, Colors.red, Colors.deepPurple, Colors.amber, Colors.grey.shade900, Colors.white],
              onChanged: (val) => setState(() => _simAppBarBg = val!),
            ),
            const TextSpan(text: ',\n    foregroundColor: '),
            _buildCodeDropdown(
              value: _simAppBarFg,
              options: [Colors.white, Colors.black, Colors.amber],
              onChanged: (val) => setState(() => _simAppBarFg = val!),
            ),
            const TextSpan(text: ',\n  ),\n);'),
          ],
        ),
      );
    }
  }

  // Cria um dropdown visualmente adaptado para parecer código
  WidgetSpan _buildCodeDropdown({
    required Color value,
    required List<Color> options,
    required ValueChanged<Color?> onChanged,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Container(
        height: 24, // Altura compacta para não quebrar demasiado o espaçamento do texto
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: DropdownButton<Color>(
          value: value,
          isDense: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, size: 16, color: Colors.blueAccent),
          style: const TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.blueAccent, fontWeight: FontWeight.bold),
          items: options.map((color) {
            return DropdownMenuItem<Color>(
              value: color,
              child: Text(_colorToString(color)),
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
        color: const Color(0xFF01A534).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF01A534).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF01A534),
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