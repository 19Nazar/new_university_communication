import 'package:new_university_communication/service/db_interaction/db_interaction.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:new_university_communication/models/models.dart';

class SupabaseDbInteraction implements DbInteraction {
  late SupabaseClient supabase;

  SupabaseDbInteraction({required SupabaseClient client}) {
    this.supabase = client;
    this.supabase.auth;
  }

  factory SupabaseDbInteraction.defaultInstance() {
    return SupabaseDbInteraction(client: Supabase.instance.client);
  }

  @override
  Future<DBRespons> create(
      {required Map<String, dynamic> data, required String table_name}) async {
    try {
      final response = await supabase.from(table_name).insert(data).select();
      if (response.contains("error")) {
        return DBRespons(status: Status.fail, data: response);
      }
      return DBRespons(status: Status.successful, data: response);
    } catch (error) {
      throw Exception("Error create data: $error");
    }
  }

  @override
  Future<DBRespons> read({
    Object? filter,
    required String table_name,
    String? select = "*",
    String? filterColumn,
  }) async {
    try {
      var query = await supabase.from(table_name).select();

      // if (filter != null && filterColumn != null) {
      //   query = query.eq(filterColumn, filter);
      // }

      // final response = await query;
      // if (response.contains("error")) {
      //   return DBRespons(status: Status.fail, data: response);
      // }
      return DBRespons(status: Status.successful, data: query);
    } catch (error) {
      throw Exception("Error while read db: $error");
    }
  }

  @override
  Future<DBRespons> update(
      {required String table_name,
      required int id,
      required Map<String, dynamic> data}) async {
    try {
      final response =
          await supabase.from(table_name).update(data).eq('id', id).select();
      if (response.contains("error")) {
        return DBRespons(status: Status.fail, data: response);
      }
      return DBRespons(status: Status.successful, data: response);
    } catch (error) {
      throw Exception("Error while update db: $error");
    }
  }

  @override
  Future<DBRespons> delete({
    required int id,
    required String table_name,
  }) async {
    try {
      final response =
          await supabase.from(table_name).delete().eq('id', id).select();
      if (response.contains("error")) {
        return DBRespons(status: Status.fail, data: response);
      }
      return DBRespons(status: Status.successful, data: response);
    } catch (error) {
      throw Exception("Error while update db: $error");
    }
  }
}
