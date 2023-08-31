import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:dartt_voyage/models/model_modelo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_contrato.g.dart';

@JsonSerializable()
class ContratoModel {
  String? id;
  ClienteModel? cliente;
  ModeloModel? modelo;
  String? dataAssinatura;
  String? dataValidade;
  String? ip;
  String? browser;
  String? latitude;
  String? longitude;
  String? imagemAssinatura;
  String? status;

  ContratoModel(
      {this.id,
      this.cliente,
      this.modelo,
      this.dataAssinatura,
      this.dataValidade,
      this.ip,
      this.browser,
      this.latitude,
      this.longitude,
      this.imagemAssinatura,
      this.status});

  factory ContratoModel.fromJson(Map<String, dynamic> json) =>
      _$ContratoModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContratoModelToJson(this);
}
