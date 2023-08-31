import 'package:dartt_voyage/models/model_cliente.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_movimento.g.dart';

@JsonSerializable()
class MovimentoModel {
  String? id;
  double? valor;
  String? dataMovimento;
  ClienteModel? usuarioMovimento;
  String? tipo;

  MovimentoModel(
      {this.id,
      this.valor,
      this.dataMovimento,
      this.usuarioMovimento,
      this.tipo});

  factory MovimentoModel.fromJson(Map<String, dynamic> json) =>
      _$MovimentoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovimentoModelToJson(this);
}
