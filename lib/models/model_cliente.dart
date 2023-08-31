import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_voyage/models/model_contrato.dart';
import 'package:dartt_voyage/models/model_movimento.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_cliente.g.dart';

@JsonSerializable()
class ClienteModel {
  String? id;
  String? nome;
  String? rg;
  String? cpf;
  String? nasc;
  String? civil;
  String? pai;
  String? mae;
  String? endereco;
  String? numero;
  String? cep;
  String? bairro;
  String? cidade;
  String? uf;
  String? fone;
  String? email;
  String? senha;
  String? senhaConfirm;
  String? obs;
  String? typeUser;
  bool active;
  double saldoAtual;
  List<MovimentoModel>? movimentos;
  List<ContratoModel>? contratos;

  ClienteModel({
    this.id,
    this.nome,
    this.rg,
    this.cpf,
    this.nasc,
    this.civil,
    this.pai,
    this.mae,
    this.endereco,
    this.cep,
    this.bairro,
    this.cidade,
    this.uf,
    this.fone,
    this.email,
    this.obs,
    this.numero,
    this.senha,
    this.senhaConfirm,
    this.active = true,
    this.saldoAtual = 0,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) =>
      _$ClienteModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClienteModelToJson(this);

  factory ClienteModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ClienteModel.fromJson(data);
  }
}
