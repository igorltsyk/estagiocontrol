import 'package:flutter/material.dart';
import 'package:estagio_control/app/controller/alunoController.dart';
import 'package:estagio_control/app/view/telaCadastro.dart';
import 'package:estagio_control/app/view/homePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AlunoController controller = AlunoController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String tipoUsuario = 'aluno';

  void entrar() async {
    if (_formKey.currentState!.validate()) {
      String? erro = await controller.loginAluno(
        email: emailController.text.trim(),
        senha: senhaController.text.trim(),
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
        title: const Text("Estagio Control"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite o email";
                  }
                  if (!value.contains('@')) {
                    return "Email inválido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: entrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text("Entrar",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CadastroScreen(),
                    ),
                  );
                },
                child: const Text("Cadastre-se"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}