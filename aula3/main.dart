import 'package:flutter/material.dart';

// Importação das telas de cada widget estudado na aula
import 'screens/theme_data_screen.dart';
import 'screens/text_screen.dart';
import 'screens/scaffold_screen.dart';
import 'screens/container_screen.dart';
import 'screens/center_screen.dart';
import 'screens/column_screen.dart';
import 'screens/row_screen.dart';
import 'screens/sized_box_screen.dart';
import 'screens/expanded_screen.dart';
import 'screens/text_field_screen.dart';

void main() {
  runApp(const MeuAppFlutter());
}

/// Widget raiz configurando MaterialApp e ThemeData centralizados (Slides 8 a 15)
class MeuAppFlutter extends StatelessWidget {
  const MeuAppFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Propriedades principais do MaterialApp vistas no Slide 9 e 10
      title: 'Desenvolvimento Mobile - Flutter Widgets',
      debugShowCheckedModeBanner: false, // Remoção da tarja DEBUG (Exercício 01)
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: const Color(0xFF01A534), // Cor verde institucional do IFPB
        ),
        scaffoldBackgroundColor: Colors.grey.shade50,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF01A534),
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF01A534),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      home: const MenuPrincipalScreen(),
      // Navegação por rotas nomeadas (Slide 9 e 10)
      routes: {
        '/theme': (context) => const ThemeDataScreen(),
        '/text': (context) => const TextScreen(),
        '/scaffold': (context) => const ScaffoldScreen(),
        '/container': (context) => const ContainerScreen(),
        '/center': (context) => const CenterScreen(),
        '/column': (context) => const ColumnScreen(),
        '/row': (context) => const RowScreen(),
        '/sized_box': (context) => const SizedBoxScreen(),
        '/expanded': (context) => const ExpandedScreen(),
        '/text_field': (context) => const TextFieldScreen(),
      },
    );
  }
}

/// Modelo de dados para os itens do menu
class MenuItemData {
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final Color color;
  final String routeName;

  const MenuItemData({
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.color,
    required this.routeName,
  });
}

/// Tela de menu principal para acessar os exemplos de cada widget
class MenuPrincipalScreen extends StatelessWidget {
  const MenuPrincipalScreen({super.key});

  static const List<MenuItemData> items = [
    MenuItemData(
      title: 'MaterialApp & ThemeData',
      category: 'Estrutura & Tema',
      description: 'Configuração raiz, rotas, paleta de cores e Material 3.',
      icon: Icons.palette_outlined,
      color: Color(0xFF01A534),
      routeName: '/theme',
    ),
    MenuItemData(
      title: 'Text',
      category: 'Texto',
      description: 'Estilização de fontes, cores, alinhamentos e quebra de linha.',
      icon: Icons.text_fields_outlined,
      color: Colors.deepPurple,
      routeName: '/text',
    ),
    MenuItemData(
      title: 'Scaffold',
      category: 'Layout (Andaime)',
      description: 'Esqueleto com AppBar, Body, Drawer e FloatingActionButton.',
      icon: Icons.web_asset_outlined,
      color: Colors.purple,
      routeName: '/scaffold',
    ),
    MenuItemData(
      title: 'Container',
      category: 'Básicos',
      description: 'Pintura, dimensões, padding, margem e BoxDecoration.',
      icon: Icons.crop_square_outlined,
      color: Colors.teal,
      routeName: '/container',
    ),
    MenuItemData(
      title: 'Center',
      category: 'Layout',
      description: 'Centralização de filhos e fatores de proporção (width/height).',
      icon: Icons.center_focus_strong_outlined,
      color: Colors.orange,
      routeName: '/center',
    ),
    MenuItemData(
      title: 'Column',
      category: 'Layout',
      description: 'Organização vertical de filhos e alinhamentos nos eixos.',
      icon: Icons.view_column_outlined,
      color: Colors.blue,
      routeName: '/column',
    ),
    MenuItemData(
      title: 'Row',
      category: 'Layout',
      description: 'Organização horizontal com spaceEvenly, spaceAround e eixos.',
      icon: Icons.table_rows_outlined,
      color: Colors.cyan,
      routeName: '/row',
    ),
    MenuItemData(
      title: 'SizedBox',
      category: 'Básicos / Layout',
      description: 'Imposição de tamanho fixo e criação de espaçamentos em branco.',
      icon: Icons.space_bar_outlined,
      color: Colors.indigo,
      routeName: '/sized_box',
    ),
    MenuItemData(
      title: 'Expanded & Flexible',
      category: 'Layout',
      description: 'Preenchimento de espaço disponível e distribuição com flex.',
      icon: Icons.open_in_full_outlined,
      color: Colors.deepOrange,
      routeName: '/expanded',
    ),
    MenuItemData(
      title: 'TextField',
      category: 'Entrada de Dados',
      description: 'Controlador de texto, senhas (obscureText), bordas e eventos.',
      icon: Icons.input_outlined,
      color: Colors.teal,
      routeName: '/text_field',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter: Catálogo de Widgets'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        children: [
          // Cabeçalho da aula
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF01A534), Color(0xFF007A26)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF01A534).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.school, color: Colors.white, size: 36),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Desenvolvimento Mobile',
                        style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Flutter: Widgets Básicos',
                        style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Exemplos e exercícios práticos dos slides',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Selecione um widget para explorar:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 12),

          // Lista interativa dos widgets
          ...items.map((item) {
            return Card(
              elevation: 1.5,
              margin: const EdgeInsets.only(bottom: 12.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: item.color.withOpacity(0.15),
                  child: Icon(item.icon, color: item.color),
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.category,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(item.description, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pushNamed(context, item.routeName);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
