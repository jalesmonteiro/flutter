import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: FormExampleScreen()));

class FormExampleScreen extends StatefulWidget {
  @override
  _FormExampleScreenState createState() => _FormExampleScreenState();
}

class _FormExampleScreenState extends State<FormExampleScreen> {
  // Chave global para acessar o estado do formulário
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para campos de entrada
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Controlador para campo somente leitura de data
  final TextEditingController _dateController = TextEditingController();

  // Variáveis para os demais campos
  String? _selectedGender;
  bool _acceptTerms = false;
  bool _receiveNewsletter = false;
  String? _favoriteColor;
  String? _selectedRadioOption;
  double _sliderValue = 50;

  // Lista de opções para Dropdown
  final List<String> _genders = ['Masculino', 'Feminino', 'Outro'];
  final List<String> _colors = ['Azul', 'Verde', 'Vermelho'];

  // Função para selecionar data usando showDatePicker
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Necessário setState pois altera o valor exibido
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Função de submissão: pode ser adaptada para API, banco ou navegação
  void _submitForm(String action) {
    if (_formKey.currentState!.validate()) {
      // Salva os campos do formulário
      _formKey.currentState!.save();

      // Exemplo de envio para API
      if (action == 'api') {
        // Aqui você faria um POST usando http, por exemplo
        // http.post('https://api.exemplo.com/form', body: {...});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dados enviados para API!')),
        );
      }
      // Exemplo de salvar em banco local (simulado)
      else if (action == 'db') {
        // Aqui você salvaria em um banco local como SQLite
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dados salvos localmente!')),
        );
      }
      // Exemplo de exibir em outra tela
      else if (action == 'show') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => FormResultScreen(
              name: _nameController.text,
              email: _emailController.text,
              gender: _selectedGender,
              date: _dateController.text,
              acceptTerms: _acceptTerms,
              receiveNewsletter: _receiveNewsletter,
              favoriteColor: _favoriteColor,
              radioOption: _selectedRadioOption,
              sliderValue: _sliderValue,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Sempre dispose os controladores para evitar memory leaks
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário Completo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction, // Validação automática[5][16]
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextFormField simples
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  hintText: 'Digite seu nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),

              // TextFormField com validação de email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'exemplo@email.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // DropdownButtonFormField
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gênero',
                  border: OutlineInputBorder(),
                ),
                items: _genders
                    .map((g) => DropdownMenuItem(
                          value: g,
                          child: Text(g),
                        ))
                    .toList(),
                onChanged: (value) {
                  // Necessário setState pois altera o valor selecionado
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Selecione um gênero' : null,
              ),
              const SizedBox(height: 16),

              // TextFormField só leitura + showDatePicker
              GestureDetector(
                onTap: _pickDate,
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Data de nascimento',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Selecione uma data' : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // SwitchListTile para receber newsletter
              SwitchListTile(
                title: const Text('Receber newsletter'),
                value: _receiveNewsletter,
                onChanged: (value) {
                  setState(() {
                    _receiveNewsletter = value;
                  });
                },
              ),
              const SizedBox(height: 8),

              // CheckboxListTile para aceitar termos
              CheckboxListTile(
                title: const Text('Aceito os termos de uso'),
                value: _acceptTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                },
                subtitle: !_acceptTerms
                    ? const Text(
                        'Obrigatório aceitar os termos',
                        style: TextStyle(color: Colors.red),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 8),

              // Dropdown extra (cor favorita)
              DropdownButtonFormField<String>(
                value: _favoriteColor,
                decoration: const InputDecoration(
                  labelText: 'Cor favorita',
                  border: OutlineInputBorder(),
                ),
                items: _colors
                    .map((c) => DropdownMenuItem(
                          value: c,
                          child: Text(c),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _favoriteColor = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Selecione uma cor' : null,
              ),
              const SizedBox(height: 16),

              // RadioListTile para opção exclusiva
              const Text('Como conheceu o app?'),
              RadioListTile<String>(
                title: const Text('Indicação'),
                value: 'Indicação',
                groupValue: _selectedRadioOption,
                onChanged: (value) {
                  setState(() {
                    _selectedRadioOption = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Redes sociais'),
                value: 'Redes sociais',
                groupValue: _selectedRadioOption,
                onChanged: (value) {
                  setState(() {
                    _selectedRadioOption = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Pesquisa Google'),
                value: 'Pesquisa Google',
                groupValue: _selectedRadioOption,
                onChanged: (value) {
                  setState(() {
                    _selectedRadioOption = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nível de satisfação:'),
                  Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: _sliderValue.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Botões de submissão
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Enviar para API'),
                    onPressed: () => _submitForm('api'),
                  ),
                  ElevatedButton(
                    child: const Text('Salvar Local'),
                    onPressed: () => _submitForm('db'),
                  ),
                  ElevatedButton(
                    child: const Text('Exibir Resultado'),
                    onPressed: () => _submitForm('show'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Segunda tela para exibir os dados preenchidos
class FormResultScreen extends StatelessWidget {
  final String name;
  final String email;
  final String? gender;
  final String date;
  final bool acceptTerms;
  final bool receiveNewsletter;
  final String? favoriteColor;
  final String? radioOption;
  final double sliderValue;

  const FormResultScreen({
    required this.name,
    required this.email,
    required this.gender,
    required this.date,
    required this.acceptTerms,
    required this.receiveNewsletter,
    required this.favoriteColor,
    required this.radioOption,
    required this.sliderValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo do Formulário')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Nome: $name'),
            Text('Email: $email'),
            Text('Gênero: $gender'),
            Text('Data de nascimento: $date'),
            Text('Aceitou termos: ${acceptTerms ? "Sim" : "Não"}'),
            Text('Receber newsletter: ${receiveNewsletter ? "Sim" : "Não"}'),
            Text('Cor favorita: $favoriteColor'),
            Text('Como conheceu o app: $radioOption'),
            Text('Satisfação: ${sliderValue.round()}'),
          ],
        ),
      ),
    );
  }
}
