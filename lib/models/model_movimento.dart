import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_movimento.g.dart';

@JsonSerializable()
class MovimentoModel {
  String? id;
  double? valor;
  String? dataMovimento;
  String? idUsuarioMovimento;
  String? usuarioMovimento;
  String? tipo;

  MovimentoModel(
      {this.id,
      this.valor,
      this.dataMovimento,
      this.usuarioMovimento,
      this.idUsuarioMovimento,
      this.tipo});

  factory MovimentoModel.fromJson(Map<String, dynamic> json) =>
      _$MovimentoModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovimentoModelToJson(this);

  factory MovimentoModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return MovimentoModel.fromJson(data);
  }
}
