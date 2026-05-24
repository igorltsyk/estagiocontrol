import 'package:flutter/material.dart';
import '../controller/alunoController.dart';
import 'package:estagio_control/app/view/homePage.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final AlunoController controller = AlunoController();
  
  final TextEditingController rgmController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  String tipoUsuario = 'aluno';

  void cadastrar() async {
    if (_formKey.currentState!.validate()) {
      String? erro = await controller.cadastrarAluno(
        rgm: rgmController.text.trim(),
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
        nome: nomeController.text.trim(),
      );

      if (erro == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erro)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estagio Controll"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // DROPDOWN DE TIPO DE USUÁRIO
              DropdownButtonFormField(
                value: tipoUsuario,
                items: const [
                  DropdownMenuItem(
                    value: 'aluno',
                    child: Text('Aluno'),
                  ),
                  DropdownMenuItem(
                    value: 'supervisor',
                    child: Text('Supervisor'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    tipoUsuario = value.toString();
                  });
                },
              ),
              const SizedBox(height: 20),

              // CAMPO RGM
              TextFormField(
                controller: rgmController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "RGM",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite o RGM";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // CAMPO NOME
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite o nome";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // CAMPO EMAIL
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return "Digite um email válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // CAMPO SENHA
              TextFormField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Senha mínima de 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // CAMPO CONFIRMAR SENHA
              TextFormField(
                controller: confirmarSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirmar Senha",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != senhaController.text) {
                    return "As senhas não coincidem";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // BOTÃO CADASTRAR
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade100,
                  ),
                  child: const Text("Cadastrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}