String nome = '';
String email = '';

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        onSaved: (value) => nome = value ?? '',
        decoration: InputDecoration(labelText: 'Nome'),
      ),
      TextFormField(
        onSaved: (value) => email = value ?? '',
        decoration: InputDecoration(labelText: 'E-mail'),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save(); // Salva todos os campos via onSaved
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Dados salvos: $nome, $email')),
            );
          }
        },
        child: Text('Salvar'),
      ),
    ],
  ),
)


