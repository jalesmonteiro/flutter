import 'dart:async';
import 'package:flutter/material.dart';

/// Ponto de entrada da aplicação.
/// Este arquivo foi projetado para ser executado no DartPad (modo Flutter),
/// FlutLab ou em qualquer projeto Flutter local.
void main() {
  runApp(const AsyncIntroApp());
}

/// Widget raiz da aplicação que configura o tema visual e a navegação.
class AsyncIntroApp extends StatelessWidget {
  const AsyncIntroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter: Future & Async',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF02569B), // Azul institucional do Flutter
          brightness: Brightness.light,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

/// Tela principal com navegação em abas para cada tópico didático da aula.
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Telas demonstrativas correspondentes aos blocos da aula
  final List<Widget> _screens = const [
    EventLoopDemoScreen(),
    StatefulAsyncScreen(),
    FutureBuilderScreen(),
    FutureWaitScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter: Future & Async/Await',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Event Loop',
          ),
          NavigationDestination(
            icon: Icon(Icons.build_circle_outlined),
            selectedIcon: Icon(Icons.build_circle),
            label: 'Stateful',
          ),
          NavigationDestination(
            icon: Icon(Icons.widgets_outlined),
            selectedIcon: Icon(Icons.widgets),
            label: 'FutureBuilder',
          ),
          NavigationDestination(
            icon: Icon(Icons.alt_route_outlined),
            selectedIcon: Icon(Icons.alt_route),
            label: 'Future.wait',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MÓDULO 1: O Event Loop, Future.delayed, then() vs async/await
// ============================================================================

class EventLoopDemoScreen extends StatefulWidget {
  const EventLoopDemoScreen({super.key});

  @override
  State<EventLoopDemoScreen> createState() => _EventLoopDemoScreenState();
}

class _EventLoopDemoScreenState extends State<EventLoopDemoScreen> {
  final List<String> _logs = [];
  bool _isRunning = false;

  void _addLog(String message) {
    setState(() {
      _logs.add('${DateTime.now().toIso8601String().substring(11, 19)} - $message');
    });
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
  }

  /// Demonstração do fluxo de execução com async e await
  Future<void> _executarComAsyncAwait() async {
    _clearLogs();
    setState(() => _isRunning = true);

    _addLog('1. [Síncrono] Início da função');

    // A palavra-chave await pausa esta função, mas libera o Event Loop
    _addLog('2. [Assíncrono] Chamando Future.delayed(2s)...');
    final resultado = await Future.delayed(
      const Duration(seconds: 2),
          () => 'Dados recebidos do servidor!',
    );

    _addLog('3. [Assíncrono] Retorno do await: "$resultado"');
    _addLog('4. [Síncrono] Fim da função');

    if (mounted) {
      setState(() => _isRunning = false);
    }
  }

  /// Demonstração do fluxo tradicional utilizando .then()
  void _executarComThen() {
    _clearLogs();
    setState(() => _isRunning = true);

    _addLog('1. [Síncrono] Início da chamada .then()');

    Future.delayed(const Duration(seconds: 2), () {
      return 'Dados via .then()!';
    }).then((valor) {
      _addLog('3. [Callback] .then executado com: "$valor"');
    }).catchError((erro) {
      _addLog('Erro: $erro');
    }).whenComplete(() {
      _addLog('4. [whenComplete] Operação finalizada.');
      if (mounted) {
        setState(() => _isRunning = false);
      }
    });

    // Observe que este log roda ANTES do conteúdo do .then(), pois o then é assíncrono
    _addLog('2. [Síncrono] Linha imediatamente seguinte ao Future (não bloqueia!)');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '1. A Thread Única e o Event Loop',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'O Dart é single-threaded. Operações demoradas são enfileiradas no '
                'Event Loop como um Future, permitindo que a interface permaneça fluida e sem travamentos.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isRunning ? null : _executarComAsyncAwait,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('async / await'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isRunning ? null : _executarComThen,
                  icon: const Icon(Icons.call_split),
                  label: const Text('then() / catch'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Console de Execução (Logs):',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              TextButton(
                onPressed: _logs.isEmpty ? null : _clearLogs,
                child: const Text('Limpar'),
              )
            ],
          ),
          Container(
            height: 220,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E), // Visual de terminal escuro
              borderRadius: BorderRadius.circular(8),
            ),
            child: _logs.isEmpty
                ? const Center(
              child: Text(
                'Pressione um dos botões acima para ver a ordem de execução no Event Loop.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 13),
              ),
            )
                : ListView.builder(
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    _logs[index],
                    style: const TextStyle(
                      color: Color(0xFF4AF626), // Verde terminal
                      fontFamily: 'monospace',
                      fontSize: 13,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MÓDULO 2: StatefulWidget com initState, flags de controle e mounted
// ============================================================================

class StatefulAsyncScreen extends StatefulWidget {
  const StatefulAsyncScreen({super.key});

  @override
  State<StatefulAsyncScreen> createState() => _StatefulAsyncScreenState();
}

class _StatefulAsyncScreenState extends State<StatefulAsyncScreen> {
  // Flags de controle de estado manual
  bool _isLoading = false;
  String? _errorMessage;
  String? _userData;

  @override
  void initState() {
    super.initState();
    // BOAS PRÁTICAS: Chamadas de carregamento inicial devem acontecer no initState,
    // e NUNCA diretamente dentro do método build()!
    _carregarDadosUsuario(simularErro: false);
  }

  /// Simula a requisição a uma API remota com tratamento de erros e verificação de montagem
  Future<void> _carregarDadosUsuario({required bool simularErro}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _userData = null;
    });

    try {
      // Simula 2 segundos de latência de rede
      await Future.delayed(const Duration(seconds: 2));

      if (simularErro) {
        throw Exception('Erro 500: Falha ao conectar ao servidor remoto.');
      }

      final resultado = 'Jales Anderson (Professor & Desenvolvedor)';

      // CUIDADO DIDÁTICO ESSENCIAL:
      // Se a resposta chegar após o usuário ter saído da tela, o widget é desmontado.
      // Chamar setState() em um State desmontado lança uma exceção no Flutter.
      if (!mounted) return;

      setState(() {
        _userData = resultado;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '2. Abordagem Clássica: StatefulWidget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Gerenciamento manual com variáveis booleanas (_isLoading), '
                'tratamento try/catch e a verificação defensiva "if (!mounted) return;".',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 24),

          // Área visual do estado (Loading / Erro / Conteúdo)
          Expanded(
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildConteudoDoEstado(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Botões de ação didáticos
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isLoading
                      ? null
                      : () => _carregarDadosUsuario(simularErro: false),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Simular Sucesso'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: _isLoading
                      ? null
                      : () => _carregarDadosUsuario(simularErro: true),
                  icon: const Icon(Icons.error_outline),
                  label: const Text('Simular Falha'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Constrói a interface com base nas flags de estado controladas manualmente
  Widget _buildConteudoDoEstado() {
    if (_isLoading) {
      return const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Buscando dados no servidor...',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }

    if (_errorMessage != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 48),
          const SizedBox(height: 12),
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 15),
          ),
        ],
      );
    }

    if (_userData != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.account_circle, color: Color(0xFF02569B), size: 54),
          const SizedBox(height: 12),
          Text(
            _userData!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Dados carregados com sucesso no initState().',
            style: TextStyle(color: Colors.green, fontSize: 13),
          ),
        ],
      );
    }

    return const Text('Nenhum dado carregado.');
  }
}

// ============================================================================
// MÓDULO 3: Abordagem Moderna: FutureBuilder<T> e AsyncSnapshot<T>
// ============================================================================

class FutureBuilderScreen extends StatefulWidget {
  const FutureBuilderScreen({super.key});

  @override
  State<FutureBuilderScreen> createState() => _FutureBuilderScreenState();
}

class _FutureBuilderScreenState extends State<FutureBuilderScreen> {
  // BOAS PRÁTICAS: A variável do Future DEVE ser mantida no State para
  // não ser re-executada acidentalmente toda vez que a tela for reconstruída.
  late Future<List<String>> _linguagensFuture;

  @override
  void initState() {
    super.initState();
    _linguagensFuture = _buscarLinguagens(simularErro: false);
  }

  /// Método assíncrono que busca a lista de tecnologias
  Future<List<String>> _buscarLinguagens({required bool simularErro}) async {
    await Future.delayed(const Duration(seconds: 2));

    if (simularErro) {
      throw Exception('Não foi possível obter a lista do repositório remoto.');
    }

    return [
      'Dart (Linguagem oficial do Flutter)',
      'Kotlin (Android nativo)',
      'Swift (iOS nativo)',
      'TypeScript (Web & Node.js)',
      'Python (Ciência de Dados & Backend)',
    ];
  }

  /// Atualiza o Future para recarregar o widget FutureBuilder
  void _recarregar({required bool comErro}) {
    setState(() {
      _linguagensFuture = _buscarLinguagens(simularErro: comErro);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '3. Abordagem Reativa: FutureBuilder',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'O FutureBuilder reconstrói a UI automaticamente com base no AsyncSnapshot '
                '(ConnectionState, hasError e hasData), sem necessidade de setState manual.',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),

          // Botões de teste didático
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _recarregar(comErro: false),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Recarregar'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                  onPressed: () => _recarregar(comErro: true),
                  icon: const Icon(Icons.warning_amber),
                  label: const Text('Forçar Erro'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // IMPLEMENTAÇÃO DO PADRÃO DEFENSIVO DO FUTUREBUILDER
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<List<String>>(
                  future: _linguagensFuture,
                  builder: (context, snapshot) {
                    // 1. Estado de Espera (A requisição está em trânsito)
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              'Future em progresso (ConnectionState.waiting)...',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      );
                    }

                    // 2. Estado de Erro (O Future completou com exceção)
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.cloud_off, color: Colors.red, size: 48),
                            const SizedBox(height: 8),
                            Text(
                              'snapshot.error:\n${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red, fontSize: 14),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _recarregar(comErro: false),
                              child: const Text('Tentar Novamente'),
                            ),
                          ],
                        ),
                      );
                    }

                    // 3. Estado de Sucesso (O Future entregou os dados)
                    if (snapshot.hasData) {
                      final lista = snapshot.data!;

                      if (lista.isEmpty) {
                        return const Center(child: Text('Nenhum registro encontrado.'));
                      }

                      return ListView.separated(
                        itemCount: lista.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text('${index + 1}'),
                            ),
                            title: Text(lista[index]),
                          );
                        },
                      );
                    }

                    // 4. Fallback de segurança
                    return const Center(child: Text('Sem dados disponíveis.'));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MÓDULO 4: Requisições Concorrentes com Future.wait
// ============================================================================

class FutureWaitScreen extends StatefulWidget {
  const FutureWaitScreen({super.key});

  @override
  State<FutureWaitScreen> createState() => _FutureWaitScreenState();
}

class _FutureWaitScreenState extends State<FutureWaitScreen> {
  bool _carregando = false;
  String _tempoGasto = '';
  List<String> _resultados = [];

  // Simulação de serviço 1 (Demora 2 segundos)
  Future<String> _buscarPerfil() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Perfil: Jales Monteiro';
  }

  // Simulação de serviço 2 (Demora 1.5 segundos)
  Future<String> _buscarNotificacoes() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return 'Notificações: 4 não lidas';
  }

  // Simulação de serviço 3 (Demora 1 segundo)
  Future<String> _buscarConfiguracoes() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Configurações: Modo Escuro Ativado';
  }

  /// Executa as 3 tarefas de forma sequencial (uma após a outra = ~4.5s)
  Future<void> _executarSequencial() async {
    setState(() {
      _carregando = true;
      _resultados = [];
      _tempoGasto = 'Processando sequencialmente...';
    });

    final stopwatch = Stopwatch()..start();

    // Uma espera a outra terminar
    final perfil = await _buscarPerfil();
    final notificacoes = await _buscarNotificacoes();
    final configs = await _buscarConfiguracoes();

    stopwatch.stop();

    if (!mounted) return;
    setState(() {
      _carregando = false;
      _tempoGasto = 'Tempo Total Sequencial: ${stopwatch.elapsedMilliseconds} ms (~4.5s)';
      _resultados = [perfil, notificacoes, configs];
    });
  }

  /// Executa as 3 tarefas em paralelo com Future.wait (tempo = o maior deles = ~2s)
  Future<void> _executarParalelo() async {
    setState(() {
      _carregando = true;
      _resultados = [];
      _tempoGasto = 'Processando em paralelo com Future.wait...';
    });

    final stopwatch = Stopwatch()..start();

    // Todas iniciam juntas no Event Loop e aguardamos o término do grupo
    final respostas = await Future.wait([
      _buscarPerfil(),
      _buscarNotificacoes(),
      _buscarConfiguracoes(),
    ]);

    stopwatch.stop();

    if (!mounted) return;
    setState(() {
      _carregando = false;
      _tempoGasto = 'Tempo Total com Future.wait: ${stopwatch.elapsedMilliseconds} ms (~2.0s)';
      _resultados = respostas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '4. Otimização com Future.wait',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Compare a diferença entre executar 3 requisições independentes '
                'de modo sequencial (uma após a outra) versus em paralelo usando Future.wait().',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _carregando ? null : _executarSequencial,
                  child: const Text('Sequencial (~4.5s)'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _carregando ? null : _executarParalelo,
                  child: const Text('Future.wait (~2.0s)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_carregando)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: CircularProgressIndicator(),
              ),
            ),
          if (_tempoGasto.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Text(
                _tempoGasto,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF02569B),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          if (_resultados.isNotEmpty)
            Card(
              child: Column(
                children: _resultados
                    .map(
                      (item) => ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(item),
                  ),
                )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
