import 'package:flutter/material.dart';
import 'package:estagio_control/app/controller/alunoController.dart';
import 'package:estagio_control/app/view/telaLogin.dart';

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
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: aluno == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.lightBlue.shade50,
                    child: Icon(
                      Icons.person,
                      size: 65,
                      color: Colors.lightBlue.shade400,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  
                  Text(
                    "${aluno!['nome']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  
                  
                  Text(
                    aluno!['tipo'] ?? 'Aluno',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),

                  
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.badge_outlined, color: Colors.lightBlue.shade400),
                            title: const Text("RGM", style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text("${aluno!['rgm']}", style: const TextStyle(fontSize: 16)),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(height: 1),
                          ),
                          ListTile(
                            leading: Icon(Icons.email_outlined, color: Colors.lightBlue.shade400),
                            title: const Text("E-mail", style: TextStyle(fontWeight: FontWeight.w500)),
                            subtitle: Text("${aluno!['email']}", style: const TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // desloga do sistema e limpa a pilha de telas voltando para o Login
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.red),
                      label: const Text(
                        "Sair da Conta",
                        style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}