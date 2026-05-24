import 'package:flutter/material.dart';
import 'package:estagio_control/app/controller/alunoController.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final AlunoController controller = AlunoController();
  Map<String, dynamic>? aluno;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    aluno = await controller.buscarAluno();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Estagio Controll"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: aluno == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Perfil",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Nome: ${aluno!['nome']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Email: ${aluno!['email']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "RGM: ${aluno!['rgm']}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}