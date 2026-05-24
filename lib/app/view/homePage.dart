import 'package:flutter/material.dart';
import 'package:estagio_control/app/controller/alunoController.dart';
import 'package:estagio_control/app/view/telaPerfil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AlunoController controller = AlunoController();
  Map<String, dynamic>? aluno;
  
  String primeiroNome = ""; 

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    aluno = await controller.buscarAluno();
    if (aluno != null && aluno!['nome'] != null) {
      primeiroNome = aluno!['nome'].split(' ')[0];
    }
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, 
      appBar: AppBar(
        title: const Text("Estagio Controll"),
        centerTitle: true,
        backgroundColor:  Colors.lightBlue.shade100,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.account_circle_outlined, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PerfilScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: aluno == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Olá, $primeiroNome!",
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
              
                  const SizedBox(height: 30),

                  
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Horas validadas", 
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black54)
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text("25", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black87)),
                            Text(" / 40h", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.62, // 62%
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade100,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Faltam só 15h para bater a meta do semestre.",
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Formulário de atendimento aberto.")),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Ata de presença",
                            style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),


                  const Text(
                    "Últimos registos",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  
                  
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ListTile(
                      title: const Text("Atendimento supervisionado", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      subtitle: const Text("Validado pela Prof. Angélica", style: TextStyle(fontSize: 13)),
                      trailing: const Text("+ 3h", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                    ),
                  ),

                  
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ListTile(
                      title: const Text("Avaliação clínica", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                      subtitle: const Text("Aguardando aprovação", style: TextStyle(fontSize: 13)),
                      trailing: const Text("+ 4h", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}