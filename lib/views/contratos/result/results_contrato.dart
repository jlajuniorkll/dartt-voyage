import 'package:freezed_annotation/freezed_annotation.dart';

part 'results_contrato.freezed.dart';

@freezed
class ContratoResult<T> with _$ContratoResult<T> {
  factory ContratoResult.success(T obj) = Success;
  factory ContratoResult.error(String message) = Error;
}
