final TextEditingController _nomeController = TextEditingController();
final TextEditingController _emailController = TextEditingController();

void _salvarDados() {
  String nome = _nomeController.text;
  String email = _emailController.text;
  // Aqui você pode processar, enviar para API, etc.
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Dados salvos: $nome, $email')),
  );
}

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _nomeController,
        decoration: InputDecoration(labelText: 'Nome'),
      ),
      TextFormField(
        controller: _emailController,
        decoration: InputDecoration(labelText: 'E-mail'),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _salvarDados(); // Salva manualmente usando os controladores
          }
        },
        child: Text('Salvar'),
      ),
    ],
  ),
)


