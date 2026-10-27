import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: CampoNicknamePage(),
  ));
}

class CampoNicknamePage extends StatefulWidget {
  const CampoNicknamePage({super.key});

  @override
  State<CampoNicknamePage> createState() => _CampoNicknamePageState();
}

class _CampoNicknamePageState extends State<CampoNicknamePage> {
  // 1. Declaração do controlador
  late final TextEditingController _nicknameController;

  String _mensagemStatus = '';

  @override
  void initState() {
    super.initState();
    // 2. Inicialização do controlador
    _nicknameController = TextEditingController();

    // 3. Ouvindo mudanças de texto em tempo real pelo controlador
    _nicknameController.addListener(_aoMudarTexto);
  }

  void _aoMudarTexto() {
  final texto = _nicknameController.text;

  // Lista simples de caracteres permitidos
  const permitidos = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-';

  // Mantém apenas os caracteres válidos
  final textoLimpo = texto.split('').where((caractere) => permitidos.contains(caractere)).join('');

  // Ponto crítico: evita loop infinito
  if (texto != textoLimpo) {
    _nicknameController.value = TextEditingValue(
      text: textoLimpo,
      selection: TextSelection.collapsed(offset: textoLimpo.length),
    );
    return;
  }

  setState(() {
    _mensagemStatus = 'Tamanho atual: ${textoLimpo.length} caracteres';
  });
}

  @override
  void dispose() {
    // 4. Liberação de memória (essencial para evitar memory leak)
    _nicknameController.removeListener(_aoMudarTexto);
    _nicknameController.dispose();
    super.dispose();
  }

  void _limparCampo() {
    // Manipulação direta via controlador
    _nicknameController.clear();
  }

  void _definirNicknamePadrao() {
    // Definindo valor programaticamente e reposicionando o cursor
    _nicknameController.value = const TextEditingValue(
      text: 'player_01',
      selection: TextSelection.collapsed(offset: 9),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nickname & Controladores'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: 'Nickname',
                hintText: 'ex.: user.name-01',
                helperText: 'Apenas letras, números, _, . e -',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
              )
            ),
            const SizedBox(height: 8),
            Text(
              _mensagemStatus,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Lendo o valor armazenado no controlador
                    final nickname = _nicknameController.text;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nickname salvo: $nickname')),
                    );
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Confirmar'),
                ),
                OutlinedButton.icon(
                  onPressed: _limparCampo,
                  icon: const Icon(Icons.clear),
                  label: const Text('Limpar'),
                ),
                OutlinedButton.icon(
                  onPressed: _definirNicknamePadrao,
                  icon: const Icon(Icons.auto_fix_high),
                  label: const Text('Sugerir padrão'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
