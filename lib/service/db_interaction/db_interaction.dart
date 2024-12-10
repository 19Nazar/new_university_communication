import 'package:new_university_communication/models/models.dart';

abstract class DbInteraction {
  Future<DBRespons> create(
      {required Map<String, dynamic> data, required String table_name}) {
    throw UnimplementedError("Not implemented");
  }

  Future<DBRespons> read({
    Object? filter,
    required String table_name,
    String? select,
    String? filterColumn,
  }) {
    throw UnimplementedError("Not implemented");
  }

  Future<DBRespons> update(
      {required String table_name,
      required int id,
      required Map<String, dynamic> data}) {
    throw UnimplementedError("Not implemented");
  }

  Future<DBRespons> delete({
    required int id,
    required String table_name,
  }) {
    throw UnimplementedError("Not implemented");
  }
}
