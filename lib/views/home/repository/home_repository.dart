import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/models/model_movimento.dart';
import 'package:dartt_voyage/views/home/result/home_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fireRef = FirebaseFirestore.instance.collection('cliente');

  Future<void> updateActive({required ClienteModel cliente}) async {
    try {
      await fireRef.doc(cliente.id).update(cliente.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<HomeResult<List<ClienteModel>>> getAllUser() async {
    try {
      final QuerySnapshot snapUsers = await fireRef.get();
      // await fireRef.where('typeUser', isNotEqualTo: 'Administrador').get();

      if (snapUsers.docs.isNotEmpty) {
        List<ClienteModel> data =
            snapUsers.docs.map((d) => ClienteModel.fromDocument(d)).toList();
        for (var element in data) {
          final QuerySnapshot snapMovimentos =
              await fireRef.doc(element.id).collection('movimentos').get();
          element.movimentos = snapMovimentos.docs
              .map((d) => MovimentoModel.fromDocument(d))
              .toList();
          final QuerySnapshot snapContratos =
              await fireRef.doc(element.id).collection('contratos').get();
          element.contratos = snapContratos.docs
              .map((d) => ContratoModel.fromDocument(d))
              .toList();
        }
        return HomeResult<List<ClienteModel>>.success(data);
      } else {
        return HomeResult.error('Não existem usuários cadastrados!');
      }
    } catch (e) {
      return HomeResult.error(
          'Erro ao recuperar os dados do servidor -Usuario-');
    }
  }

  Future<void> updateSaldo({required ClienteModel cliente}) async {
    try {
      MovimentoModel movimentos = MovimentoModel();
      movimentos = cliente.movimentos!.last;
      await fireRef.doc(cliente.id).update(cliente.toJson());
      await fireRef
          .doc(cliente.id)
          .collection('movimentos')
          .add(movimentos.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<HomeResult<List<MovimentoModel>>> getAllMove(
      {required ClienteModel cliente}) async {
    try {
      final QuerySnapshot snapMove = await fireRef
          .doc(cliente.id)
          .collection("movimentos")
          .orderBy("dataMovimento", descending: true)
          .get();

      if (snapMove.docs.isNotEmpty) {
        List<MovimentoModel> data =
            snapMove.docs.map((d) => MovimentoModel.fromDocument(d)).toList();
        data.sort((a, b) => DateTime.parse(
                '${a.dataMovimento!.replaceAll('/', '-').substring(6, 10)}-${a.dataMovimento!.substring(3, 5)}-${a.dataMovimento!.substring(0, 2)}T${a.dataMovimento!.substring(11)}')
            .compareTo(DateTime.parse(
                '${b.dataMovimento!.replaceAll('/', '-').substring(6, 10)}-${b.dataMovimento!.substring(3, 5)}-${b.dataMovimento!.substring(0, 2)}T${b.dataMovimento!.substring(11)}')));
        return HomeResult<List<MovimentoModel>>.success(data);
      } else {
        return HomeResult.error('Não existem usuários cadastrados!');
      }
    } catch (e) {
      return HomeResult.error(
          'Erro ao recuperar os dados do servidor -Usuario-');
    }
  }

  Future<void> deleteContrato(
      {required String contratoId, required clienteId}) async {
    try {
      await fireRef
          .doc(clienteId)
          .collection('contratos')
          .doc(contratoId)
          .delete();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
