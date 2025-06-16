import 'package:flutter/material.dart';

// Ponto de entrada principal da aplicação.
void main() {
  runApp(const Navegation1());
}

// Widget raiz da aplicação.
class Navegation1 extends StatelessWidget {
  const Navegation1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Aluno',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Define um estilo visual mais moderno para os componentes.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        brightness: Brightness.dark, // Tema escuro para melhor visualização
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(), // A tela inicial da aplicação.
    );
  }
}

// --- Tela Principal (HomePage) ---
// Onde o aluno insere os dados.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controlador para o campo de texto do nome.
  final _nameController = TextEditingController();

  // Lista de opções para o Dropdown.
  final List<String> _periodos = [
    '1º Período',
    '2º Período',
    '3º Período',
    '4º Período',
    '5º Período',
    '6º Período'
  ];

  // Variável para armazenar o período selecionado no Dropdown.
  String? _selectedPeriodo;

  @override
  void initState() {
    super.initState();
    // Define o valor inicial do Dropdown.
    _selectedPeriodo = _periodos.first;
  }

  // Libera o controlador de texto da memória quando o widget é descartado.
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // Função para lidar com o envio dos dados.
  void _submitData() {
    final enteredName = _nameController.text;

    // Validação simples para garantir que o nome não está vazio.
    if (enteredName.isEmpty || _selectedPeriodo == null) {
      // Mostra um snackbar de erro se os campos não estiverem preenchidos.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha o nome e selecione o período.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return; // Interrompe a execução se os dados forem inválidos.
    }

    // 1. Navega para a ProfileScreen usando Navigator.push.
    // Os dados (nome e período) são passados através do construtor da ProfileScreen.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          userName: enteredName,
          periodo: _selectedPeriodo!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro do Aluno'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Campo para inserção do nome.
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome do Aluno',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 20),

              // Dropdown para seleção do período.
              DropdownButtonFormField<String>(
                value: _selectedPeriodo,
                decoration: InputDecoration(
                  labelText: 'Período',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  prefixIcon: const Icon(Icons.school_outlined),
                ),
                items: _periodos.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedPeriodo = newValue;
                  });
                },
              ),
              const SizedBox(height: 40),

              // Botão de envio.
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    )),
                onPressed: _submitData,
                child: const Text('Enviar', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Tela de Perfil (ProfileScreen) ---
// Exibe os dados recebidos da HomePage.
class ProfileScreen extends StatelessWidget {
  // Variáveis para armazenar os dados recebidos.
  final String userName;
  final String periodo;

  // 2. Construtor que exige os parâmetros 'userName' e 'periodo'.
  // Estes valores são obrigatórios para criar uma instância de ProfileScreen.
  const ProfileScreen({
    Key? key,
    required this.userName,
    required this.periodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A AppBar exibe o nome do usuário, como no exemplo.
      appBar: AppBar(
        title: Text('Perfil de $userName'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.check_circle_outline,
                  color: Colors.green, size: 80),
              const SizedBox(height: 20),
              // Mensagem de boas-vindas com os dados recebidos.
              Text(
                'Bem-vindo(a), $userName!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Seu cadastro no $periodo foi realizado com sucesso.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Volta para a tela anterior.
                  Navigator.pop(context);
                },
                child: const Text('Voltar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
