import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:dartt_voyage/views/contratos/result/results_contrato.dart';

class ContratoRepository {
  final fireRef = FirebaseFirestore.instance.collection('cliente');
  final fireRefModelo = FirebaseFirestore.instance.collection('modelo');

  Future<String> addContrato(
      {required ClienteModel cliente, required ModeloModel modelo}) async {
    ContratoModel contrato = ContratoModel(cliente: cliente, modelo: modelo);
    final fireContrato = fireRef.doc(cliente.id).collection('contratos');
    contrato.id = fireContrato.doc().id;
    try {
      await fireContrato.doc(contrato.id).set(contrato.toJson());
      return contrato.id!;
    } catch (e) {
      return "ERROR";
    }
  }

  // buscar todas os canais
  Future<ContratoResult<List<ModeloModel>>> getAllModelo() async {
    try {
      final QuerySnapshot snapModelo = await fireRefModelo.get();

      if (snapModelo.docs.isNotEmpty) {
        List<ModeloModel> data =
            snapModelo.docs.map((d) => ModeloModel.fromDocument(d)).toList();
        return ContratoResult<List<ModeloModel>>.success(data);
      } else {
        return ContratoResult.error('Não existem modelos cadastrados!');
      }
    } catch (e) {
      return ContratoResult.error(
          'Erro ao buscar dados no servidor --Status--');
    }
  }
}
