import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/views/modelos/result/modelo_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModeloRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fireRef = FirebaseFirestore.instance.collection('modelo');

  // salvar os canais
  Future<bool> addModelo({required ModeloModel modelo}) async {
    modelo.id = fireRef.doc().id;
    try {
      await fireRef.doc(modelo.id).set(modelo.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  // buscar todas os canais
  Future<ModeloResult<List<ModeloModel>>> getAllModelo() async {
    try {
      final QuerySnapshot snapModelo = await fireRef.get();

      if (snapModelo.docs.isNotEmpty) {
        List<ModeloModel> data =
            snapModelo.docs.map((d) => ModeloModel.fromDocument(d)).toList();
        return ModeloResult<List<ModeloModel>>.success(data);
      } else {
        return ModeloResult.error('Não existem modelos cadastrados!');
      }
    } catch (e) {
      return ModeloResult.error('Erro ao buscar dados no servidor --Status--');
    }
  }

  // deletar canais
  Future<void> deleteModelo({required String modeloId}) async {
    try {
      await fireRef.doc(modeloId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// editar canais
  Future<bool> updateModelo({required ModeloModel modelo}) async {
    try {
      await fireRef.doc(modelo.id).update(modelo.toJson());
      return true;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return false;
    }
  }
}
