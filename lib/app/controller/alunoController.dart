import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AlunoController {
  
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('usuarios');
  
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> cadastrarAluno({
    required String rgm,
    required String email,
    required String senha,
    required String nome,
  }) async {
    try {
      // cria o usuário com email e senha
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: senha
      );
      

      await _dbRef.child(userCredential.user!.uid).set({
        'nome': nome,
        'rgm': rgm,
        'email': email,
      });
      
      return null; 
    } on FirebaseAuthException catch (e) {
      return e.message; // retorna o erro do firebase caso de errado
    }
  }

  
  Future<String?> loginAluno({
    required String email, 
    required String senha
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return null; 
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          return 'E-mail ou senha incorretos. Verifique seus dados.';
        case 'invalid-email':
          return 'O formato do e-mail é inválido.';
        case 'user-disabled':
          return 'O acesso deste usuário foi desativado.';
        default:
          return 'Erro ao fazer login. Tente novamente mais tarde.';
      }
    }
  }

  
  Future<Map<String, dynamic>?> buscarAluno() async {
    User? user = _auth.currentUser;
    
    if (user != null) {
      
      final snapshot = await _dbRef.child(user.uid).get(); 
      
      if (snapshot.exists) {
        
        return Map<String, dynamic>.from(snapshot.value as Map);
      }
    }
    return null;
  }
}