import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/models/model_movimento.dart';
import 'package:dartt_voyage/services/util_services.dart';
import 'package:dartt_voyage/views/auth/result/result_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final utilServices = UtilsServices();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final fireRef = FirebaseFirestore.instance.collection('cliente');

  Future<AuthResult<ClienteModel>> signIn(
      {required ClienteModel cliente}) async {
    if (!cliente.email!.contains("@")) {
      cliente.email = "${cliente.email}@gdsviagemeturismo.com.br";
    }
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: cliente.email!,
        password: cliente.senha!,
      );
      final User? currentUser = result.user ?? auth.currentUser;
      if (currentUser != null) {
        final DocumentSnapshot docUser =
            await fireRef.doc(currentUser.uid).get();
        final ClienteModel clienteModel = ClienteModel.fromDocument(docUser);
        final QuerySnapshot snapMovimentos =
            await fireRef.doc(clienteModel.id).collection('movimentos').get();
        clienteModel.movimentos = snapMovimentos.docs
            .map((d) => MovimentoModel.fromDocument(d))
            .toList();
        final QuerySnapshot snapContratos =
            await fireRef.doc(clienteModel.id).collection('contratos').get();
        clienteModel.contratos = snapContratos.docs
            .map((d) => ContratoModel.fromDocument(d))
            .toList();
        return AuthResult<ClienteModel>.success(clienteModel);
      } else {
        return AuthResult<ClienteModel>.error('Erro ao buscar usuário logado!');
      }
      // await _loadCurrentUser(firebaseUser: result.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(utilServices.getErrorString(e.code));
    }
  }

  Future<AuthResult<ClienteModel>> signUp(
      {required ClienteModel cliente}) async {
    try {
      if (cliente.email == null || cliente.email!.isEmpty) {
        final foneEmail = cliente.fone!.replaceAll(RegExp(r'[^\d]+'), '');
        cliente.email = "$foneEmail@gdsviagemeturismo.com.br";
      }
      final resultEmail =
          await fireRef.where("email", isEqualTo: cliente.email).get();
      if (resultEmail.docs.isEmpty) {
        final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: cliente.email!,
          password: cliente.senha!,
        );
        cliente.id = result.user!.uid;
        addCliente(cliente: cliente);
        return AuthResult<ClienteModel>.success(cliente);
      } else {
        return AuthResult.error('E-mail ou telefone já está cadastrado!');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(utilServices.getErrorString(e.code));
    }
  }

  Future<void> addCliente({required ClienteModel cliente}) async {
    // user.id = fireRef.doc().id; este recupera o id que foi salvo no firebase após persistir
    try {
      await fireRef.doc(cliente.id).set(cliente.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
