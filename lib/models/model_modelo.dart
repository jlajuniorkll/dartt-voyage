import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_modelo.g.dart';

@JsonSerializable()
class ModeloModel {
  String? id;
  String? titulo;
  String? corpo;

  ModeloModel({
    this.id,
    this.titulo,
    this.corpo,
  });

  factory ModeloModel.fromJson(Map<String, dynamic> json) =>
      _$ModeloModelFromJson(json);

  Map<String, dynamic> toJson() => _$ModeloModelToJson(this);

  factory ModeloModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    data.putIfAbsent('id', () => doc.id);
    return ModeloModel.fromJson(data);
  }
}
