import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula de ThemeData',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
            foregroundColor: Colors.white, // Adicionado para contraste do texto
          ),
        ),
      ),
      home: const TelaExemploTheme(),
    );
  }
}

class TelaExemploTheme extends StatelessWidget {
  const TelaExemploTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. appBarTheme: testa o backgroundColor e foregroundColor (texto e ícone)
      appBar: AppBar(
        title: const Text('Entendendo o ThemeData'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      // 2. scaffoldBackgroundColor: testa a cor de fundo desta área inteira
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 3. textTheme (titleLarge): precisa ser chamado explicitamente
            Text(
              'Este é o Título (titleLarge)',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // 4. textTheme (bodyMedium): aplicado automaticamente a textos comuns
            const Text(
              'Este é o texto padrão da aplicação (bodyMedium). Se você alterar o tamanho da fonte ou a cor no ThemeData, este parágrafo será atualizado automaticamente sem precisar de nenhuma chamada extra.',
            ),
            const SizedBox(height: 40),
            
            // 5. elevatedButtonTheme: testa a cor de fundo padronizada
            ElevatedButton(
              onPressed: () {},
              child: const Text('Botão Elevado'),
            ),
            
            const SizedBox(height: 24),
            
            // Extra: testa o colorScheme.primary 
            Container(
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              child: const Text(
                'Caixa usando a cor primária do ColorScheme com transparência.',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      // Extra: O FAB herda cores do colorScheme no Material 3
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
