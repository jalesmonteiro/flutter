import 'package:flutter/material.dart';

class ScaffoldScreen extends StatefulWidget {
  const ScaffoldScreen({super.key});

  @override
  State<ScaffoldScreen> createState() => _ScaffoldScreenState();
}

class _ScaffoldScreenState extends State<ScaffoldScreen> {
  int _selectedConfigIndex = 0; // 0: Slide 15, 1: Layout Alternativo, 2: Simulador Interativo

  // Variáveis de estado para o Simulador Interativo (Opção 2)
  bool _simHasAppBar = true;
  bool _simHasDrawer = true;
  bool _simHasBottomNav = true;
  Color _simBgColor = Colors.teal.shade50;
  FloatingActionButtonLocation _simFabLocation = FloatingActionButtonLocation.centerDocked;

  // Auxiliar para converter a cor numa string para o código
  String _colorToString(Color color) {
    if (color == Colors.white) return 'Colors.white';
    if (color == Colors.grey.shade100) return 'Colors.grey.shade100';
    if (color == Colors.teal.shade50) return 'Colors.teal.shade50';
    if (color == Colors.amber.shade50) return 'Colors.amber.shade50';
    return 'Color(...)';
  }

  // Auxiliar para converter a posição do FAB em string
  String _fabLocationToString(FloatingActionButtonLocation loc) {
    if (loc == FloatingActionButtonLocation.endFloat) return 'endFloat';
    if (loc == FloatingActionButtonLocation.centerFloat) return 'centerFloat';
    if (loc == FloatingActionButtonLocation.centerDocked) return 'centerDocked';
    return 'endFloat';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget: Scaffold'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCardHeader(
              'O que é o Scaffold?',
              'É a estrutura visual básica do Material Design. Oferece APIs para exibir AppBar, Drawer, BottomNavigationBar e FloatingActionButton.',
            ),
            const SizedBox(height: 16),

            // 1. PRÉVIA VISUAL DO SCAFFOLD
            _buildSectionTitle('Prévia Visual da Estrutura:'),
            const SizedBox(height: 8),

            // Moldura simulando o ecran de um telemovel
            Container(
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.teal.shade300, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildPreviewScaffold(),
            ),
            const SizedBox(height: 20),

            // 2. SELEÇÃO DA CONFIGURAÇÃO
            _buildSectionTitle('Escolha a configuração do código:'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Slide 15')),
                ButtonSegment(value: 1, label: Text('Alternativo')),
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

            // 3. CÓDIGO GERADOR
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

  // Constrói o Scaffold da prévia dependendo da opção selecionada
  Widget _buildPreviewScaffold() {
    switch (_selectedConfigIndex) {
      case 1: // Layout Alternativo
        return Scaffold(
          backgroundColor: Colors.teal.shade50,
          appBar: AppBar(
            title: const Text('Layout Alternativo'),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          body: const Center(
            child: Text(
              'Corpo Principal (body)',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.teal.shade100,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.home, color: Colors.teal),
                  Icon(Icons.person, color: Colors.teal),
                ],
              ),
            ),
          ),
        );

      case 2: // Simulador Interativo
        return Scaffold(
          backgroundColor: _simBgColor,
          appBar: _simHasAppBar
              ? AppBar(
            title: const Text('Simulador Scaffold'),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          )
              : null,
          drawer: _simHasDrawer
              ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.teal),
                  child: Text('Menu Drawer', style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
                ListTile(leading: Icon(Icons.home), title: Text('Início')),
              ],
            ),
          )
              : null,
          body: const Center(
            child: Text(
              'Corpo da Aplicação (body)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: _simFabLocation,
          bottomNavigationBar: _simHasBottomNav
              ? BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
            ],
          )
              : null,
        );

      case 0:
      default: // Slide 15 (Padrão)
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Minha Aplicação'),
            backgroundColor: const Color(0xFF01A534),
            foregroundColor: Colors.white,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                UserAccountsDrawerHeader(
                  accountName: Text('Aluno Flutter'),
                  accountEmail: Text('aluno@ifpb.edu.br'),
                  decoration: BoxDecoration(color: Color(0xFF01A534)),
                ),
                ListTile(leading: Icon(Icons.home), title: Text('Página Inicial')),
              ],
            ),
          ),
          body: const Center(
            child: Text(
              'Conteúdo do App',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xFF01A534),
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        );
    }
  }

  // Gera o código visual correspondente
  Widget _buildCodeView() {
    const textStyleCode = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.black87, height: 1.5);
    const textStyleHighlight = TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.teal, fontWeight: FontWeight.bold, height: 1.5);

    if (_selectedConfigIndex == 0) {
      // CÓDIGO PADRÃO (SLIDE 15)
      return const Text(
        '''Scaffold(
  backgroundColor: Colors.white,
  appBar: AppBar(
    title: Text('Minha Aplicação'),
    backgroundColor: Color(0xFF01A534),
  ),
  drawer: Drawer(
    child: ListView(...),
  ),
  body: Center(
    child: Text('Conteúdo do App'),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
);''',
        style: textStyleCode,
      );
    } else if (_selectedConfigIndex == 1) {
      // CÓDIGO ALTERNATIVO COM DESTAQUES
      return RichText(
        text: const TextSpan(
          style: textStyleCode,
          children: [
            TextSpan(text: 'Scaffold(\n'),
            TextSpan(text: '  backgroundColor: Colors.teal.shade50,\n', style: textStyleHighlight),
            TextSpan(text: '  appBar: AppBar(title: Text(\'Layout Alternativo\')),\n  body: Center(child: Text(\'Corpo Principal\')),\n  floatingActionButton: FloatingActionButton(...),\n'),
            TextSpan(text: '  floatingActionButtonLocation:\n      FloatingActionButtonLocation.centerDocked,\n', style: textStyleHighlight),
            TextSpan(text: '  bottomNavigationBar: BottomAppBar(...),\n', style: textStyleHighlight),
            TextSpan(text: ');'),
          ],
        ),
      );
    } else {
      // SIMULADOR: CÓDIGO COM SELECTS EMBUTIDOS
      return RichText(
        text: TextSpan(
          style: textStyleCode,
          children: [
            const TextSpan(text: 'Scaffold(\n  backgroundColor: '),
            _buildCodeDropdown<Color>(
              value: _simBgColor,
              options: [Colors.white, Colors.grey.shade100, Colors.teal.shade50, Colors.amber.shade50],
              labelBuilder: _colorToString,
              onChanged: (val) => setState(() => _simBgColor = val!),
            ),
            const TextSpan(text: ',\n  appBar: '),
            _buildCodeDropdown<bool>(
              value: _simHasAppBar,
              options: const [true, false],
              labelBuilder: (v) => v ? 'AppBar(...)' : 'null',
              onChanged: (val) => setState(() => _simHasAppBar = val!),
            ),
            const TextSpan(text: ',\n  drawer: '),
            _buildCodeDropdown<bool>(
              value: _simHasDrawer,
              options: const [true, false],
              labelBuilder: (v) => v ? 'Drawer(...)' : 'null',
              onChanged: (val) => setState(() => _simHasDrawer = val!),
            ),
            const TextSpan(text: ',\n  body: Center(child: Text(\'Corpo da Aplicação\')),\n  floatingActionButton: FloatingActionButton(...),\n  floatingActionButtonLocation:\n      FloatingActionButtonLocation.'),
            _buildCodeDropdown<FloatingActionButtonLocation>(
              value: _simFabLocation,
              options: const [
                FloatingActionButtonLocation.endFloat,
                FloatingActionButtonLocation.centerFloat,
                FloatingActionButtonLocation.centerDocked,
              ],
              labelBuilder: _fabLocationToString,
              onChanged: (val) => setState(() => _simFabLocation = val!),
            ),
            const TextSpan(text: ',\n  bottomNavigationBar: '),
            _buildCodeDropdown<bool>(
              value: _simHasBottomNav,
              options: const [true, false],
              labelBuilder: (v) => v ? 'BottomNavigationBar(...)' : 'null',
              onChanged: (val) => setState(() => _simHasBottomNav = val!),
            ),
            const TextSpan(text: ',\n);'),
          ],
        ),
      );
    }
  }

  // Widget genérico para dropdowns dentro do código
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
          icon: const Icon(Icons.arrow_drop_down, size: 16, color: Colors.teal),
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Colors.teal,
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
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